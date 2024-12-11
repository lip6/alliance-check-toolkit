
from coriolis.designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task   import Tasks
from coriolis.designflow.copy   import Copy
from coriolis.designflow.genpat import Genpat
from coriolis.designflow.asimut import Asimut
from coriolis.designflow.cougar import Cougar
from coriolis.designflow.lvx    import Lvx
from coriolis.designflow.druc   import Druc
from coriolis.designflow.pnr    import PnR
from coriolis.designflow.clean  import Clean
PnR.textMode = True

from ringoscillator import scriptMain

rulePnR    = PnR .mkRule  ( 'pnr'   , ['ringoscillator.ap', 'ringoscillator.vst']
                                    , ['ringoscillator.py']
                                    , scriptMain )
ruleGenpat = Genpat.mkRule( 'genpat', 'ringoscillator.pat', 'ringoscillator_pat.c' )
ruleAsimut = Asimut.mkRule( 'asimut', 'ringoscillator_sim.pat', [rulePnR.file_target(1), ruleGenpat] )
ruleCougar = Cougar.mkRule( 'cougar', 'ringoscillator_ext.vst', [rulePnR], flags=Cougar.Verbose )
ruleLvx    = Lvx   .mkRule( 'lvx'
                          , [ rulePnR.file_target(1)
                            , ruleCougar.file_target(0) ]
                          , flags=Lvx.Flatten )
ruleDruc   = Druc  .mkRule( 'druc', [rulePnR], flags=0 )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleClean  = Clean .mkRule()
