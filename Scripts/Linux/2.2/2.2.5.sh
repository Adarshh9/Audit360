#!/bin/bash

ldap=$(which ldapsearch| wc -w)
if [ $ldap -eq "0" ];
then 
	status="complied"

else
	status="Not complied"
	
fi

echo '{
	"BenchMark":"2.2.5"
	"Status":"$status"
	"Description":"Ensuring LDAP client is not installed"
}' >> output.json
