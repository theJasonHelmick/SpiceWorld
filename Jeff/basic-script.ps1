#requires -version 5.1
#requires -module CimCmdlets
#requires -RunAsAdministrator

Param([string]$Computername = $env:COMPUTERNAME)

Write-Host "Querying $computername" -ForegroundColor green

#get the operating system information from WMI
$os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $Computername

$hash = [ordered]@{
    OS           = $os.caption
    Installed    = $os.InstallDate
    Computername = $os.CSName
}

New-Object -TypeName PSObject -Property $hash

#$output | ConvertTo-Json | Out-File "c:\work\$computername-os.json"
#Get-os "c:\work\$computername-os.json"

