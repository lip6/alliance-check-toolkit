from   Hurricane import *
from   CRL       import *
import Etesian


def place ( cell ):
    etesian = Etesian.EtesianEngine.create(cell)
    etesian.place()
    return


def removeAlmostAllNets ( cell ):
    keep = [ 'ialu.aux28'
           ]
    netsToDestroy = []

    UpdateSession.open()
    for net in cell.getNets():
       if net.isSupply(): continue
       if net.getName() in keep: continue
       netsToDestroy.append( net )
       
    for net in netsToDestroy:
      net.destroy()

    UpdateSession.close()
    return


def scriptMain ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']

    if editor:
      cell = AllianceFramework.get().getCell( 'coeur', Catalog.State.Logical )
      if cell:
        editor.setCell( cell )
        place( cell )
        editor.fit()
       #removeAlmostAllNets( cell )
             
    return True
