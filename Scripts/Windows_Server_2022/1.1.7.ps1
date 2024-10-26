Import-Module ActiveDirectory
. .\Scripts\Windows_Server_2022\output_initialization.ps1
Initialize-JsonFile

$BenchmarkNumber="1.1.7"
$Description="Ensure 'Store passwords using reversible encryption' is set to 'Disabled'"

$complex_enabled=Get-ADDefaultDomainPasswordPolicy | Select-Object -Property ReversibleEncryptionEnabled

if($complex_enabled -eq "False" ){

    $status="Complied"
}
else{

    $status="Not Complied"
}

Write-ToJson $BenchmarkNumber $status $Description