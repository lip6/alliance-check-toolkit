import sys
import pathlib
from coriolis.designflow.task    import ShellEnv, Tasks
checkToolkit=pathlib.Path('../../..')
DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.klayout  import DRC
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean

pdkDir          = checkToolkit / 'dks' / 'scmos2m1u_nsx2' / 'libs.tech'
coriolisTechDir = pdkDir / 'coriolis' / 'scmos2m1u_nsx2' 
sys.path.append( coriolisTechDir.as_posix() )
import Scmos2m1uSetup 
Scmos2m1uSetup.setupScmos2m1u_nsx2( checkToolkit )

kdrcRules = pdkDir / 'klayout' /  'drc' / 'drc_SCMOS.lydrc'

pdkCommonDir          = checkToolkit / 'dks' / 'common'  / 'coriolis'
sys.path.append( pdkCommonDir.as_posix() )
from s2r import S2R
from scr import SCR
import pnrcheck
from sta                          import STA
pnrcheck.textMode  = True
import doDesign

SCR.RandSeed_value = 2
SCR.MaxRetry_value = 10
SCR.MBK_CATA_LIB = ShellEnv.MBK_CATA_LIB
STA.VddSupply = 5.0
DRC.setDrcRules( kdrcRules )

STA.VddSupply = 5.0
STA.ClockName = 'm_clock'
STA.SpiceType = 'spice'

STA.SpiceTrModel = 'p8_cmos_models.inc'
STA.MBK_CATA_LIB = '.:'+str( coriolisTechDir )
shellEnv = ShellEnv()
shellEnv[ 'MBK_SPI_MODEL' ] =  str( coriolisTechDir / 'spimodel.cfg' )
shellEnv.export()
STA.flags = STA.Transistor
pnrcheck.mkRuleSet( globals(), doDesign.CoreName, pnrcheck.ChannelRoute)



