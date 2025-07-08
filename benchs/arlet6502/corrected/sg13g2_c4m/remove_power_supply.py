import os
import glob
import re
import sys
import subprocess


def remove_coma(target):
   file = open(target, 'r')
   lines = file.readlines()
   file.close()
   for i, line in enumerate(lines):
        if ".vss(vss)" in line:
            if ".vdd(vdd)," in lines[i-1]:
                    lines[i-2] = lines[i-2].split(',')[0]
   file = open(target, 'w')
   file.writelines(lines)
   file.close()
   return 

  
  
def remove_power_supplies(file):
 with open(file, 'r') as f:
     lines = f.readlines()
 
 new_lines = []
 for line in lines:

     line = re.sub(r'\.vdd\s*\(\s*vdd\s*\)\s*,', '', line)
 
     line = re.sub(r'\.vss\s*\(\s*vss\s*\)', '', line)
 
     if re.match(r'^\s*input\s+vdd\s*;', line):
         continue
     if re.match(r'^\s*input\s+vss\s*;', line):
         continue
     if re.match(r'\s*module\s+\w+\s*\(', line):
         line = re.sub(r'\bvdd\b\s*,\s*', '', line)  
         line = re.sub(r',\s*\bvdd\b', '', line)     
         line = re.sub(r'\bvdd\b', '', line)         
         line = re.sub(r'\bvss\b\s*,\s*', '', line)
         line = re.sub(r',\s*\bvss\b', '', line)
         line = re.sub(r'\bvss\b', '', line)
 
     new_lines.append(line)
 
 with open(file, 'w') as f:
     f.writelines(new_lines)
  
  
  

print(remove_coma('arlet6502_cts_r.v'))
print(remove_power_supplies('arlet6502_cts_r.v'))


