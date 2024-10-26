#!/bin/bash


OUTPUT_FILE="./JSON-Reports/output.json"


initialize_json_file() {
    if [ ! -f "$OUTPUT_FILE" ]; then
        echo '[' > "$OUTPUT_FILE"  # Start a new JSON array
    fi
    
}

write_to_json() {
    # Check if the file is not empty to determine if a comma is needed
    if [ -s "$OUTPUT_FILE" ]; then
        # Remove the last closing bracket and add a comma
        sed -i '$ s/}/},/' "$OUTPUT_FILE"
    fi

    # Append the new JSON object
    echo '{
    "BenchMark": "'"$benchmark_number"'",
    "Status": "'"$status"'",
    "Description": "'"$description"'"
    }' >> "$OUTPUT_FILE"
}