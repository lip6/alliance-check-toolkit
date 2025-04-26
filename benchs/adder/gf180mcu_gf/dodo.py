

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

from coriolis                     import CRL
from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
PnR.textMode  = True

from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'adder.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , [ 'adder.vst' ]
                                    , [ruleYosys]
                                    , flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'chip_r.gds'
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
                                    , [ruleB2V]
                                    , scriptMain )
ruleCgt   = PnR     .mkRule( 'cgt' )
ruleGds   = Alias   .mkRule( 'gds', [rulePnR] )
ruleClean = Clean   .mkRule()
