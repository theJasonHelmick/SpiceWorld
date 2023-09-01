#requires -version 5.1
#requires -module CimCmdlets
#requires -RunAsAdministrator

#parameter validation
Function Get-CimOS {
    [CmdletBinding()]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Enter the computername like SRV1',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^\w+$')]
        [string[]]$Computername
    )

    Begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand)"
        Write-Verbose "Running under PS $($PSVersionTable.PSVersion)"
    }#begin
    Process {
        #get the operating system information from WMI
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $Computername

        Write-Verbose "Got $($os.count) results"

        foreach ($item in $os ) {
            $hash = [ordered]@{
                OS           = $item.caption
                Installed    = $item.InstallDate
                Computername = $item.CSName
            } #foreach item

            New-Object -TypeName PSObject -Property $hash
        } #foreach item
    } #process
    End {
        Write-Verbose "Ending $($MyInvocation.MyCommand)"
    } #end

} #close function