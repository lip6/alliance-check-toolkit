
import os
from   pathlib import Path
from   pdks.c4m_ihpsg13g2 import setup

setup( checkToolkit=Path('../../..') )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import ShellEnv, Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.klayout  import DRC
from coriolis.designflow.clean    import Clean
PnR.textMode  = True

from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'ao68000.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , [ 'ao68000.vst' ]
                                    , [ruleYosys]
                                    , flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'ao68000_cts_r.gds'
                                      , 'ao68000_cts_r.spi'
                                      , 'ao68000_cts_r.vst' ]
                                    , [ruleB2V]
                                    , scriptMain )
ruleCgt   = PnR     .mkRule( 'cgt' )
ruleGds   = Alias   .mkRule( 'gds', [rulePnR] )
shellEnv  = ShellEnv()
shellEnv[ 'SOURCE_FILE' ] = rulePnR.file_target(0).as_posix()
shellEnv[ 'REPORT_FILE' ] = rulePnR.file_target(0).with_suffix('.kdrc-report.txt').as_posix()
shellEnv[ 'CELL_NAME'   ] = rulePnR.file_target(0).stem
shellEnv.export()
ruleDRC   = DRC     .mkRule( 'drc', rulePnR.file_target(0) )
ruleClean = Clean   .mkRule( [ 'ao68000.00.density.histogram.dat'
                             , 'ao68000.00.density.histogram.plt'
                             , 'ao68000.katana.dat' ] ) 
