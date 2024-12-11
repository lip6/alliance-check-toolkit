import sys
import pathlib
from coriolis.designflow.technos import setupSky130_nsx2
from coriolis.designflow.task import ShellEnv
checkToolkit=pathlib.Path('../../..')
setupSky130_nsx2( checkToolkit )
DksCommonDir = checkToolkit / 'dks' / 'common' / 'coriolis'
sys.path.append( DksCommonDir.as_posix() )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.s2r      import S2R
from coriolis.designflow.cougar   import Cougar
from coriolis.designflow.klayout  import DRC
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
import pnrcheck
from sta                          import STA
PnR.textMode  = True

#from doDesign  import scriptMain
import doDesign

pdkDir          = checkToolkit / 'dks' / 'sky130_nsx2' / 'libs.tech'
coriolisTechDir = pdkDir / 'coriolis' / 'sky130_nsx2'
sys.path.append( coriolisTechDir.as_posix() )
from sky130_nsx2 import techno, nsxlib2, Sky130nsx2Setup 

kdrcRules = pdkDir / 'klayout' / 'core' / 'sky130A_mr.drc'

pdkCommonDir          = checkToolkit / 'dks' / 'common'  / 'coriolis'
sys.path.append( pdkCommonDir.as_posix() )
from s2r import S2R
import pnrcheck

S2R.flags = S2R.PinLayer | S2R.DeleteSubConnectors | S2R.Verbose|S2R.NoReplaceBlackboxes 

DRC.setDrcRules( kdrcRules )

STA.VddSupply = 1.8
STA.ClockName = 'm_clock'
STA.SpiceType = 'hspice'
STA.SpiceTrModel = 'C4M.Sky130_logic_tt_model.spice'
STA.MBK_CATA_LIB = '.:'+str( checkToolkit / 'pdkmaster' / 'C4M.Sky130' / 'libs.tech' / 'ngspice' )
shellEnv = ShellEnv()
shellEnv[ 'MBK_SPI_MODEL' ] =  str( coriolisTechDir / 'spimodel.cfg' )
shellEnv.export()
STA.flags = STA.Transistor

pnrcheck.mkRuleSet( globals(), doDesign.CoreName )
