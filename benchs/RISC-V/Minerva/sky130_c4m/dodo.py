
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

from doDesign  import scriptMain

ruleBlif  = Copy    .mkRule( 'blif' , 'user_project_core_lambdasoc.blif'
                                    , './non_generated/user_project_core_lambdasoc.blif' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , [ 'user_project_core_lambdasoc.vst' ]
                                    , [ruleBlif]
                                    , flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'user_project_wrapper.gds'
                                      , 'user_project_wrapper.vst'
                                      , 'user_project_wrapper.spi'
                                      , 'corona_cts.vst'
                                      , 'corona_cts.spi'
                                      , 'corona.vst'
                                      , 'corona.spi'
                                      , 'user_project_core_lambdasoc_cts.spi'
                                      , 'user_project_core_lambdasoc_cts.vst' ]
                                    , [ruleB2V]
                                    , scriptMain )
ruleCgt   = PnR     .mkRule( 'cgt' )
ruleGds   = Alias   .mkRule( 'gds', [rulePnR] )
ruleClean = Clean   .mkRule( [ 'corona.00.density.histogram.dat'
                             , 'corona.00.density.histogram.plt'
                             , 'corona.katana.dat' ] ) 
