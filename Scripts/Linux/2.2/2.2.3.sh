#!/bin/bash

talk=$(which ypbind| wc -w)
if [ $talk -eq "0" ];
then 
	status="complied"

else
	status="Not complied"
	
fi

echo '{
	"BenchMark":"2.2.3"
	"Status":"$status"
	"Description":"Ensuring talk client is not installed"
}' >> output.json
