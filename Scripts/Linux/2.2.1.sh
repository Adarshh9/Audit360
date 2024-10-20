#!/bin/bash

source "Scripts/Linux/output_initialization.sh"
initialize_json_file
 
benchmark_number="2.2.1"
description="Ensuring NIS client (ypbind) is not installed"
nis=$(which ypbind| wc -w)
if [ $nis -eq "0" ];
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

