
import socket
from   pathlib import Path


from coriolis.designflow.technos import setupSky130_c4m

setupSky130_c4m( '../../../..', '../../../../pdkmaster/C4M.Sky130' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
PnR.textMode  = True

#from ota import scriptMain
from doSar_wip_3 import scriptMain

ruleCgt   = PnR  .mkRule( 'cgt' )
ruleClean = Clean.mkRule()
