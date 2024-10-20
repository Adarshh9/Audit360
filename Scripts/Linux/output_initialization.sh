#!/bin/bash


OUTPUT_FILE="JSON-Reports/output.json"


initialize_json_file() {
    if [ ! -f "$OUTPUT_FILE" ]; then
        
        echo '[' > "$OUTPUT_FILE"
        echo "created output.json"
    else
        
        echo ',' >> "$OUTPUT_FILE"
    fi
}
