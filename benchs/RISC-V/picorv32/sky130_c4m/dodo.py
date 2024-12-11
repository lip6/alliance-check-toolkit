
from coriolis.designflow.technos import setupSky130_c4m

setupSky130_c4m( '../../../..', '../../../../pdkmaster/C4M.Sky130' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
PnR.textMode  = True

from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'picorv32.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , [ 'picorv32.vst' ]
                                    , [ruleYosys]
                                    , flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'picorv32_cts_r.gds'
                                      , 'picorv32_cts_r.spi'
                                      , 'picorv32_cts_r.vst' ]
                                    , [ruleB2V]
                                    , scriptMain )
ruleCgt   = PnR     .mkRule( 'cgt' )
ruleGds   = Alias   .mkRule( 'gds', [rulePnR] )
ruleClean = Clean   .mkRule()
