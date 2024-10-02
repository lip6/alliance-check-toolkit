import os
import glob
import re
import sys
import time
import datetime
import math
import argparse
import subprocess
from connectors_placement import *
combinational =0
lib ='/users/cao/aoudrhiri/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.ref/StdCellLib/spice/StdCellLib.spi'
model ='/users/cao/aoudrhiri/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.tech/ngspice_hitas/C4M.Sky130_tt_model_hitas.spice'


unit               = 20000
vertical_pitch     = 0.46 #(east/west)
horizontal_pitch   = 0.51 #(north/south)
def get_args():
  ap = argparse.ArgumentParser(
          description     = 'Read the data from vst file generated after the synthesis and modify doDesign to place pins',
          formatter_class = argparse.ArgumentDefaultsHelpFormatter)
  #ap.add_argument('-f', '--file',      type=str, default='arlet6502_cts_r.vst'  ,help='vst file')
  ap.add_argument('-e', '--entity',    type=str, default='arlet6502_cts_r'  ,help='entity name in vst file')
  arguments = ap.parse_args()
  return arguments


args = get_args()
entity = f'{args.entity}'
file = f'{args.entity}.vst'
horizontal_area,vertical_area= get_area_in_units('./template_doDesign.py')
h_area = horizontal_area 
v_area = vertical_area

stop = 0

routine_with_sta(file,entity,390,390,horizontal_pitch,vertical_pitch,unit,combinational,lib,model)
if combinational == 1:
 file_to_generate = f'{entity}_r.gds'
else :
 file_to_generate = f'{entity}_cts_r.gds'
cmd_result=  f' ls {file_to_generate}'+';echo ${?} >debug.txt'
os.system(cmd_result)
with open('debug.txt', 'r') as file:
       lines = file.readlines()
       if int(lines[0]) == 0:
         print('work')
       else:
         print('fail too large')
         stop =1

fail = 1
#while (fail == 1 and stop ==0):
# routine(file,entity,h_area,v_area,horizontal_pitch,vertical_pitch,unit,combinational)
# if combinational == 1:
#  file_to_generate = f'{entity}_r.gds'
# else :
#  file_to_generate = f'{entity}_cts_r.gds'
# cmd_result=  f' ls {file_to_generate}'+';echo ${?} >debug.txt'
# os.system(cmd_result)
# with open('debug.txt', 'r') as file:
#        lines = file.readlines()
#        if int(lines[0]) == 0:
#          print('work')
#          fail = 0
#        else:
#          print('fail')
#          fail =1
#          h_area = h_area +50
#          v_area = v_area +50
#fail = 1
#h_area = h_area-50
#v_area = v_area -50
#while (fail == 1 and stop ==0):
# routine(file,entity,h_area,v_area,horizontal_pitch,vertical_pitch,unit,combinational)
# if combinational == 1:
#  file_to_generate = f'{entity}_r.gds'
# else :
#  file_to_generate = f'{entity}_cts_r.gds'
# cmd_result=  f' ls {file_to_generate}'+';echo ${?} >debug.txt'
# os.system(cmd_result)
# with open('debug.txt', 'r') as file:
#        lines = file.readlines()
#        if int(lines[0]) == 0:
#          print('work')
#          fail = 0
#        else:
#          print('fail')
#          fail =1
#          h_area = h_area +10
#          v_area = v_area +10
#
#fail = 1
#h_area = h_area-10
#v_area = v_area -10
#while (fail == 1 and stop ==0):
# routine(file,entity,h_area,v_area,horizontal_pitch,vertical_pitch,unit,combinational)
# if combinational == 1:
#  file_to_generate = f'{entity}_r.gds'
# else :
#  file_to_generate = f'{entity}_cts_r.gds'
# cmd_result=  f' ls {file_to_generate}'+';echo ${?} >debug.txt'
# os.system(cmd_result)
# with open('debug.txt', 'r') as file:
#        lines = file.readlines()
#        if int(lines[0]) == 0:
#          print('work')
#          fail = 0
#        else:
#          print('fail')
#          fail =1
#          h_area = h_area +1
#          v_area = v_area +1
#
#
#
