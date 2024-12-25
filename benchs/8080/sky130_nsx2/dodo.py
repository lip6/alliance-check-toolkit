import sys
import pathlib
from coriolis.designflow.task    import ShellEnv, Tasks
checkToolkit=pathlib.Path('../../..')
DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.klayout  import DRC
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean

pdkDir          = checkToolkit / 'dks' / 'sky130_nsx2' / 'libs.tech'
coriolisTechDir = pdkDir / 'coriolis' / 'sky130_nsx2'
sys.path.append( coriolisTechDir.as_posix() )
import Sky130nsx2Setup 
Sky130nsx2Setup.setupSky130_nsx2( checkToolkit )

kdrcRules = pdkDir / 'klayout' / 'sky130A.lydrc'

pdkCommonDir          = checkToolkit / 'dks' / 'common'  / 'coriolis'
pdkCommonTechDir          = checkToolkit / 'dks' / 'common'  / 'libs.tech'
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
STA.SpiceTrModel = 'sky130_fd_pr__nfet_01v8__mismatch.corner.spice sky130_fd_pr__nfet_01v8__tt.pm3.spice sky130_fd_pr__nfet_01v8__tt.corner.spice sky130_fd_pr__pfet_01v8__mismatch.corner.spice sky130_fd_pr__pfet_01v8__tt.pm3.spice sky130_fd_pr__pfet_01v8__tt.corner.spice  parameters/lod.spice '
STA.MBK_CATA_LIB = '.:'+str( pdkCommonTechDir / 'skywater-pdk-libs-sky130_fd_pr' / 'models') + ':' + str( pdkCommonTechDir / 'skywater-pdk-libs-sky130_fd_pr' / 'cells' / 'pfet_01v8') + ':' + str( pdkCommonTechDir / 'skywater-pdk-libs-sky130_fd_pr' / 'cells' / 'nfet_01v8')
print ('CATALIB=',STA.MBK_CATA_LIB)
shellEnv = ShellEnv()
shellEnv[ 'MBK_SPI_MODEL' ] =  str( coriolisTechDir / 'spimodel.cfg' )
shellEnv.export()
STA.flags = STA.Transistor
pnrcheck.mkRuleSet( globals(), doDesign.CoreName, pnrcheck.UseClockTree )

