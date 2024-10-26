import os
import subprocess
import re

def audit_linux():
    script_directory = "./Scripts/Linux"
    
    
    def natural_sort_key(s):
        
        return [int(text) if text.isdigit() else text for text in re.split(r'(\d+)', s)]
    

    scripts = []
    for root, dirs, files in os.walk(script_directory):
        for file in files:
            if file.endswith('.sh'):
                scripts.append(os.path.join(root, file))
    
    
    scripts.sort(key=lambda x: natural_sort_key(os.path.basename(x)))
    
    
    for script in scripts:
        try:
            print(f"Executing: {script}")
            process = subprocess.Popen(['/usr/bin/bash', script])
            process.wait()
        except subprocess.CalledProcessError as e:
            print(f"Error executing {script}: {e}")
            return False  
    
   
    json_file_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../Audit360/JSON-Reports/output.json'))
    try:
        with open(json_file_path, 'a') as json_file:
            json_file.write(']')
    except Exception as e:
        print(f"Error writing to {json_file_path}: {e}")
        return False

    return True
def audit_windows_server():
    script_directory = "./Scripts/Windows_Server_2022/"
    
    
    def natural_sort_key(s):
        
        return [int(text) if text.isdigit() else text for text in re.split(r'(\d+)', s)]
    

    scripts = []
    for root, dirs, files in os.walk(script_directory):
        for file in files:
            if file.endswith('.sh'):
                scripts.append(os.path.join(root, file))
    
    
    scripts.sort(key=lambda x: natural_sort_key(os.path.basename(x)))
    
    
    for script in scripts:
        try:
            print(f"Executing: {script}")
            process = subprocess.Popen(['C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe', script])
            process.wait()
        except subprocess.CalledProcessError as e:
            print(f"Error executing {script}: {e}")
            return False  
    
   
    json_file_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../Audit360/JSON-Reports/output.json'))
    try:
        with open(json_file_path, 'a') as json_file:
            json_file.write(']')
    except Exception as e:
        print(f"Error writing to {json_file_path}: {e}")
        return False

    return True

if __name__ == "__main__":
    success = audit_linux()
    print("True" if success else "False")
