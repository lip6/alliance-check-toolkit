
from doit import get_var
from coriolis.designflow.technos import setupTSMC_c180_c4m

setupTSMC_c180_c4m( checkToolkit='../../..', ndaTop=None )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.alias    import Alias
from coriolis.designflow.copy     import Copy
from coriolis.designflow.clean    import Clean
PnR.textMode  = True

from doDesign  import scriptMain

reuseBlif = get_var( 'reuse-blif', None )

if reuseBlif:
    ruleYosys = Copy.mkRule( 'yosys', 'adder.blif', f'./non_generateds/adder.{reuseBlif}.blif' )
else:
    ruleYosys = Yosys   .mkRule( 'yosys', 'adder.v' )
rulePnR = PnR.mkRule( 'pnr'  , [ 'chip_r.gds'
                               , 'chip_r.vst'
                               , 'chip_r.spi'
                               , 'chip.vst'
                               , 'chip.spi'
                               , 'corona_cts_r.vst'
                               , 'corona_cts_r.spi'
                               , 'corona.vst'
                               , 'corona.spi'
                               , 'adder_cts.spi'
                               , 'adder_cts.vst' ]
                             , [ruleYosys]
                             , scriptMain )
ruleCgt   = PnR  .mkRule( 'cgt' )
ruleGds   = Alias.mkRule( 'gds', [rulePnR] )
ruleClean = Clean.mkRule( [ 'corona.00.density.histogram.dat'
                          , 'corona.00.density.histogram.plt'
                          , 'corona.katana.dat' ] )
