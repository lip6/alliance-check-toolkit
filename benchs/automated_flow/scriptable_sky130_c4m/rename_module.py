###############################################################################
# The top level verilog file should be named with the same name than the top 
# level module. This file renames the input_file and the top level module (that
# should be the first module declarated) with the new_module_name
###############################################################################
import subprocess
def rename_verilog_file_and_module(input_file,new_module_name):
    file = open(input_file,'r')
    lines = file.readlines()
    file.close()
    for i, line in enumerate(lines):
     if (('module' in line) and ('(' in line)):
       tmp = line.split('(')[1]
       if (('parameter' in line) or ('parameter' in lines[i+1])):
        lines[i] =f"module {new_module_name} #("+ tmp
       else: 
        lines[i] =f"module {new_module_name} ("+ tmp
       break   
    cmd=  f'mv {input_file} {new_module_name}.v'
    l= subprocess.getoutput(cmd)
    file = open(f"{new_module_name}.v", 'w')
    file.writelines(lines)
    file.close()
    return
