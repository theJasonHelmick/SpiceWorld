#requires -version 5.1
#requires -module CimCmdlets
#requires -RunAsAdministrator

#added error handling
#added aliases
#expanded object output
Function Get-CimOS {
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
                $hash = [ordered]@{
                    OS             = $item.caption
                    Installed      = $item.InstallDate
                    InstallAge     = New-TimeSpan -Start $item.InstallDate -End (Get-Date)
                    RegisteredUser = $item.RegisteredUser
                    Version        = $item.version
                    Computername   = $item.CSName
                }
                New-Object -TypeName PSObject -Property $hash
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