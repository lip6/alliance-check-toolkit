
from coriolis.designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.copy     import Copy
from coriolis.designflow.cougar   import Cougar
from coriolis.designflow.graal    import Graal
from coriolis.designflow.lvx      import Lvx
from coriolis.designflow.druc     import Druc
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.clean    import Clean
PnR.textMode = True

from doDesign  import scriptMain

ruleAccu  = Copy.mkRule( 'accu' , 'accu.vst' , './non_generated/accu.vst'  )
ruleAlu   = Copy.mkRule( 'alu'  , 'alu.vst'  , './non_generated/alu.vst'   )
ruleCoeur = Copy.mkRule( 'coeur', 'coeur.vst', './non_generated/coeur.vst' )
ruleMuxe  = Copy.mkRule( 'muxe' , 'muxe.vst' , './non_generated/muxe.vst'  )
ruleMuxs  = Copy.mkRule( 'muxs' , 'muxs.vst' , './non_generated/muxs.vst'  )
ruleRam   = Copy.mkRule( 'ram'  , 'ram.vst'  , './non_generated/ram.vst'   )
rulePnR   = PnR .mkRule( 'pnr'  , [ 'am2901_r.ap'
                                  , 'am2901_r.vst'
                                  , 'am2901_r.spi'
                                  , 'am2901.vst'
                                  , 'am2901.spi'
                                  , 'corona_cts_r.ap'
                                  , 'corona_cts_r.vst'
                                  , 'corona_cts_r.spi'
                                  , 'corona.vst'
                                  , 'corona.spi'
                                  , 'coeur_cts.ap'
                                  , 'coeur_cts.vst'
                                  , 'coeur_cts.spi'
                                  , 'coeur.spi'
                                  , 'accu_cts.ap'
                                  , 'accu_cts.vst'
                                  , 'accu_cts.spi'
                                  , 'accu.spi'
                                  , 'ram_cts.ap'
                                  , 'ram_cts.vst'
                                  , 'ram_cts.spi'
                                  , 'ram.spi'
                                  , 'alu.ap'
                                  , 'alu.spi'
                                  , 'muxe.ap'
                                  , 'muxe.spi'
                                  , 'muxs.ap'
                                  , 'muxs.spi'
                                  ]
                                  , [ruleAccu, ruleAlu, ruleCoeur, ruleMuxe, ruleMuxs, ruleRam]
                                , scriptMain )
ruleCougar = Cougar.mkRule( 'cougar', 'am2901_r_ext.vst', [rulePnR], flags=Cougar.Verbose )
ruleLvx    = Lvx   .mkRule( 'lvx'
                          , [ rulePnR.file_target(1)
                            , ruleCougar.file_target(0) ]
                          , flags=Lvx.Flatten )
ruleDruc   = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleGraal  = Graal .mkRule( 'graal' , [rulePnR] )
ruleClean  = Clean .mkRule()
