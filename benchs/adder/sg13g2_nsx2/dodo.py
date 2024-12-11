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
pdkDir          = checkToolkit / 'dks' / 'sg13g2_nsx2' / 'libs.tech'
coriolisTechDir = pdkDir / 'coriolis'
sys.path.append( coriolisTechDir.as_posix() )
from sg13g2_nsx2 import techno, nsxlib2, Sg13g2Setup 

Sg13g2Setup.setupSg13g2_nsx2( checkToolkit )
print("RDS=",ShellEnv.RDS_TECHNO_NAME)
DOIT_CONFIG = { 'verbosity' : 2 }

PnR.textMode  = True

from doDesign  import scriptMain




kdrcRules = pdkDir / 'klayout' /  'sg13g2.lydrc'
DRC.setDrcRules( kdrcRules )

#pnrcheck.mkRuleSet( globals(), 'adder', pnrcheck.UseClockTree )
pnrcheck.mkRuleSet( globals(), 'adder')
#ruleGds = S2R.mkRule( 'gds', 'adder_r.gds', 'adder_r.ap'
#                    , flags=S2R.Verbose|S2R.NoReplaceBlackboxes )
#ruleDRC = DRC.mkRule( 'drc', 'adder_r.gds' )

