
import os
from   pathlib           import Path
from   coriolis          import Cfg
from   coriolis.helpers  import overlay
from   pdks.gf180mcu_c4m import setup


def userSettings ():
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore     = False
        cfg.misc.info          = False
        cfg.misc.paranoid      = False
        cfg.misc.bug           = False
        cfg.misc.logMode       = False
        cfg.misc.verboseLevel1 = True
        cfg.misc.verboseLevel2 = True


userSettings()
setup( checkToolkit=Path('../../../..') )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis                     import CRL
from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
from doDesign                     import scriptMain

PnR.textMode = True
pnrSuffix    = '_cts_r'
topName      = 'arlet6502'

ruleYosys = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , 'arlet6502.vst', [ruleYosys], flags=0 )
rulePnR   = PnR     .mkRule( 'gds'  , [ 'chip_r.gds'
                                      , 'chip_r.vst'
                                      , 'chip_r.spi'
                                      , 'chip.vst'
                                      , 'chip.spi'
                                      , 'corona_cts_r.vst'
                                      , 'corona_cts_r.spi'
                                      , 'corona.vst'
                                      , 'corona.spi'
                                      , 'Arlet6502_cts.spi'
                                      , 'arlet6502_cts.vst' ]
                                      , [ruleB2V]
                                    , scriptMain
                                    , topName=topName )
#ruleCougar = Cougar.mkRule( 'cougar', 'arlet6502_cts_r_ext.vst', [rulePnR], flags=Cougar.Verbose )
#ruleLvx    = Lvx   .mkRule( 'lvx'
#                          , [ rulePnR.file_target(1)
#                            , ruleCougar.file_target(0) ]
#                          , flags=Lvx.Flatten )
#ruleDruc   = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleClean  = Clean .mkRule( [ 'lefRWarning.log', 'cgt.log' ] )
