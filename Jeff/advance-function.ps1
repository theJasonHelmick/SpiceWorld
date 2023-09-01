#requires -version 5.1
#requires -module CimCmdlets
#requires -RunAsAdministrator

Function Get-CimOS {
    [CmdletBinding()]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Enter the computername',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string[]]$Computername
    )

    Begin {
        Write-Host 'begin' -ForegroundColor green
    }#begin
    Process {
        #get the operating system information from WMI
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $Computername

        Write-Host "Got $($os.count) results" -ForegroundColor green

        foreach ($item in $os ) {
            $hash = [ordered]@{
                OS           = $item.caption
                Installed    = $item.InstallDate
                Computername = $item.CSName
            }

            New-Object -TypeName PSObject -Property $hash
        } #foreach item
    } #process
    End {
        Write-Host 'end' -ForegroundColor green
    } #end

} #close function