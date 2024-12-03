
import os
from   pathlib import Path
from   pdks.c4m_ihpsg13g2 import setup

setup( checkToolkit=Path('../../..') )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis                     import CRL
from coriolis.designflow.task     import ShellEnv, Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.klayout  import DRC
from coriolis.designflow.clean    import Clean
from doDesign                     import scriptMain

PnR.textMode = True
pnrSuffix    = '_cts_r'
topName      = 'arlet6502'

ruleYosys = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , 'arlet6502.vst', [ruleYosys], flags=0 )
# Rule for chip generation.
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
# Rule for block generation.
#rulePnR   = PnR     .mkRule( 'gds'  , [ 'Arlet6502_cts_r.gds'
#                                      , 'arlet6502_cts_r.vst'
#                                      , 'Arlet6502_cts_r.spi' ]
#                                      , [ruleB2V]
#                                    , scriptMain
#                                    , topName=topName )
shellEnv = ShellEnv()
shellEnv[ 'SOURCE_FILE' ] = rulePnR.file_target(0).as_posix()
shellEnv[ 'REPORT_FILE' ] = rulePnR.file_target(0).with_suffix('.kdrc-report.txt').as_posix()
shellEnv[ 'CELL_NAME'   ] = rulePnR.file_target(0).stem
shellEnv.export()
ruleDRC    = DRC   .mkRule( 'drc', rulePnR.file_target(0) )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleClean  = Clean .mkRule( [ 'lefRWarning.log', 'cgt.log' ] )
