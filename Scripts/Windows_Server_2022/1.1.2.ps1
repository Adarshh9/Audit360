Import-Module ActiveDirectory
$maxpassage=Get-ADDefaultDomainPasswordPolicy | Select-Object -Property MaxPasswordAge
if ($maxpassage.MaxPasswordAge.Days -eq 0){
    Write-Output "Not Complied"

}

else {
    Write-Output "Complied"
}