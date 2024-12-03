
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
from coriolis.designflow          import alliancesynth
PnR.textMode = True

from doDesign  import scriptMain

alliancesynth.mkRuleSet( globals(), 'reg4.vhdl'     )
alliancesynth.mkRuleSet( globals(), 'inc16.vhdl'    )
alliancesynth.mkRuleSet( globals(), 'cla16.vhdl'    )
alliancesynth.mkRuleSet( globals(), 'alu16.vhdl'    , alliancesynth.HasFsm )
alliancesynth.mkRuleSet( globals(), 'type_dec.vhdl' )
alliancesynth.mkRuleSet( globals(), 'snx.vhdl'      , alliancesynth.HasFsm )

#ruleSnx   = Copy.mkRule( 'snx', 'snx.vst', './non_generated/snx.vst' )
rulePnR   = PnR .mkRule( 'pnr'  , [ 'chip_r.ap'
                                  , 'chip_r.vst'
                                  , 'chip_r.spi'
                                  , 'chip.vst'
                                  , 'chip.spi'
                                  , 'snx.spi'
                                  , 'snx_cts.ap'
                                  , 'snx_cts.vst'
                                  , 'snx_cts.spi'
                                  , 'snx_model.spi'
                                  , 'snx_model_cts.ap'
                                  , 'snx_model_cts.vst'
                                  , 'snx_model_cts.spi'
                                  , 'corona.vst'
                                  , 'corona.spi'
                                  , 'corona_cts_r.ap'
                                  , 'corona_cts_r.vst'
                                  , 'corona_cts_r.spi'
                                  , 'alu16.ap'
                                  , 'alu16.spi'
                                  , 'alu16_model.ap'
                                  , 'alu16_model.spi'
                                  , 'cla16.ap'
                                  , 'cla16.spi'
                                  , 'inc16.ap'
                                  , 'inc16.spi'
                                  , 'type_dec.ap'
                                  , 'type_dec.spi'
                                  , 'reg4.spi'
                                  , 'reg4_cts.ap'
                                  , 'reg4_cts.spi'
                                  , 'reg4_cts.vst'
                                  ]
                                  , [ ruleLoon_snx
                                    , ruleLoon_type_dec
                                    , ruleLoon_alu16
                                    , ruleLoon_cla16
                                    , ruleLoon_reg4
                                    , ruleLoon_inc16
                                    ]
                                , scriptMain )
ruleCougar = Cougar.mkRule( 'cougar', 'chip_r_ext.vst', [rulePnR], flags=Cougar.Verbose )
ruleLvx    = Lvx   .mkRule( 'lvx'
                          , [ rulePnR.file_target(1)
                            , ruleCougar.file_target(0) ]
                          , flags=Lvx.Flatten )
ruleDruc   = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleClean  = Clean .mkRule()
