
from coriolis.designflow.technos import setupCMOS45

setupCMOS45( checkToolkit='../../../..' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task import Tasks
from coriolis.designflow      import pnrcheck

pnrcheck.mkRuleSet( globals(), 'VexRiscv', pnrcheck.UseClockTree )
