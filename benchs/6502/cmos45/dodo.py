
from designflow.technos import setupCMOS45

setupCMOS45( useNsxlib=False, checkToolkit='../../..' )

DOIT_CONFIG = { 'verbosity' : 2 }

from designflow.copy     import Copy
from designflow.flatph   import Flatph
from designflow.cougar   import Cougar
from designflow.s2r      import S2R
from designflow.lvx      import Lvx
from designflow.druc     import Druc
from designflow.graal    import Graal
from designflow.dreal    import Dreal
from designflow.yosys    import Yosys
from designflow.blif2vst import Blif2Vst
from designflow.pnr      import PnR
from designflow.clean    import Clean
PnR.textMode = True

from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'm65s.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , 'm65s.vst', [ruleYosys], flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'm65s_cts_r.ap'
                                      , 'm65s_cts_r.vst'
                                      , 'm65s_cts_r.spi'
                                      , 'm65s.spi'
                                      ]
                                      , [ruleB2V]
                                    , scriptMain )
ruleCougar    = Cougar.mkRule( 'cougar', 'm65s_cts_r_ext.al', [rulePnR]
                             , flags=Cougar.Verbose|Cougar.Flatten )
ruleLvx       = Lvx   .mkRule( 'lvx'
                             , [ rulePnR.file_target(1)
                               , ruleCougar.file_target(0) ]
                             , flags=Lvx.Flatten )
ruleDruc      = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleGds       = S2R   .mkRule( 'gds', 'm65s_cts_r.gds', [rulePnR]
                             , flags=S2R.Verbose|S2R.NoReplaceBlackboxes )
ruleCgt       = PnR   .mkRule( 'cgt' )
ruleClean     = Clean .mkRule()
