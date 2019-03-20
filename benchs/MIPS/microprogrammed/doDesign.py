#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re
import traceback
import os.path
import optparse
import Cfg
import Hurricane
from   Hurricane import DbU
from   Hurricane import DataBase
from   Hurricane import UpdateSession
from   Hurricane import Breakpoint
from   Hurricane import Transformation
from   Hurricane import Instance
import Viewer
import CRL
from   helpers   import ErrorMessage
import Etesian
import Anabatic
import Katana
import Unicorn


def ScriptMain ( **kw ):
  editor = None
  if kw.has_key('editor') and kw['editor']:
    editor = kw['editor']

  cell = CRL.AllianceFramework.get().getCell( 'mips_core_flat', CRL.Catalog.State.Views )
  if editor: editor.setCell( cell )

  katana = Katana.KatanaEngine.create(cell)
  katana.digitalInit          ()
 #katana.runNegociatePreRouted()
  katana.runGlobalRouter      ()
  katana.loadGlobalRouting    ( Anabatic.EngineLoadGrByNet )
  katana.layerAssign          ( Anabatic.EngineNoNetLayerAssign )
  katana.runNegociate         ( Katana.Flags.NoFlags )

  return cell
