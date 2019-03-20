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
  enforceVhdl = False
  editor      = None
  if kw.has_key('editor') and kw['editor']:
    editor = kw['editor']

  checkCell = None
  library = CRL.LefImport.load( '/dsk/l1/jpc/coriolis-2.x/work/DKs/FreePDK45/osu_soc/lib/files/gscl45nm.lef' )
  for stdCell in library.getCells():
    stdCellGds = '/dsk/l1/jpc/coriolis-2.x/work/DKs/FreePDK45/osu_soc/lib/source/gds/' \
               + stdCell.getName() + '.gds'
    CRL.Gds.load( library, stdCellGds )

  CRL.Blif.add( library )
  cell = CRL.Blif.load( 'snx', enforceVhdl )
  if editor: editor.setCell( cell )

  etesian = Etesian.EtesianEngine.create(cell)
  etesian.place()
  if editor: editor.fit()

  katana = Katana.KatanaEngine.create(cell)
  katana.digitalInit          ()
 #katana.runNegociatePreRouted()
  katana.runGlobalRouter      ()
  katana.loadGlobalRouting    ( Anabatic.EngineLoadGrByNet )
  katana.layerAssign          ( Anabatic.EngineNoNetLayerAssign )
  katana.runNegociate         ( Katana.Flags.NoFlags )

  return cell
