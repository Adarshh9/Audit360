#!/bin/bash


OUTPUT_FILE="./JSON-Reports/output.json"


initialize_json_file() {
    if [ ! -f "$OUTPUT_FILE" ]; then
        echo '[' > "$OUTPUT_FILE"  
    fi
    
}

write_to_json() {
    
    if [ -s "$OUTPUT_FILE" ]; then
       
        sed -i '$ s/}/},/' "$OUTPUT_FILE"
    fi

    
    echo '{
    "BenchMark": "'"$benchmark_number"'",
    "Status": "'"$status"'",
    "Description": "'"$description"'"
    }' >> "$OUTPUT_FILE"
}