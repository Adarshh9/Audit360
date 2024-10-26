Import-Module ActiveDirectory
. .\Scripts\Windows_Server_2022\output_initialization.ps1
Initialize-JsonFile

$BenchmarkNumber="1.1.5"
$Description="Ensure 'Minimum password length' is set to '14 or more characters'"
$mispassage=Get-ADDefaultDomainPasswordPolicy | Select-Object -Property MinPasswordLength
if($mispassage.MinPasswordLength -ge 14){

    $status="Complied"

    
}
else{


    $status="Not Complied"
}
Write-ToJson $BenchmarkNumber $status $Description