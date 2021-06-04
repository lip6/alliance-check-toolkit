#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os.path
import Cfg
import Hurricane
from   Hurricane  import DbU, DataBase, UpdateSession, Library, Cell
import Viewer     
import CRL        
from   helpers.io                import ErrorMessage
from   helpers.overlay           import UpdateSession
from   plugins.alpha.macro.macro import Macro


def scriptMain ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']
    with UpdateSession():
        pll = DataBase.getDB().getCell( 'pll' )
        Macro.wrap( pll, 'FlexLib', 3, 3 )
        if editor: editor.setCell( pll )
        CRL.Gds.save( pll )
    return pll
