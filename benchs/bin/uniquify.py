#!/usr/bin/python

import sys
from   Hurricane import *
import CRL



def ScriptMain ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']

    if kw.has_key('cell') and kw['cell']:
      cell = kw['cell']
    if cell:
        print 'Uniquify:', cell
        UpdateSession.open()
        DebugSession.open( 10 )
        cell.uniquify( 1000 )
        DebugSession.close()
        UpdateSession.close()

    return True 


