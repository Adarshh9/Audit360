Import-Module ActiveDirectory

$BenchmarkNumber="1.1.3"
$Description="Ensure 'Maximum password age' is set to '60 or fewer days, but not 0"
$minpassage = Get-ADDefaultDomainPasswordPolicy | Select-Object -Property MinPasswordAge

# Check if the minimum password age is between 1 and 60 days
if ($minpassage.MinPasswordAge.Days -ge 1 -and $minpassage.MinPasswordAge.Days -le 60) {
    $status="Complied"
} else {
    $status="Not Complied"
}

# Output in a structured way
Write-Output "BenchmarkNumber=$BenchmarkNumber"
Write-Output "Status=$status"
Write-Output "Description=$Description"
