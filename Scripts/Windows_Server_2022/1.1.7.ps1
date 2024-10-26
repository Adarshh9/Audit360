Import-Module ActiveDirectory

$BenchmarkNumber="1.1.7"
$Description="Ensure 'Store passwords using reversible encryption' is set to 'Disabled'"

$reversible_encryption = Get-ADDefaultDomainPasswordPolicy | Select-Object -Property ReversibleEncryptionEnabled

# Check if reversible encryption is disabled
if ($reversible_encryption.ReversibleEncryptionEnabled -eq $false) {
    $status="Complied"
} else {
    $status="Not Complied"
}

# Output in a structured way
Write-Output "BenchmarkNumber=$BenchmarkNumber"
Write-Output "Status=$status"
Write-Output "Description=$Description"
