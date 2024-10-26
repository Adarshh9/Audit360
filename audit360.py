import os
import subprocess
import re
import platform
import distro
import json

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

# def audit_windows_server():
#     script_directory = "./Scripts/Windows_Server_2022/"
    
    
#     def natural_sort_key(s):
        
#         return [int(text) if text.isdigit() else text for text in re.split(r'(\d+)', s)]
    

#     scripts = []
#     for root, dirs, files in os.walk(script_directory):
#         for file in files:
#             if file.endswith('.ps1'):
#                 scripts.append(os.path.join(root, file))
    
    
#     scripts.sort(key=lambda x: natural_sort_key(os.path.basename(x)))
    
    
#     for script in scripts:
#         try:
#             print(f"Executing: {script}")
#             process = subprocess.Popen(['C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe', script])
#             process.wait()
#         except subprocess.CalledProcessError as e:
#             print(f"Error executing {script}: {e}")
#             return False  
    
   
#     json_file_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../Audit360/JSON-Reports/output.json'))
#     try:
#         with open(json_file_path, 'a') as json_file:
#             json_file.write(']')
#     except Exception as e:
#         print(f"Error writing to {json_file_path}: {e}")
#         return False

#     return True



def audit_windows_server():
    script_directory = "./Scripts/Windows_Server_2022/"
    
    def natural_sort_key(s):
        return [int(text) if text.isdigit() else text for text in re.split(r'(\d+)', s)]

    scripts = []
    for root, dirs, files in os.walk(script_directory):
        for file in files:
            if file.endswith('.ps1'):
                scripts.append(os.path.join(root, file))

    scripts.sort(key=lambda x: natural_sort_key(os.path.basename(x)))

    results = []

    for script in scripts:
        try:
            print(f"Executing: {script}")
            process = subprocess.Popen(['C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe', script], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout, stderr = process.communicate()

            # Decode output
            output = stdout.decode('utf-8').strip().splitlines()

            # Initialize variables
            benchmark_number = status = description = "Unknown"

            # Parse the output
            for line in output:
                if line.startswith("BenchmarkNumber="):
                    benchmark_number = line.split("=", 1)[1]
                elif line.startswith("Status="):
                    status = line.split("=", 1)[1]
                elif line.startswith("Description="):
                    description = line.split("=", 1)[1]

            results.append({
                "BenchMark": benchmark_number,
                "Status": status,
                "Description": description
            })

        except Exception as e:
            print(f"Error executing {script}: {e}")
            return False  

    # Write results to JSON file
    json_file_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../Audit360/JSON-Reports/output.json'))
    try:
        with open(json_file_path, 'w') as json_file:
            json.dump(results, json_file, indent=4)
    except Exception as e:
        print(f"Error writing to {json_file_path}: {e}")
        return False

    return True


if __name__ == "__main__":
    platform_os= platform.system()
    print(platform_os)
    if platform_os=="Linux":
        audit_linux()
    elif platform_os=="Windows":
        if "Server" in platform.platform():
            audit_windows_server()

