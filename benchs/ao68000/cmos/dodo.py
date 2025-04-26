
from coriolis.designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task import Tasks
from coriolis.designflow      import pnrcheck

pnrcheck.mkRuleSet( globals(), 'ao68000', flags=pnrcheck.NoGDS )
