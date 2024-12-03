
from coriolis.designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.copy     import Copy
from coriolis.designflow.cougar   import Cougar
from coriolis.designflow.lvx      import Lvx
from coriolis.designflow.druc     import Druc
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.clean    import Clean
PnR.textMode = True

from doDesign  import scriptMain

ruleAdder = Copy.mkRule( 'adder', 'adder.vst', './non_generated/adder.vst' )
rulePnR   = PnR .mkRule( 'pnr'  , [ 'chip_r.ap'
                                  , 'chip_r.vst'
                                  , 'chip_r.spi'
                                  , 'chip.vst'
                                  , 'chip.spi'
                                  , 'adder.spi'
                                  , 'adder_cts.ap'
                                  , 'adder_cts.vst'
                                  , 'adder_cts.spi'
                                  , 'corona.vst'
                                  , 'corona.spi'
                                  , 'corona_cts_r.ap'
                                  , 'corona_cts_r.vst'
                                  , 'corona_cts_r.spi'
                                  ]
                                  , [ruleAdder]
                                , scriptMain )
ruleCougar = Cougar.mkRule( 'cougar', 'chip_r_ext.vst', [rulePnR], flags=Cougar.Verbose )
ruleLvx    = Lvx   .mkRule( 'lvx'
                          , [ rulePnR.file_target(1)
                            , ruleCougar.file_target(0) ]
                          , flags=Lvx.Flatten )
ruleDruc   = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleClean  = Clean .mkRule()
