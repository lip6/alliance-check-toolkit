
from coriolis.designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.genpat   import Genpat
from coriolis.designflow.asimut   import Asimut
from coriolis.designflow.cougar   import Cougar
from coriolis.designflow.lvx      import Lvx
from coriolis.designflow.druc     import Druc
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.clean    import Clean
PnR.textMode = True

from doDesign  import scriptMain

rulePnR   = PnR     .mkRule( 'pnr'  , [ 'spram_256x32.ap'
                                      , 'spram_256x32.vst'
                                      , 'spram_256x32.spi' ]
                                      , [ 'doDesign.py' ]
                                    , scriptMain )
ruleCougar = Cougar.mkRule( 'cougar', 'spram_256x32_ext.vst', [rulePnR], flags=Cougar.Verbose )
ruleLvx    = Lvx   .mkRule( 'lvx'
                          , [ rulePnR.file_target(1)
                            , ruleCougar.file_target(0) ]
                          , flags=Lvx.Flatten )
ruleDruc   = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleGenpat = Genpat.mkRule( 'genpat', 'spram_256x32.pat', 'spram_256x32_pat.c' )
ruleAsimut = Asimut.mkRule( 'asimut', 'spram_256x32_sim.pat'
                                    , [rulePnR.file_target(1)
                                    , ruleGenpat]
                                    , flags=Asimut.ZeroDelay )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleClean  = Clean .mkRule()
