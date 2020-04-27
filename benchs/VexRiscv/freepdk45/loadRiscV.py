#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re
import traceback
import os.path
import optparse
import helpers
from   helpers.io import ErrorMessage
from   helpers    import showPythonTrace
helpers.loadUserSettings()
import Hurricane
from   Hurricane import DbU
from   Hurricane import DataBase
from   Hurricane import UpdateSession
from   Hurricane import Breakpoint
from   Hurricane import Transformation
from   Hurricane import Instance
import Viewer
import CRL
import Etesian
import Anabatic
import Katana
import Unicorn


def scriptMain ( **kw ):
  editor = None
  if kw.has_key('editor') and kw['editor']:
    editor = kw['editor']

  library = CRL.LefImport.load( '/dsk/l1/jpc/coriolis-2.x/work/DKs/FreePDK45/osu_soc/lib/files/gscl45nm.lef' )
  CRL.Blif.add( library )
  cell = CRL.Blif.load( 'VexRiscv' )
  if editor: editor.setCell( cell )

  etesian = Etesian.EtesianEngine.create( cell )
  etesian.place()

  katana = Katana.KatanaEngine.create( cell )
  katana.digitalInit          ()
  katana.runGlobalRouter      ( Katana.Flags.NoFlags )
  katana.loadGlobalRouting    ( Anabatic.EngineLoadGrByNet )
  katana.layerAssign          ( Anabatic.EngineNoNetLayerAssign )
  katana.runNegociate         ( Katana.Flags.NoFlags )

  CRL.Gds.save( cell )

  return cell
