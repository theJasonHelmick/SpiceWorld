#requires -version 5.1
#requires -module CimCmdlets
#requires -RunAsAdministrator

#add logging transcript
#reformatted Verbose messages
Function Get-CimOS {
    <#
    .SYNOPSIS
    Get operating system information from one or more computers.
    .DESCRIPTION
    This command uses CIM to retrieve operating system information from one or more computers.
    .PARAMETER ComputerName
    Enter the computername like SRV1. You must have administrator rights.
    .PARAMETER Transcript
    Create a transcript log for this command in your TEMP folder.
    .EXAMPLE
    PS C:\> Get-CimOS -ComputerName Win10

    OS             : Microsoft Windows 10 Enterprise Evaluation
    Version        : 10.0.19044
    Installed      : 7/8/2023 11:08:47 AM
    InstallAge     : 5.03:25:43.4148393
    RegisteredUser : Lability
    Computername   : WIN10

    Get OS information from WIN10

    .EXAMPLE
    PS C:\> Get-Content c:\work\computers.txt | Get-CimOS | ConvertTo-json | Out-File c:\work\os.json

    Process a list of computers and convert the results to JSON.

    .LINK
    Get-CimInstance

    .NOTES

    This command has an alias of gcos.

    Last updated July 2023
    version 1.1.0
    Call S.Claus at x1225 for assistance
    #>

    [CmdletBinding()]
    [Alias('gcos')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Enter the computername like SRV1. You must have administrator rights.',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('Name', 'CN')]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^\w+$')]
        [string[]]$Computername,

        [Parameter(HelpMessage = 'Create a transcript log for this command')]
        [switch]$Transcript
    )

    Begin {
        Function fmtDate {
            # a private nested helper function to format the date
            #7/20/2023 3:40PM Fixed format string - JDH v1.1.1
            Get-Date -Format 'yyyy-MM-dd hh:mm:ss:ffff'
        }

        If ($Transcript) {
            $file = '{0}_{1}_log.txt' -f $MyInvocation.MyCommand, (Get-Date -Format yyyyMMdd-HHmmss)
            $TransPath = Join-Path -Path $env:TEMP -ChildPath $file
            [void](Start-Transcript -Path $TransPath)
            $TransRunning = $True
        } #if transcript
        $scriptVer = '1.1.1'
        Write-Verbose "[$(fmtDate) BEGIN  ] Starting $($MyInvocation.MyCommand) v$ScriptVer"
        Write-Verbose "[$(fmtDate) BEGIN  ] Running under PS $($PSVersionTable.PSVersion)"
        Write-Verbose "[$(fmtDate) BEGIN  ] Running as user $($env:userdomain)\$($env:USERNAME) on computer $($env:COMPUTERNAME.ToUpper())"
        #define a hashtable of parameters for Get-CimInstance
        $splat = @{
            ClassName     = 'Win32_OperatingSystem'
            ComputerName  = $null
            ErrorAction   = 'Stop'
            ErrorVariable = '+ev'
        }
        Write-Verbose "[$(fmtDate) BEGIN  ] Initializing arrays"
        #initialize an empty array for warnings
        $warn = @()
        #initialize and empty array for errors
        $ev = @()
    }#begin
    Process {
        #get the operating system information from WMI
        foreach ($computer in $computername) {
            $splat.ComputerName = $computer
            Write-Verbose "[$(fmtDate) PROCESS] Querying $($splat.ClassName) on $($computer.ToUpper())"
            Try {
                $item = Get-CimInstance @splat
            }
            Catch {
                Write-Verbose "[$(fmtDate) PROCESS] There was an error for $($computer.ToUpper())"
                $warn += "Unable to query $($computer.ToUpper()). $($_.Exception.Message)"
            }
            If ($item.caption) {
                [PSCustomObject]@{
                    OS             = $item.caption
                    Version        = $item.version
                    Installed      = $item.InstallDate
                    InstallAge     = New-TimeSpan -Start $item.InstallDate -End (Get-Date)
                    RegisteredUser = $item.RegisteredUser
                    Computername   = $item.CSName
                }
            }
        } #foreach computer
    } #process
    End {
        if ($warn.count -gt 0) {
            $warn | Write-Warning
        }
        if ($ev.count -gt 0) {
            $file = '{0}_{1}.xml' -f $MyInvocation.MyCommand, (Get-Date -Format yyyyMMdd-HHmmss)
            $errPath = Join-Path -Path $env:TEMP -ChildPath $file
            $ev | Export-Clixml -Path $errPath
            Write-Verbose "[$(fmtDate) END    ] $($ev.count) errors exported to $errPath"
        }
        Write-Verbose "[$(fmtDate) END    ] Ending $($MyInvocation.MyCommand)"

        if ($TransRunning) {
            Write-Verbose "[$(fmtDate) END     ] A log file was created at $TransPath"
            [void](Stop-Transcript)
        }
    } #end

} #close function

<#
Changelog


#>