import os
import subprocess

def run_scripts(directory):
    # Initialize a flag to check if all scripts ran successfully
    all_successful = True

    for root, dirs, files in os.walk(directory):
        for file in files:
            full_path = os.path.join(root, file)
            try:
                # Execute the script using subprocess
                result = subprocess.run(['/usr/bin/bash', full_path], check=True, text=True, capture_output=True)
                print(f"Executed {full_path}:\n{result.stdout}")  # Print the output of the executed script
                
            except subprocess.CalledProcessError as e:
                # Print error message if the script fails
                print(f"Error executing {full_path}: {e.stderr}")
                all_successful = False  # Set the flag to false if any script fails

    # Return "1" if all scripts were successful, otherwise return an error code
    if all_successful:
        print("1")  # Indicate success
    else:
        print("0")  # Indicate failure

if __name__ == "__main__":
    run_scripts("./Scripts/Linux")
