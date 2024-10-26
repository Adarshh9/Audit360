Import-Module ActiveDirectory

$BenchmarkNumber="1.1.4"
$Description="Ensure 'Minimum password age' is set to '1 or more day(s)'"

$mispassage = Get-ADDefaultDomainPasswordPolicy | Select-Object -Property MinPasswordAge

# Check if the minimum password age is 1 day or more
if ($mispassage.MinPasswordAge.Days -ge 1) {
    $status="Complied"
} elseif ($mispassage.MinPasswordAge.Days -eq 0) {
    $status="Not Complied"
} else {
    $status="Not Complied"  # In case of any unexpected value
}

# Output in a structured way
Write-Output "BenchmarkNumber=$BenchmarkNumber"
Write-Output "Status=$status"
Write-Output "Description=$Description"
