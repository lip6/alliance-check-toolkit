
from designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from designflow import pnrcheck

pnrcheck.mkRuleSet( globals(), 'VexRiscv' )
