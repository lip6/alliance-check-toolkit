
from coriolis.designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task  import Tasks
from coriolis.designflow       import routecheck
from coriolis.designflow.graal import Graal

routecheck.mkRuleSet( globals(), 'mips_core_flat' )
ruleGraal = Graal.mkRule( 'graal' )
