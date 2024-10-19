#!/bin/bash

nis=$(which ypbind | wc -w)
if [ $nis -eq "0" ]; then 
    status="Complied"
else
    status="Not Complied"
fi

# Output JSON-like format
echo '{
    "BenchMark": "2.2.1",
    "Status": "'"$status"'",
    "Description": "Ensuring NIS client (ypbind) is not installed"
}'
 >> output.json
