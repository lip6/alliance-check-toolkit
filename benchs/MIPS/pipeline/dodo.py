
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

rulePnR   = PnR .mkRule( 'pnr', [ 'mips_r3000_1m_core_flat_r.ap'
                                , 'mips_r3000_1m_core_flat_r.vst'
                                , 'mips_r3000_1m_core_flat_r.spi'
                                ]
                              , [ 'mips_r3000_1m_core_flat.vst'
                                , 'mips_r3000_1m_core_flat.ap'
                                ]
                              , scriptMain )
ruleCougar = Cougar.mkRule( 'cougar', 'mips_r3000_1m_core_flat_r_ext.vst', [rulePnR], flags=Cougar.Verbose )
ruleLvx    = Lvx   .mkRule( 'lvx'
                          , [ rulePnR.file_target(1)
                            , ruleCougar.file_target(0) ]
                          , flags=Lvx.Flatten )
ruleDruc   = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleClean  = Clean .mkRule()
