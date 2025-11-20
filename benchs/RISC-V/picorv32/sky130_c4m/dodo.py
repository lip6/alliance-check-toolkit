
from doit import get_var
from coriolis.designflow.technos import setupSky130_c4m

setupSky130_c4m( '../../../..', '../../../../pdkmaster/C4M.Sky130' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.copy     import Copy
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
PnR.textMode  = True
reuseBlif     = get_var( 'reuse-blif', None )


from doDesign  import scriptMain

if reuseBlif:
    ruleYosys = Copy.mkRule( 'yosys', 'picorv32.blif', './non_generateds/picorv32.{}.blif'.format( reuseBlif ))
else:
    ruleYosys = Yosys.mkRule( 'yosys', 'picorv32.v' )

rulePnR   = PnR     .mkRule( 'pnr'  , [ 'picorv32_cts_r.gds'
                                      , 'picorv32_cts_r.spi'
                                      , 'picorv32_cts_r.vst' ]
                                    , [ruleYosys]
                                    , scriptMain )
ruleCgt   = PnR     .mkRule( 'cgt' )
ruleGds   = Alias   .mkRule( 'gds', [rulePnR] )
ruleClean = Clean   .mkRule( [], [ ('.', '*.log'        )
                                 , ('.', '*.histogram.*')
                                 , ('.', '*.katana.dat' ) ] )
