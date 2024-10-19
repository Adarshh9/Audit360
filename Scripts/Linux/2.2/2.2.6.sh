#!/bin/bash

ftp=$(which ftp| wc -w)
if [ $ftp -eq "0" ];
then 
	status="complied"

else
	status="Not complied"
	
fi

echo '{
	"BenchMark":"2.2.6"
	"Status":"$status"
	"Description":"Ensuring ftp client is not installed"
}' >> output.json
