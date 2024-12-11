
from coriolis.designflow.technos import setupCMOS45

setupCMOS45( useNsxlib=True, checkToolkit='../../..' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.copy     import Copy
from coriolis.designflow.flatph   import Flatph
from coriolis.designflow.cougar   import Cougar
from coriolis.designflow.s2r      import S2R
from coriolis.designflow.lvx      import Lvx
from coriolis.designflow.druc     import Druc
from coriolis.designflow.graal    import Graal
from coriolis.designflow.dreal    import Dreal
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
ruleFlatph    = Flatph.mkRule( 'flatph', 'chip_r_flat.ap', [rulePnR], flags=Flatph.Catalog )
ruleCougar    = Cougar.mkRule( 'cougar', 'chip_r_ext.al', [rulePnR]
                             , flags=Cougar.Verbose|Cougar.Flatten )
ruleLvx       = Lvx   .mkRule( 'lvx'
                             , [ rulePnR.file_target(1)
                               , ruleCougar.file_target(0) ]
                             , flags=Lvx.Flatten )
ruleDruc      = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleGds       = S2R   .mkRule( 'gds', 'chip_r.gds', [rulePnR]
                             , flags=S2R.Verbose|S2R.NoReplaceBlackboxes )
ruleCif       = S2R   .mkRule( 'cif', 'chip_r.cif', [rulePnR]
                             , flags=S2R.Verbose|S2R.NoReplaceBlackboxes )
ruleFlatGds   = S2R   .mkRule( 'flat_gds', 'chip_r_flat.gds', [ruleFlatph]
                             , flags=S2R.Verbose|S2R.NoReplaceBlackboxes )
ruleCgt       = PnR   .mkRule( 'cgt' )
ruleGraal     = Graal .mkRule( 'graal', [rulePnR] )
ruleDreal     = Dreal .mkRule( 'dreal', [ruleGds] )
ruleFlatGraal = Graal .mkRule( 'flat_graal', [ruleFlatph] )
ruleFlatDreal = Dreal .mkRule( 'flat_dreal', [ruleFlatGds] )
ruleClean     = Clean .mkRule()
