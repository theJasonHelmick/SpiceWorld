#requires -version 5.1
#requires -module CimCmdlets
#requires -RunAsAdministrator

Function Get-CimOS {
    Param([string[]]$Computername = $env:COMPUTERNAME)

    #get the operating system information from WMI
    $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $Computername

    Write-Host "Got $($os.count) results" -ForegroundColor green

    foreach ($item in $os ) {
        Write-Host "Processing OS data from $($item.CSName)" -ForegroundColor yellow
        $hash = [ordered]@{
            OS           = $item.caption
            Installed    = $item.InstallDate
            Computername = $item.CSName
        }

        New-Object -TypeName PSObject -Property $hash
    } #foreach item


} #close function