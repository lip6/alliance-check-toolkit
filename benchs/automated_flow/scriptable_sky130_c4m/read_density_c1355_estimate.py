import os
import glob
import re
import sys
import time
import datetime
import math
import argparse
import subprocess


###############################################################################
def get_density(filename):
    with open(filename, 'r') as file:
        lines = file.readlines()
    for i, line in enumerate(lines):
        if 'Effective density' in line:
            density = eval(line.split('%')[0].split()[-1])
    return  density       
def get_placed_area(filename):
    with open(filename, 'r') as file:
        lines = file.readlines()
        side =eval(lines[0])
    return  side*side
def placed_area(entity):
 #return (get_density(f'debug_{entity}.txt') * get_placed_area(f'{entity}.txt'))/100
 return (get_density(f'debug_{entity}.txt'))

cmd = 'ls debug_iscas*> tmp_list.txt'
subprocess.call(cmd, shell=True)
L =[]
with open('tmp_list.txt', 'r') as file:
    lines = file.readlines()
    for i, line in enumerate(lines):
        L.append(line.split('\n')[0])
for i in range(0,len(L)-1):
    with open(f"{L[i]}", 'r') as file:
        lines = file.readlines()
        for j, line in enumerate(lines):
         if "Effective density" in line:
                a= line
         if 'No' in line :
            print(L[i],line,a)
#


#for i in range(1,119):
# print(placed_area(f'iscas85c1355_estimate_{i}')-0.316,f'iscas85c1355_estimate_{i}')
#
#print(placed_area('iscas85c1355_estimate_0')-0.316,'iscas85c1355_estimate_0')
#print(placed_area('iscas85c1355_estimate_1_1')-0.316,'iscas85c1355_estimate_1_1')
#print(placed_area('iscas85c1355_estimate_2_2')-0.316,'iscas85c1355_estimate_2_2')
#print(placed_area('iscas85c1355_estimate_3_3')-0.316,'iscas85c1355_estimate_3_3')
#print(placed_area('iscas85c1355_estimate_4_4')-0.316,'iscas85c1355_estimate_4_4')
#print(placed_area('iscas85c1355_estimate_5_5')-0.316,'iscas85c1355_estimate_5_5')
#print(placed_area('iscas85c1355_estimate_6_6')-0.316,'iscas85c1355_estimate_6_6')
#print(placed_area('iscas85c1355_estimate_7_7')-0.316,'iscas85c1355_estimate_7_7')
#print(placed_area('iscas85c1355_sota')-0.316,'iscas85c1355_sota')
