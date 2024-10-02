import sys
#sys.path.append('../../../../../release/install/lib64/python3.9/site-packages/coriolis/')
from coriolis  import CRL
from coriolis  import Viewer
from coriolis.Hurricane  import Cell
from coriolis.helpers.io  import ErrorMessage
from coriolis.plugins  import rsave
import os
import glob
import re
import sys
import time
import datetime
import math
import argparse
import subprocess
from   coriolis.Hurricane  import DbU, Breakpoint
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, l, u, n
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip
from   coriolis.plugins.core2chip.sky130    import CoreToChip
from coriolis.designflow.technos import setupSky130_c4m
setupSky130_c4m( '../../..', '../../../pdkmaster/C4M.Sky130' )
def get_signals(file,entity):
 # get all the signals --> lines between 'entity' and end 'entity'
 command=f"awk -F: '/entity {entity}/,/end {entity}/ {{print $0}}' {file}"
 l= subprocess.getoutput(command)
 lines = l.split('\n')
 all_signals = {}
 signals_index = 0
 for line in lines:
    # Delete useless spacing
    cleaned_line = line.strip()
    words = cleaned_line.split()
    if ":" in words:
        index = words.index(":")
        signal_name = words[index - 1]
        if (words[index+2]=='bit'):
            size  = 1
            end   = 0
            start = 0
        else:
        #vector of more than one bit
        #works for little endian representation
            end   = int(words[index+2].split('(')[1])
            start = int(words[index+4].split(')')[0])
            size   = end-start+1
        #if (('vss' and 'in' and 'bit') or ('vdd' and 'in' and 'bit')) not in words:    
        if  'vss' not in words or 'vdd' not in words:    
         all_signals[signals_index]= [signal_name,size,start]
         signals_index = signals_index+1
 print (all_signals)
 #af = CRL.AllianceFramework.get()
 cell  = CRL.Blif.load('iscas89s1423_area_90.blif')
 return all_signals
get_signals('iscas89s1423_area_90.vst','iscas89s1423_area_90' )
