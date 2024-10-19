import os 
import fnmatch
import subprocess

for root, dir , files in os.walk("./Scripts/Linux/2.2/"):
    for file in files:
        full_path = os.path.join(root, file)
        print(full_path)
        subprocess.run(['/usr/bin/bash',full_path])

    