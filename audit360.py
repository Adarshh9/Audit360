import os
import subprocess
import re

def audit():
    script_directory = "./Scripts/Linux"
    
    # Define a sorting key function to sort the filenames naturally (e.g., 1.1.1, 1.1.2, 1.1.10)
    def natural_sort_key(s):
        # Split based on numbers to achieve natural sorting
        return [int(text) if text.isdigit() else text for text in re.split(r'(\d+)', s)]
    
    # Collect all script files
    scripts = []
    for root, dirs, files in os.walk(script_directory):
        for file in files:
            if file.endswith('.sh'):
                scripts.append(os.path.join(root, file))
    
    # Sort scripts using the natural sort key
    scripts.sort(key=lambda x: natural_sort_key(os.path.basename(x)))
    
    # Execute each script sequentially
    for script in scripts:
        try:
            print(f"Executing: {script}")
            process = subprocess.Popen(['/usr/bin/bash', script])
            process.wait()
        except subprocess.CalledProcessError as e:
            print(f"Error executing {script}: {e}")
            return False  # Stop on the first error and indicate failure
    
    # Append a closing bracket to the JSON file
    json_file_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../Audit360/JSON-Reports/output.json'))
    try:
        with open(json_file_path, 'a') as json_file:
            json_file.write(']')
    except Exception as e:
        print(f"Error writing to {json_file_path}: {e}")
        return False

    return True

# Execute audit process
if __name__ == "__main__":
    success = audit()
    print("True" if success else "False")
