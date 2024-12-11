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

checkToolkit=pathlib.Path('../../..')
pdkDir          = checkToolkit / 'dks' / 'sky130_vsc' / 'libs.tech'
coriolisTechDir = pdkDir / 'coriolis'
sys.path.append( coriolisTechDir.as_posix() )
from sky130_vsc import techno, vsclib, Sky130vscSetup 

Sky130vscSetup.setupSky130_vsc( checkToolkit )
print("RDS=",ShellEnv.RDS_TECHNO_NAME)
DOIT_CONFIG = { 'verbosity' : 2 }

PnR.textMode  = True

import doDesign




kdrcRules = pdkDir / 'klayout' /   'sky130A.lydrc'
DRC.setDrcRules( kdrcRules )

pnrcheck.mkRuleSet( globals(), doDesign.coreName, pnrcheck.UseClockTree )
#pnrcheck.mkRuleSet( globals(), 'adder')
#ruleGds = S2R.mkRule( 'gds', 'adder_r.gds', 'adder_r.ap'
#                    , flags=S2R.Verbose|S2R.NoReplaceBlackboxes )
#ruleDRC = DRC.mkRule( 'drc', 'adder_r.gds' )

