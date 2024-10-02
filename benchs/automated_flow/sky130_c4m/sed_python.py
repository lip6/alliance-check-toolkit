###############################################################################
#some files are 

import os
import subprocess

directory = "./"
regexp = r's/\(n\)\([0-9]\+\)/\10\2/g'

# List of verilog files
#verilog_files = [f for f in os.listdir(directory) if f.endswith(".v")]
#for fichier in verilog_files:
#    file_path = os.path.join(directory, fichier)
#    subprocess.run(['sed', '-i', regexp, file_path])
#

file_path = 'iscas89s1423_area_90.v' 

subprocess.run(['sed', '-i', regexp, file_path])





