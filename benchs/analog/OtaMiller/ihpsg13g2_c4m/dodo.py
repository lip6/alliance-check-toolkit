
import socket
from   pathlib import Path


from pdks.ihpsg13g2_c4m import setup

setup( '../../../..' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
PnR.textMode  = True

from doMillerMos_v2  import scriptMain

rulePnR   = PnR  .mkRule( 'pnr'  , [], [], scriptMain )
ruleCgt   = PnR  .mkRule( 'cgt' )
ruleClean = Clean.mkRule()
