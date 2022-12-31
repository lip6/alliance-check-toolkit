
from designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from designflow import routecheck

routecheck.mkRuleSet( globals(), 'operator_lvl0_flat' )
