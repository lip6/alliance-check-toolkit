import os
import glob
import re
import sys
import time
import datetime
import math
import argparse
import subprocess
def generate_db_hitas_file(entity,model):
    file = open('./hitas/template_db.tcl','r',encoding='ISO-8859-1')
    lines = file.readlines()
    file.close()
    for i, line in enumerate(lines):
        lines[i] = line.replace('Â°C', '°C')
        if 'Files to LOAD' in line:
            lines[i+1] =f'avt_LoadFile {model} spice \n'
            lines[i+2] =f'avt_LoadFile ./{entity}_hitas.spi spice \n'
        if 'set fig' in line:
            lines[i] = f'set fig [hitas {entity}] \n'
    db_file =f'./hitas/db_{entity}.tcl'
    file = open(db_file, 'w')
    file.writelines(lines)
    file.close()
    command =f'chmod 777 {db_file}'
    l= subprocess.getoutput(command)
    return

def generate_report_hitas_file(report_file,entity):
    file = open(report_file,'r')
    lines = file.readlines()
    file.close()
    for i, line in enumerate(lines):
        if 'set fig' in line:
            lines[i] = f'set fig [ttv_LoadSpecifiedTimingFigure {entity}] \n'
        if 'set f [fopen' in line:
	        lines[i] = f'set f [fopen {entity}.paths "w+"] \n'
    file = open(report_file, 'w')
    file.writelines(lines)
    file.close()
    return

def modify_spi_file(spi_file,lib):
    file = open(spi_file,'r')
    lines = file.readlines()
    file.close()
    for i, line in enumerate(lines):
        lines[i] = line.replace('.include', '*.include')
    lib_line = f'.include {lib}\n'
    lines.insert(0, lib_line)
    file = open(spi_file, 'w')
    file.writelines(lines)
    file.close()
    return

def modify_hitas_spi_file(template_file,entity,spi_file):
    file = open(template_file,'r')
    lines = file.readlines()
    file.close()
    for i, line in enumerate(lines):
        if '.include' in line:
         lines[i] = f'.include {entity}.spi\n'
    lines.insert(-2, extract_instance_and_power_pin(spi_file,entity))
    file = open(f'./{entity}_hitas.spi', 'w')
    file.writelines(lines)
    file.close()
    return
def extract_instance_and_power_pin(spi_file,entity):
    file = open(spi_file,'r')
    lines = file.readlines()
    file.close()
    instance = ''
    for i, line in enumerate(lines):
        if (('.subckt' in line) and (f'{entity}' in line)):
            instance = line
        if (('NET' in line) and ('vss' in line)):
            vss = int(line.split('=')[0].split('NET')[1])
        if (('NET' in line) and ('vdd' in line)):
            vdd = int(line.split('=')[0].split('NET')[1])
    instanciation = 'Xc' +  instance.split(f'{entity}')[1]
    words = instanciation.split()
    for i in range(len(words)):
        if words[i].isdigit()and int(words[i]) == vdd:
            words[i] = 'evdd'
    for i in range(len(words)):
        if words[i].isdigit()and int(words[i]) == vss:
            words[i] = 'evss'
    instanciation = ' '.join(words)+' '+f'{entity}'+'\n'        
    return instanciation       

#combinational = 1
#lib ='/users/cao/aoudrhiri/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.ref/StdCellLib/spice/StdCellLib.spi'
#model ='/users/cao/aoudrhiri/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.tech/ngspice_hitas/C4M.Sky130_tt_model_hitas.spice'
#entity_to_run ='locked_4_r'
#generate_db_hitas_file('./hitas/db.tcl',entity_to_run)
#generate_report_hitas_file('./hitas/report.tcl',entity_to_run)
#modify_spi_file(f'{entity_to_run}.spi',lib,model)
#modify_hitas_spi_file('template_hitas.spi',entity_to_run,f'{entity_to_run}.spi')
