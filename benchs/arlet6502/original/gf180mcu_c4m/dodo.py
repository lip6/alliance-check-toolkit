
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
from coriolis.designflow.klayout  import Klayout, ShowDRC
from pdks.gf180mcu.designflow.drc import DRC
import doDesign

PnR.textMode = True
pnrSuffix    = '_cts_r'
topName      = 'arlet6502'

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
               , 'arlet6502_cts.vst'
               , 'arlet6502_cts.spi'
               , 'arlet6502.spi'
               ]
else:
    pnrFiles = [ 'Arlet6502_cts_r.gds'
               , 'Arlet6502_cts_r.spi'
               , 'arlet6502_cts_r.vst'
               ]

ruleYosys   = Yosys   .mkRule( 'yosys'   , 'Arlet6502.v' )
ruleB2V     = Blif2Vst.mkRule( 'b2v'     , 'arlet6502.vst', [ruleYosys], flags=0 )
rulePnR     = PnR     .mkRule( 'pnr'     , pnrFiles, [ruleYosys], doDesign.scriptMain )
ruleGds     = Alias   .mkRule( 'gds'     , [rulePnR] )
ruleDRC     = DRC     .mkRule( 'drc'     , [rulePnR], DRC.GF180MCU_C|DRC.SHOW_ERRORS|DRC.ANTENNA )
ruleCgt     = PnR     .mkRule( 'cgt'     )   
ruleKlayout = Klayout .mkRule( 'klayout' )
ruleClean   = Clean   .mkRule()


#ruleYosys = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
#ruleB2V   = Blif2Vst.mkRule( 'b2v'  , 'arlet6502.vst', [ruleYosys], flags=0 )
#rulePnR   = PnR     .mkRule( 'gds'  , [ 'chip_r.gds'
#                                      , 'chip_r.vst'
#                                      , 'chip_r.spi'
#                                      , 'chip.vst'
#                                      , 'chip.spi'
#                                      , 'corona_cts_r.vst'
#                                      , 'corona_cts_r.spi'
#                                      , 'corona.vst'
#                                      , 'corona.spi'
#                                      , 'Arlet6502_cts.spi'
#                                      , 'arlet6502_cts.vst' ]
#                                      , [ruleB2V]
#                                    , scriptMain
#                                    , topName=topName )
#ruleDRC     = DRC     .mkRule( 'drc'     , [rulePnR], DRC.GF180MCU_C|DRC.SHOW_ERRORS|DRC.ANTENNA )
#ruleCgt     = PnR     .mkRule( 'cgt'     )   
#ruleKlayout = Klayout .mkRule( 'klayout' )
#ruleClean   = Clean   .mkRule( [ 'lefRWarning.log', 'cgt.log' ] )
