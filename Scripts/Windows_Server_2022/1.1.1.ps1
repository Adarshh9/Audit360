Import-Module ActiveDirectory
. .\Scripts\Windows_Server_2022\output_initialization.ps1
Initialize-JsonFile

$BenchmarkNumber="1.1.1"
$Description="Ensure 'Enforce password history' is set to '24 or more password(s)"

$count= Get-ADDefaultDomainPasswordPolicy | Select-Object -Property PasswordHistoryCount
if ( $count.PasswordHistoryCount -ge 24 ){
    $status="Complied"

}
else {

    $status="Not Complied"
}

Write-ToJson $BenchmarkNumber $status $Description