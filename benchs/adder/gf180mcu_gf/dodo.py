
from pathlib          import Path
from doit             import get_var
from coriolis         import Cfg 
from coriolis.helpers import overlay
from pdks.gf180mcu    import setup


def userSetup ():
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore           = False
        cfg.misc.minTraceLevel       = 12300
        cfg.misc.maxTraceLevel       = 12400
        cfg.misc.info                = False
        cfg.misc.paranoid            = False
        cfg.misc.bug                 = False
        cfg.misc.logMode             = True
        cfg.misc.verboseLevel1       = True
        cfg.misc.verboseLevel2       = False

userSetup()
setup( checkToolkit=Path('../../..'), useHV=True )


DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis                     import CRL
from coriolis.designflow.task     import Tasks
from coriolis.designflow.copy     import Copy
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.klayout  import Klayout, ShowDRC
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
from pdks.gf180mcu.designflow.drc import DRC
import doDesign

reuseBlif          = get_var( 'reuse-blif', None )
PnR.textMode       = True
doDesign.buildChip = False
#drcFlags           = DRC.SHOW_ERRORS
drcFlags           = 0


if reuseBlif:
    ruleYosys = Copy.mkRule( 'yosys', 'adder.blif', './non_generateds/adder.{}.blif'.format( reuseBlif ))
else:
    ruleYosys = Yosys.mkRule( 'yosys', 'adder.v' )

if doDesign.buildChip:
    rulePnR   = PnR.mkRule( 'pnr', [ 'chip_r.gds'
                                   , 'chip_r.spi'
                                   , 'chip_r.vst'
                                   , 'chip.vst'
                                   , 'chip.spi'
                                   , 'corona_cts_r.vst'
                                   , 'corona_cts_r.spi'
                                   , 'corona.vst'
                                   , 'corona.spi'
                                   , 'adder_cts.vst'
                                   , 'adder_cts.spi'
                                   ]
                                 , [ruleYosys]
                                 , doDesign.scriptMain )
else:
    rulePnR   = PnR.mkRule( 'pnr', [ 'adder_cts_r.gds'
                                   , 'adder_cts_r.vst'
                                   , 'adder_cts_r.spi'
                                   ]
                                 , [ruleYosys]
                                 , doDesign.scriptMain )

ruleDRC     = DRC     .mkRule( 'drc' , [rulePnR], DRC.GF180MCU_C|DRC.ANTENNA|drcFlags )
ruleGds     = Alias   .mkRule( 'gds', [rulePnR] )
ruleCgt     = PnR     .mkRule( 'cgt' )
ruleKlayout = Klayout .mkRule( 'klayout' )
ruleClean   = Clean   .mkRule()
