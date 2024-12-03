import pathlib
from coriolis.designflow.technos import setupSky130_nsx2

checkToolkit=pathlib.Path('../../..')
setupSky130_nsx2( checkToolkit )
DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.s2r      import S2R
from coriolis.designflow.klayout  import DRC
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
from coriolis.designflow          import pnrcheck
PnR.textMode  = True

from doDesign  import scriptMain

pdkDir          = checkToolkit / 'dks' / 'sky130_nsx2' / 'libs.tech'
kdrcRules = pdkDir / 'klayout' / 'core' / 'sky130A_mr.drc'
DRC.setDrcRules( kdrcRules )

#pnrcheck.mkRuleSet( globals(), 'adder', pnrcheck.UseClockTree )
pnrcheck.mkRuleSet( globals(), 'adder')
#ruleGds = S2R.mkRule( 'gds', 'adder_r.gds', 'adder_r.ap'
#                    , flags=S2R.Verbose|S2R.NoReplaceBlackboxes )
#ruleDRC = DRC.mkRule( 'drc', 'adder_r.gds' )

