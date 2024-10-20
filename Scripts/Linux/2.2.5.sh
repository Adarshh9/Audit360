#!/bin/bash
source "Scripts/Linux/output_initialization.sh"
initialize_json_file

benchmark_number="2.2.5"
description="Ensuring LDAP client is not installed"
ldap=$(which ldapsearch| wc -w)
if [ $ldap -eq "0" ];
then 
	status="complied"

else
	status="Not complied"
	
fi

benchmark=$(cat /home/user/Audit360/JSON-Reports/output.json | grep $benchmark_number | wc -w)

if [ $benchmark -eq "0" ];
then
    echo '{
    "BenchMark":"'"$benchmark_number"'",
    "Status":"'"$status"'",
    "Description":"'"$description"'"
    }' >> $OUTPUT_FILE
fi