
from pathlib          import Path
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

from coriolis.designflow.task     import Tasks
from coriolis.designflow.cougar   import Cougar
from coriolis.designflow.lvx      import Lvx
from coriolis.designflow.druc     import Druc
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.klayout  import Klayout, ShowDRC
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.clean    import Clean
from pdks.gf180mcu.designflow.drc import DRC
PnR.textMode = True
#drcFlags     = DRC.SHOW_ERRORS
drcFlags     = 0

import doDesign

if doDesign.buildChip:
    pnrFiles = [ 'chip_r.gds'
               , 'chip_r.vst'
               , 'chip_r.spi'
               , 'chip.vst'
               , 'chip.spi'
               , 'corona_cts_r.vst'
               , 'corona_cts_r.spi'
               , 'corona_r.vst'
               , 'corona_r.spi'
               , 'corona.vst'
               , 'corona.spi'
               , 'mem_ctrl_cts.vst'
               , 'mem_ctrl_cts.spi'
               , 'mem_ctrl.spi'
               ]
else:
    pnrFiles = [ 'mem_ctrl_cts_r.gds'
               , 'mem_ctrl_cts_r.spi'
               , 'mem_ctrl_cts_r.vst'
               ]


ruleYosys   = Yosys   .mkRule( 'yosys'   , 'mem_ctrl.v' )
ruleB2V     = Blif2Vst.mkRule( 'b2v'     , 'mem_ctrl.vst', [ruleYosys], flags=0 )
rulePnR     = PnR     .mkRule( 'pnr'     , pnrFiles, [ruleYosys], doDesign.scriptMain )
ruleDRC     = DRC     .mkRule( 'drc'     , [rulePnR], DRC.GF180MCU_C|drcFlags )
ruleCgt     = PnR     .mkRule( 'cgt'     )
ruleKlayout = Klayout .mkRule( 'klayout' )
ruleClean   = Clean   .mkRule()
