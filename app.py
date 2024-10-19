import os
import subprocess
import json
import streamlit as st

def run_audit_script(script_path):
    # Run the shell script and capture the output
    result = subprocess.run(['/usr/bin/bash', script_path], capture_output=True, text=True)
    # print(result)
    
    # Check if the script executed successfully
    if result.returncode != 0:
        return {"BenchMark": os.path.basename(script_path), "Status": "Error", "Description": f"Script execution failed with return code {result.returncode}"}
    
    # Parse the output as JSON
    try:
        output_json = json.loads(result.stdout)
    except json.JSONDecodeError:
        return {"BenchMark": os.path.basename(script_path), "Status": "Error", "Description": "Failed to parse script output as JSON"}

    return output_json

def run_audit_scripts():
    # Directory containing the scripts
    script_directory = "./Scripts/Linux/2.2/"
    audit_results = []

    # Walk through the directory to find and execute scripts
    for root, dirs, files in os.walk(script_directory):
        for file in files:
            full_path = os.path.join(root, file)
            # Run the audit script and get the result
            audit_result = run_audit_script(full_path)
            audit_results.append(audit_result)
            # print(audit_result,'\n')

    return audit_results

def save_audit_results(results):
    # Save the audit results to a JSON file
    with open('audit_results.json', 'w') as f:
        json.dump(results, f, indent=4)
    return 'audit_results.json'

# Streamlit UI
st.title("Audit Script Executor")
st.write("This tool runs audit scripts and displays the output.")

# Button to start the audit
if st.button("Start Audit"):
    st.write("Running scripts...")
    # Run the audit scripts and get the results
    audit_results = run_audit_scripts()
    # Display each result in the Streamlit UI
    for result in audit_results:
        st.json(result)
    
    # Save the results to a file
    output_file = save_audit_results(audit_results)
    st.write("Audit completed. Results saved to:", output_file)
    
    # Provide a download button for the saved file
    with open(output_file, "rb") as file:
        st.download_button(
            label="Download Audit Results",
            data=file,
            file_name="audit_results.json",
            mime="application/json"
        )
