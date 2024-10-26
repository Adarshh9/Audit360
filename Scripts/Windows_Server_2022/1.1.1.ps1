Import-Module ActiveDirectory
$count= Get-ADDefaultDomainPasswordPolicy | Select-Object -Property PasswordHistoryCount
if ( $count.PasswordHistoryCount -ge 24 ){
    Write-Output "complied"
}
else {

    Write-Output "Not Complied"
}