import pathlib
import sys
from coriolis.designflow.technos  import setupSky130_nsx2
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
#from coriolis.designflow.s2r      import S2R
from coriolis.designflow.klayout  import DRC
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
#from coriolis.designflow          import pnrcheck
from coriolis.designflow.task     import ShellEnv, Tasks

checkToolkit=pathlib.Path('../../..')
pdkDir          = checkToolkit / 'dks' / 'sg13g2_nsx2' / 'libs.tech'
coriolisTechDir = pdkDir / 'coriolis' / 'sg13g2_nsx2'
sys.path.append( coriolisTechDir.as_posix() )
import techno, nsxlib2, Sg13g2Setup 

pdkCommonDir          = checkToolkit / 'dks' / 'common'  / 'coriolis'
pdkCommonTechDir      = checkToolkit / 'dks' / 'common'  / 'libs.tech' / 'IHP-Open-PDK' / 'ihp-sg13g2' / 'libs.tech'
sys.path.append( pdkCommonDir.as_posix() )
from s2r import S2R
from sta import STA
import pnrcheck


Sg13g2Setup.setupSg13g2_nsx2( checkToolkit )
print("RDS=",ShellEnv.RDS_TECHNO_NAME)
DOIT_CONFIG = { 'verbosity' : 2 }

PnR.textMode  = True
S2R.flags = S2R.PinLayer | S2R.DeleteSubConnectors | S2R.Verbose|S2R.NoReplaceBlackboxes 

#from doDesign  import scriptMain
import doDesign

kdrcRules = pdkDir / 'klayout' /  'sg13g2.lydrc'
DRC.setDrcRules( kdrcRules )

STA.VddSupply = 1.8
STA.ClockName = 'm_clock'
STA.SpiceType = 'hspice'
STA.OSDIdll = 'psp103_nqs.osdi'
STA.SpiceTrModel = 'mos_tt.lib'
STA.MBK_CATA_LIB = '.:'+str( coriolisTechDir )+':'+str( pdkCommonTechDir ) + '/ngspice/models'
print(STA.MBK_CATA_LIB)
shellEnv = ShellEnv()
shellEnv[ 'MBK_SPI_MODEL' ] =  str( coriolisTechDir / 'spimodel.cfg' )
shellEnv.export()
STA.flags = STA.Transistor
pnrcheck.mkRuleSet( globals(), doDesign.CoreName, pnrcheck.UseClockTree )


