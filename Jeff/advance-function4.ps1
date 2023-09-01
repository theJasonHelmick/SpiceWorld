#requires -version 5.1
#requires -module CimCmdlets
#requires -RunAsAdministrator

#Using PSCustomObject
#comment-based help
#change log for stand-alone functions

Function Get-CimOS {

    <#
    .SYNOPSIS
    Get operating system information from one or more computers.
    .DESCRIPTION
    This command uses CIM to retrieve operating system information from one or more computers.
    .PARAMETER ComputerName
    Enter the computername like SRV1. You must have administrator rights.
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
    version 1.0.0
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
        [string[]]$Computername
    )

    Begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand)"
        Write-Verbose "Running under PS $($PSVersionTable.PSVersion)"
        Write-Verbose "Running as user $($env:userdomain)\$($env:USERNAME) on computer $($env:COMPUTERNAME.ToUpper())"
        #define a hashtable of parameters for Get-CimInstance
        $splat = @{
            ClassName     = 'Win32_OperatingSystem'
            ComputerName  = $null
            ErrorAction   = 'Stop'
            ErrorVariable = '+ev'
        }
        #initialize an empty array for warnings
        $warn = @()
        #initialize and empty array for errors
        $ev = @()
    }#begin
    Process {
        #get the operating system information from WMI
        foreach ($computer in $computername) {
            $splat.ComputerName = $computer
            Write-Verbose "Querying $($computer.ToUpper())"

            Try {
                $item = Get-CimInstance @splat
            }
            Catch {
                $warn += "Unable to query $($computer.ToUpper()). $($_.Exception.Message)"
            }
            If ($item.caption) {
                #Create a custom object for each operating system instance
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
            Write-Verbose "$($ev.count) errors exported to $errPath"
        }
        Write-Verbose "Ending $($MyInvocation.MyCommand)"
    } #end

} #close function

<#
Changelog


#>