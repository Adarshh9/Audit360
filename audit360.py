import os 
import subprocess

def audit():
    for root, dir, files in os.walk("./Scripts/Linux"):
        for file in files:
            full_path = os.path.join(root, file) 
            subprocess.run(['/usr/bin/bash', full_path])
    
    # Append a closing bracket to the JSON file
    json_file_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../Audit360/JSON-Reports/output.json'))
    try:
        with open(json_file_path, 'a') as json_file:
            json_file.write(']')
    except Exception as e:
        print(f"Error writing to {json_file_path}: {e}")
        return False  # Indicate failure if unable to write to the file

    return True  # Return True if all scripts executed successfully and the JSON file was updated

audit()
# if __name__ == "__main__":
#     if audit():
#         print("True")  # Indicate success to the Node.js application
#     else:
#         print("False")  # Indicate failure to the Node.js application
