
return "This is a demo script file."

Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption,InstallDate,CSName

Get-CimInstance -ClassName Win32_OperatingSystem |
Select-Object @{Name="OS";Expression={$_.Caption}},
InstallDate,
@{Name="Computername";Expression={$_.CSName}}
