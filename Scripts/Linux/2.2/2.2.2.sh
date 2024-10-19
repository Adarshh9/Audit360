#!/bin/bash

rsh=$(which rsh| wc -w)
if [ $rsh -eq "0" ];
then 
	status="complied"

else
	status="Not complied"
	
fi

echo '{
	"BenchMark":"2.2.2",
	"Status":"'"$status"'",
	"Description":"Ensuring rsh client is not installed"
}'
 >> output.json
