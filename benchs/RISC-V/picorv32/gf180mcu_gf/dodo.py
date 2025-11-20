
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
        cfg.misc.verboseLevel2       = True

userSetup()
setup( checkToolkit=Path('../../..'), useHV=True )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis                     import CRL
from coriolis.designflow.task     import ShellEnv, Tasks
from coriolis.designflow.copy     import Copy
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.klayout  import Klayout, DRC
from coriolis.designflow.tasyagle import TasYagle, STA, XTas
from coriolis.designflow.copy     import Copy
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
from pdks.gf180mcu.designflow.drc import DRC
from doDesign                               import scriptMain
PnR.textMode = True
reuseBlif    = get_var( 'reuse-blif', None )


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
               , 'picorv32_cts.vst'
               , 'picorv32_cts.spi'
               , 'picorv32.spi'
               ]
else:
    pnrFiles = [ 'picorv32_cts_r.gds'
               , 'picorv32_cts_r.spi'
               , 'picorv32_cts_r.vst'
               ]

if reuseBlif:
    ruleYosys = Copy.mkRule( 'yosys', 'picorv32.blif', './non_generateds/picorv32.{}.blif'.format( reuseBlif ))
else:
    ruleYosys   = Yosys.mkRule( 'yosys'   , 'picorv32.v' )

rulePnR     = PnR     .mkRule( 'pnr'     , pnrFiles, [ruleYosys], doDesign.scriptMain )
ruleGds     = Alias   .mkRule( 'gds'     , [rulePnR] )
ruleDRC     = DRC     .mkRule( 'drc'     , [rulePnR], DRC.GF180MCU_C|DRC.SHOW_ERRORS )
ruleCgt     = PnR     .mkRule( 'cgt'     )
ruleKlayout = Klayout .mkRule( 'klayout' )
ruleClean   = Clean   .mkRule()
