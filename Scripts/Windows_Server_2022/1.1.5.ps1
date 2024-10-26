Import-Module ActiveDirectory

$BenchmarkNumber="1.1.5"
$Description="Ensure 'Minimum password length' is set to '14 or more characters'"
$mispassage = Get-ADDefaultDomainPasswordPolicy | Select-Object -Property MinPasswordLength

# Check if the minimum password length is 14 characters or more
if ($mispassage.MinPasswordLength -ge 14) {
    $status="Complied"
} else {
    $status="Not Complied"
}

# Output in a structured way
Write-Output "BenchmarkNumber=$BenchmarkNumber"
Write-Output "Status=$status"
Write-Output "Description=$Description"
