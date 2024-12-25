import sys
import pathlib
from coriolis.designflow.task    import ShellEnv, Tasks
checkToolkit=pathlib.Path('../../..')
DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.klayout  import DRC
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean

pdkDir          = checkToolkit / 'dks' / 'sg13g2_nsx2' / 'libs.tech'
coriolisTechDir = pdkDir / 'coriolis' / 'sg13g2_nsx2'
sys.path.append( coriolisTechDir.as_posix() )
import Sg13g2Setup 
Sg13g2Setup.setupSg13g2_nsx2( checkToolkit )

kdrcRules = pdkDir / 'klayout' /  'sg13g2.lydrc'

pdkCommonDir          = checkToolkit / 'dks' / 'common'  / 'coriolis'
pdkCommonTechDir      = checkToolkit / 'dks' / 'common'  / 'libs.tech' / 'IHP-Open-PDK' / 'ihp-sg13g2' / 'libs.tech'
sys.path.append( pdkCommonDir.as_posix() )
from s2r import S2R
import pnrcheck
from sta                          import STA
pnrcheck.textMode  = True
import doDesign

S2R.flags = S2R.PinLayer | S2R.DeleteSubConnectors | S2R.Verbose|S2R.NoReplaceBlackboxes 

DRC.setDrcRules( kdrcRules )

STA.VddSupply = 1.8
STA.ClockName = 'm_clock'
STA.SpiceType = 'hspice'
STA.OSDIdll = 'psp103_nqs.osdi'
STA.SpiceTrModel = 'mos_tt.lib'
STA.MBK_CATA_LIB = '.:'+str( coriolisTechDir )+':'+str( pdkCommonTechDir ) + '/ngspice/models'
shellEnv = ShellEnv()
shellEnv[ 'MBK_SPI_MODEL' ] =  str( coriolisTechDir / 'spimodel.cfg' )
shellEnv.export()
STA.flags = STA.Transistor
pnrcheck.mkRuleSet( globals(), doDesign.CoreName, pnrcheck.UseClockTree )

