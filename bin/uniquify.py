#!/usr/bin/env python3

import sys
from   Hurricane import *
import CRL


def scriptMain ( **kw ):
    editor = None
    if 'editor' in kw and kw['editor']:
        editor = kw['editor']
    if 'cell' in kw and kw['cell']:
        cell = kw['cell']
    if cell:
        print( 'Uniquify:', cell )
        UpdateSession.open()
        DebugSession.open( 10 )
        cell.uniquify( 1000 )
        DebugSession.close()
        UpdateSession.close()
    return True 
