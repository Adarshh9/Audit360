#!/bin/bash


OUTPUT_FILE="./JSON-Reports/output.json"


initialize_json_file() {
    if [ ! -f "$OUTPUT_FILE" ]; then
        
        echo '[' > "$OUTPUT_FILE"
        
    else
        
        echo ',' >> "$OUTPUT_FILE"
    fi
}
