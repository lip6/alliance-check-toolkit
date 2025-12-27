
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

from coriolis.designflow.task     import Tasks
from coriolis.designflow.copy     import Copy
from coriolis.designflow.cougar   import Cougar
from coriolis.designflow.lvx      import Lvx
from coriolis.designflow.druc     import Druc
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.klayout  import Klayout, ShowDRC
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.clean    import Clean
from coriolis.designflow.alias    import Alias
from pdks.gf180mcu.designflow.drc import DRC
PnR.textMode = True
reuseBlif    = get_var( 'reuse-blif', None )
#drcFlags     = DRC.SHOW_ERRORS
drcFlags     = 0


from doDesign  import scriptMain

if reuseBlif:
    ruleYosys = Copy.mkRule( 'yosys', 'ao68000.blif', './non_generateds/ao68000.{}.blif'.format( reuseBlif ))
else:
    ruleYosys  = Yosys     .mkRule( 'yosys', 'ao68000.v' )

rulePnR    = PnR       .mkRule( 'pnr'  , [ 'ao68000_cts_r.gds'
                                         , 'ao68000_cts_r.vst'
                                         , 'ao68000_cts_r.spi' ]
                                         , [ruleYosys]
                                       , scriptMain )
ruleGds     = Alias   .mkRule( 'gds'   , [rulePnR] )
ruleDRC     = DRC     .mkRule( 'drc'   , [rulePnR], DRC.GF180MCU_C|drcFlags )
ruleCgt     = PnR     .mkRule( 'cgt' )
ruleKlayout = Klayout .mkRule( 'klayout' )
ruleClean   = Clean   .mkRule()
