import os
import glob
import re
import sys
import time
import datetime
import math
import argparse
import subprocess
from rename_module import *
from set_hitas_environement import *
from connectors_placement import *
################design has to be flatten##################
combinational =0
lib ='/users/cao/aoudrhiri/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.ref/StdCellLib/spice/StdCellLib.spi'
#model ='/users/cao/aoudrhiri/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.tech/ngspice_hitas/C4M.Sky130_tt_model_hitas.spice'
#model ='/users/cao/aoudrhiri/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.tech/ngspice_hitas/C4M.Sky130_ss_model_hitas.spice'
model ='/users/cao/aoudrhiri/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.tech/ngspice_hitas/C4M.Sky130_tt_model_hitas.spice'
unit               = 20000
vertical_pitch     = 0.46 #(east/west)
horizontal_pitch   = 0.51 #(north/south)

def get_args():
  ap = argparse.ArgumentParser(
          description     = 'run complete_flow',
          formatter_class = argparse.ArgumentDefaultsHelpFormatter)
  ap.add_argument('-f', '--file',      type=str, default='arlet6502.v'  ,help=' Initial file')
  ap.add_argument('-e', '--entity',    type=str, default='arlet6502'  ,help='entity name wanted')
  arguments = ap.parse_args()
  return arguments


args = get_args()
initial_file = f'{args.file}'
entity = f'{args.entity}'
file = f'{args.entity}.vst'




h_a,v_a= get_area_in_units('./init_template_doDesign.py')


rename_verilog_file_and_module(initial_file,entity)
#routine_with_sta(file,entity,h_a,v_a,horizontal_pitch,vertical_pitch,unit,combinational,lib,model)
routine(file,entity,h_a,v_a,horizontal_pitch,vertical_pitch,unit,combinational)
