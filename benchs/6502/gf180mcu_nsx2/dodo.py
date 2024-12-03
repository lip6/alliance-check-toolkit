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
from coriolis.designflow.task     import Tasks

checkToolkit=pathlib.Path('../../..')
pdkDir          = checkToolkit / 'dks' / 'gf180mcu_nsx2' / 'libs.tech'
coriolisTechDir = pdkDir / 'coriolis' / 'gf180mcu_nsx2'
sys.path.append( coriolisTechDir.as_posix() )
import techno, nsxlib2, Gf180mcuSetup 

pdkCommonDir          = checkToolkit / 'dks' / 'common'  / 'coriolis'
sys.path.append( pdkCommonDir.as_posix() )
from s2r import S2R
from sta import STA
import pnrcheck


Gf180mcuSetup.setupGf180mcu_nsx2( checkToolkit )
print("RDS=",ShellEnv.RDS_TECHNO_NAME)
DOIT_CONFIG = { 'verbosity' : 2 }

PnR.textMode  = True
S2R.flags = S2R.PinLayer | S2R.DeleteSubConnectors | S2R.Verbose|S2R.NoReplaceBlackboxes 

#from doDesign  import scriptMain
import doDesign

kdrcRules = pdkDir / 'klayout' / 'drc' /  'gf180mcu.drc'
DRC.setDrcRules( kdrcRules )

STA.VddSupply = 3.3
STA.ClockName = 'm_clock'
STA.SpiceType = 'hspice'
STA.SpiceTrModel = 'sm141064.spi'
STA.MBK_CATA_LIB = '.:'+str( coriolisTechDir )
shellEnv = ShellEnv()
shellEnv[ 'MBK_SPI_MODEL' ] =  str( coriolisTechDir / 'spimodel.cfg' )
shellEnv.export()
STA.flags = STA.Transistor

pnrcheck.mkRuleSet( globals(), doDesign.CoreName, pnrcheck.UseClockTree )


