Import-Module ActiveDirectory

$BenchmarkNumber="1.1.2"
$Description="Ensure 'Maximum password age' is set to '365 or fewer days, but not 0"
$maxpassage=Get-ADDefaultDomainPasswordPolicy | Select-Object -Property MaxPasswordAge

if ($maxpassage.MaxPasswordAge.Days -eq 0) {
    $status="Not Complied"
} else {
    $status="Complied"
}

# Output in a structured way
Write-Output "BenchmarkNumber=$BenchmarkNumber"
Write-Output "Status=$status"
Write-Output "Description=$Description"
