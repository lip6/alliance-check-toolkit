
import socket
from   pathlib import Path

#useTechno = 'MOSIS'
useTechno = 'AMS350'

if useTechno == 'AMS350':
    hostname = socket.gethostname()
    if hostname.startswith('lepka'):
        ndaTop = Path( '/dsk/l1/jpc/crypted/soc/techno' )
        if not ndaTop.is_dir():
            print( '[ERROR] You forgot to mount the NDA encrypted directory, stupid!' )
    else:
        ndaTop = '/users/soft/techno/techno'
    from coriolis.designflow.technos import setupAMS350
    setupAMS350( checkToolkit='../../../..', ndaTop=ndaTop )
elif useTechno == 'MOSIS':
    from coriolis.designflow.technos import setupMOSIS
    setupMOSIS( checkToolkit='../../../..' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task  import Tasks
from coriolis.designflow.pnr   import PnR
from coriolis.designflow.clean import Clean
PnR.textMode = True

from doOta import scriptMain

rulePnR   = PnR  .mkRule( 'pnr'  , [], [], scriptMain )
ruleCgt   = PnR  .mkRule( 'cgt' )
ruleClean = Clean.mkRule()
