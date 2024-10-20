import os 
import subprocess

for root , dir , files in os.walk("./Scripts/Linux"):
    
    for file in files:
        full_path = os.path.join(root,file) 
        subprocess.run(['/usr/bin/bash',full_path])