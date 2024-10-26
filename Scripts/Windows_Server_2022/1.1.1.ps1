Import-Module ActiveDirectory

$BenchmarkNumber="1.1.1"
$Description="Ensure 'Enforce password history' is set to '24 or more password(s)"
$count = Get-ADDefaultDomainPasswordPolicy | Select-Object -Property PasswordHistoryCount

if ($count.PasswordHistoryCount -ge 24) {
    $status="Complied"
} else {
    $status="Not Complied"
}

# Output in a structured way
Write-Output "BenchmarkNumber=$BenchmarkNumber"
Write-Output "Status=$status"
Write-Output "Description=$Description"
