Import-Module ActiveDirectory
. .\Scripts\Windows_Server_2022\output_initialization.ps1
Initialize-JsonFile

$BenchmarkNumber="1.1.3"
$Description="Ensure 'Maximum password age' is set to '60 or fewer days, but not 0"
$minpassage=Get-ADDefaultDomainPasswordPolicy | Select-Object -Property MinPasswordAge
if (minpassage.MinpasswordAge.Days -ge 1 -and $minpassage.MinpasswordAge.Days -le 60){

    $status="Complied"
}

else {
    $status="Not Complied"
}

Write-ToJson $BenchmarkNumber $status $Description