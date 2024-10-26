Import-Module ActiveDirectory
. .\Scripts\Windows_Server_2022\output_initialization.ps1
Initialize-JsonFile

$BenchmarkNumber="1.1.6"
$Description="Ensure 'Password Complexity Requirements' is set to 'enabled'"


$complex_enabled=Get-ADDefaultDomainPasswordPolicy | Select-Object -Property ComplexityEnabled
if($complex_enabled.ComplexityEnabled -eq "True"){
    $status="Complied"
}
else{

    $status="Not Complied"
}
Write-ToJson $BenchmarkNumber $status $Description
