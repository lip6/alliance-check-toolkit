
from coriolis.designflow.technos import setupTSMC_c180_c4m

setupTSMC_c180_c4m( checkToolkit='../../../..', ndaTop=None )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
PnR.textMode  = True

from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'chip_r.gds'
                                      , 'chip_r.spi'
                                      , 'chip.spi'
                                      , 'corona_cts_r.spi'
                                      , 'corona.spi'
                                      , 'Arlet6502.spi'
                                      , 'Arlet6502_cts.spi' ]
                                    , [ruleYosys]
                                    , scriptMain )
ruleCgt   = PnR  .mkRule( 'cgt' )
ruleGds   = Alias.mkRule( 'gds', [rulePnR] )
ruleClean = Clean.mkRule( [ 'corona.00.density.histogram.dat'
                          , 'corona.00.density.histogram.plt'
                          , 'corona.katana.dat' ] )
