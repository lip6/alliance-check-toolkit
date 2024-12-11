
from coriolis.designflow.technos import setupTSMC_c180_c4m

setupTSMC_c180_c4m( checkToolkit='../../..', ndaTop=None )

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
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'chip_r.gds'
                                      , 'chip_r.vst'
                                      , 'chip_r.spi'
                                      , 'chip.vst'
                                      , 'chip.spi'
                                      , 'corona_cts_r.vst'
                                      , 'corona_cts_r.spi'
                                      , 'corona.vst'
                                      , 'corona.spi'
                                      , 'ao68000_cts.spi'
                                      , 'ao68000_cts.vst' ]
                                    , [ruleB2V]
                                    , scriptMain )
ruleCgt   = PnR  .mkRule( 'cgt' )
ruleGds   = Alias.mkRule( 'gds', [rulePnR] )
ruleClean = Clean.mkRule( [ 'corona.00.density.histogram.dat'
                          , 'corona.00.density.histogram.plt'
                          , 'corona.katana.dat' ] )
