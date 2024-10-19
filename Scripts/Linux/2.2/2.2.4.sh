#!/bin/bash

telnet=$(which telnet| wc -w)
if [ $telnet -eq "0" ];
then 
	status="complied"

else
	status="Not complied"
	
fi

echo '{
	"BenchMark":"2.2.4"
	"Status":"$status"
	"Description":"Ensuring telnet is not installed"
}' >> output.json
