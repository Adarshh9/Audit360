Import-Module ActiveDirectory

. .\Scripts\Windows_Server_2022\output_initialization.ps1
Initialize-JsonFile

$BenchmarkNumber="1.1.4"
$Description="Ensure 'Minimum password age' is set to '1 or more day(s)'"


$mispassage=Get-ADDefaultDomainPasswordPolicy | Select-Object -Property MinPasswordAge

if ($mispassage.MinPasswordAge.Days -ge 1 ){

    $status="Complied"
    


}
elseif ($mispassage.MinPasswordAge.Days -eq 0){
    $status="Not Complied"
}

Write-ToJson $BenchmarkNumber $status $Description