import pathlib
import sys
from coriolis.designflow.technos  import setupSky130_nsx2
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.s2r      import S2R
from coriolis.designflow.klayout  import DRC
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
from coriolis.designflow          import pnrcheck
from coriolis.designflow.task     import ShellEnv, Tasks

checkToolkit=pathlib.Path('../../../..')
pdkDir          = checkToolkit / 'dks' / 'gf180mcu_nsx2' / 'libs.tech'
coriolisTechDir = pdkDir / 'coriolis'
sys.path.append( coriolisTechDir.as_posix() )
from gf180mcu_nsx2 import techno, nsxlib2, Gf180mcuSetup 

Gf180mcuSetup.setupGf180mcu_nsx2( checkToolkit )
print("RDS=",ShellEnv.RDS_TECHNO_NAME)
DOIT_CONFIG = { 'verbosity' : 2 }

PnR.textMode  = True

from doDesign  import scriptMain




kdrcRules = pdkDir / 'klayout' / 'drc' / 'gf180mcu.drc'
DRC.setDrcRules( kdrcRules )

pnrcheck.mkRuleSet( globals(), 'minerva_cpu', pnrcheck.UseClockTree )
#pnrcheck.mkRuleSet( globals(), 'minerva_cpu')
#ruleGds = S2R.mkRule( 'gds', 'minerva_cpu_cts_r.gds', 'minerva_cpu_cts_rdder_r.ap'
#                    , flags=S2R.Verbose|S2R.NoReplaceBlackboxes )
#ruleDRC = DRC.mkRule( 'drc', 'minerva_cpu_cts_r.gds' )

