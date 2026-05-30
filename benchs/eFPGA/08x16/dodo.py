
from coriolis.designflow.technos import setupCMOS
from coriolis import CRL

setupCMOS()

af  = CRL.AllianceFramework.get()
env = af.getEnvironment()
env.addSYSTEM_LIBRARY( library='../efpgalib', mode=CRL.Environment.Prepend )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task import Tasks
from coriolis.designflow      import routecheck

routecheck.mkRuleSet( globals(), 'matrix_8_16_flat' )
