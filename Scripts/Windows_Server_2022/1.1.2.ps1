Import-Module ActiveDirectory
. .\Scripts\Windows_Server_2022\output_initialization.ps1

$BenchmarkNumber="1.1.2"
$Description="Ensure 'Maximum password age' is set to '365 or fewer days, but not 0"
Initialize-JsonFile
$maxpassage=Get-ADDefaultDomainPasswordPolicy | Select-Object -Property MaxPasswordAge
if ($maxpassage.MaxPasswordAge.Days -eq 0){
      $status="Not Complied"

}

else {
    $status="Complied"
}

Write-ToJson $BenchmarkNumber $status $Description