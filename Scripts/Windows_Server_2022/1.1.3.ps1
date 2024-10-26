Import-Module ActiveDirectory
$minpassage=Get-ADDefaultDomainPasswordPolicy | Select-Object -Property MinPasswordAge
if ($minpassage.MinpasswordAge.Days -ge 1){
    
    write-output "complied"

}

else {
    write-output "not complied"
}