
from coriolis.designflow.technos import setupCMOS

setupCMOS()

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
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.clean    import Clean
PnR.textMode = True

from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'm65s.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , 'm65s.vst', [ruleYosys], flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'm65s_cts_r.ap'
                                      , 'm65s_cts_r.vst'
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
ruleCgt       = PnR   .mkRule( 'cgt', depends=[ruleB2V] )
ruleClean     = Clean .mkRule()
