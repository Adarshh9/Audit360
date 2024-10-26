#!/bin/bash
source "./Scripts/Linux/output_initialization.sh"

initialize_json_file

benchmark_number="2.2.2"
description="Ensuring rsh client is not installed"
rsh=$(which rsh| wc -w)
if [ $rsh -eq "0" ];
then
    status="Complied"

else
    status="Not Complied"   

fi
benchmark=$(cat ./JSON-Reports/output.json | grep $benchmark_number | wc -w)
if [ $benchmark -eq "0" ];
then
    write_to_json
fi
