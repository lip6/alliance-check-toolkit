
from designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from designflow.cougar   import Cougar
from designflow.lvx      import Lvx
from designflow.druc     import Druc
from designflow.pnr      import PnR
from designflow.yosys    import Yosys
from designflow.blif2vst import Blif2Vst
from designflow.clean    import Clean
PnR.textMode = True

from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , 'arlet6502.vst', [ruleYosys], flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'arlet6502_cts_r.ap'
                                      , 'arlet6502_cts_r.vst'
                                      , 'arlet6502_cts_r.spi'
                                      , 'Arlet6502.spi' ]
                                      , [ruleB2V]
                                    , scriptMain )
ruleCougar = Cougar.mkRule( 'cougar', 'arlet6502_cts_r_ext.vst', [rulePnR], flags=Cougar.Verbose )
ruleLvx    = Lvx   .mkRule( 'lvx'
                          , [ rulePnR.file_target(1)
                            , ruleCougar.file_target(0) ]
                          , flags=Lvx.Flatten )
ruleDruc   = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleClean  = Clean .mkRule()
