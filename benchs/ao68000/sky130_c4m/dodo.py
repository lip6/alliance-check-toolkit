
from coriolis.designflow.technos import setupSky130_c4m

setupSky130_c4m( '../../..', '../../../pdkmaster/C4M.Sky130' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
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
ruleClean = Clean   .mkRule( [ 'ao68000.00.density.histogram.dat'
                             , 'ao68000.00.density.histogram.plt'
                             , 'ao68000.katana.dat' ] ) 
