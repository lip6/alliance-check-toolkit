
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
setup( useHV=True )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.copy     import Copy
from coriolis.designflow.cougar   import Cougar
from coriolis.designflow.lvx      import Lvx
from coriolis.designflow.druc     import Druc
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.klayout  import Klayout, ShowDRC
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
from pdks.gf180mcu.designflow.drc import DRC
PnR.textMode = True
reuseBlif    = get_var( 'reuse-blif', None )
drcFlags     = DRC.SHOW_ERRORS
#drcFlags     = 0

import doDesign

doDesign.buildChip = False
if doDesign.buildChip:
    pnrFiles = [ 'chip_r.gds'
               , 'chip_r.spi'
               , 'chip.spi'
               , 'corona_cts_r.spi'
               , 'corona_r.spi'
               , 'corona.spi'
               , 'Arlet6502_cts.spi'
               , 'Arlet6502.spi'
               ]
else:
    pnrFiles = [ 'Arlet6502_cts_r.gds'
               , 'Arlet6502_cts_r.spi'
               ]


if reuseBlif:
    ruleYosys = Copy.mkRule( 'yosys', 'Arlet6502.blif', './non_generateds/Arlet6502.{}.blif'.format( reuseBlif ))
else:
    ruleYosys   = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
ruleB2V     = Blif2Vst.mkRule( 'b2v'     , 'arlet6502.vst', [ruleYosys], flags=0 )
rulePnR     = PnR     .mkRule( 'pnr'     , pnrFiles, [ruleYosys], doDesign.scriptMain )
ruleGds     = Alias   .mkRule( 'gds'     , [rulePnR] )
ruleDRC     = DRC     .mkRule( 'drc'     , [rulePnR], DRC.GF180MCU_C|DRC.ANTENNA|drcFlags )
ruleCgt     = PnR     .mkRule( 'cgt'     )
ruleKlayout = Klayout .mkRule( 'klayout' )
ruleClean   = Clean   .mkRule()
