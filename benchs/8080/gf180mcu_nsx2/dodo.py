import sys
import pathlib
from coriolis.designflow.task    import ShellEnv, Tasks
checkToolkit=pathlib.Path('../../..')
DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.klayout  import DRC
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean

pdkDir          = checkToolkit / 'dks' / 'gf180mcu_nsx2' / 'libs.tech'
coriolisTechDir = pdkDir / 'coriolis' / 'gf180mcu_nsx2'
sys.path.append( coriolisTechDir.as_posix() )
import Gf180mcuSetup 
Gf180mcuSetup.setupGf180mcu_nsx2( checkToolkit )

kdrcRules = pdkDir / 'klayout' / 'drc' /  'gf180mcu.drc'

pdkCommonDir          = checkToolkit / 'dks' / 'common'  / 'coriolis'
pdkCommonTechDir      = checkToolkit / 'dks' / 'common'  / 'libs.tech' / 'globalfoundries-pdk-libs-gf180mcu_fd_pr' / 'models' / 'ngspice'
sys.path.append( pdkCommonDir.as_posix() )
from s2r import S2R
import pnrcheck
from sta                          import STA
pnrcheck.textMode  = True
import doDesign

S2R.flags = S2R.PinLayer | S2R.DeleteSubConnectors | S2R.Verbose|S2R.NoReplaceBlackboxes 

DRC.setDrcRules( kdrcRules )

STA.VddSupply = 3.3
STA.ClockName = 'm_clock'
STA.SpiceType = 'hspice'

STA.SpiceTrModel = 'typical.lib design.ngspice sm141064.ngspice'
STA.MBK_CATA_LIB = '.:'+str( coriolisTechDir )+':'+str( pdkCommonTechDir )
shellEnv = ShellEnv()
shellEnv[ 'MBK_SPI_MODEL' ] =  str( coriolisTechDir / 'spimodel.cfg' )
shellEnv.export()
STA.flags = STA.Transistor
pnrcheck.mkRuleSet( globals(), doDesign.CoreName, pnrcheck.UseClockTree )

