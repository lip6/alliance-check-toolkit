
from coriolis.designflow.technos import setupGF180MCU_GF
from coriolis         import Cfg 
from coriolis.helpers import overlay

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
setupGF180MCU_GF( checkToolkit='../../..', pdkTop='../../../../gf180mcu-pdk', useHV=False )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.cougar   import Cougar
from coriolis.designflow.lvx      import Lvx
from coriolis.designflow.druc     import Druc
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.clean    import Clean
PnR.textMode = True

from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , 'arlet6502.vst', [ruleYosys], flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'arlet6502_cts_r.ap'
                                      , 'arlet6502_cts_r.vst'
                                      , 'arlet6502_cts_r.spi' ]
                                      , [ruleB2V]
                                    , scriptMain )
#ruleCougar = Cougar.mkRule( 'cougar', 'arlet6502_cts_r_ext.vst', [rulePnR], flags=Cougar.Verbose )
#ruleLvx    = Lvx   .mkRule( 'lvx'
#                          , [ rulePnR.file_target(1)
#                            , ruleCougar.file_target(0) ]
#                          , flags=Lvx.Flatten )
#ruleDruc   = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleClean  = Clean .mkRule()
