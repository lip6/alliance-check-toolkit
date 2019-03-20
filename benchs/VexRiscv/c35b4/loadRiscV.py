#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re
import traceback
import os
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


AMS_DIR = '/dsk/l1/jpc/crypted/soc/techno/AMS/035hv-4.10'


def ScriptMain ( **kw ):
  editor = None
  if kw.has_key('editor') and kw['editor']:
    editor = kw['editor']

 #Cfg.getParamPercentage('etesian.aspectRatio'   ).setPercentage(   50)
 #Cfg.getParamPercentage('etesian.spaceMargin'   ).setPercentage(   10)
 #Cfg.getParamBool      ('etesian.uniformDensity').setBool      ( True)

  LEF_LIBS  =       AMS_DIR + '/cds/HK_C35/LEF/c35b4/c35b4.lef'
  LEF_LIBS += ':' + AMS_DIR + '/cds/HK_C35/LEF/c35b4/CORELIB.lef'
  if os.environ.has_key('LEF_LIBS'):
    LEF_LIBS = os.environ['LEF_LIBS']

  for lefLib in LEF_LIBS.split(':'):
    library = CRL.LefImport.load( lefLib )
  CRL.Blif.add( library )
  cell = CRL.Blif.load( 'VexRiscv' )
  if editor: editor.setCell( cell )

  etesian = Etesian.EtesianEngine.create(cell)
  etesian.place()

  katana = Katana.KatanaEngine.create(cell)
  katana.digitalInit          ()
  katana.runNegociatePreRouted()
  katana.runGlobalRouter      ()
  katana.loadGlobalRouting    ( Anabatic.EngineLoadGrByNet )
  katana.layerAssign          ( Anabatic.EngineLayerAssignNoGlobalM2V )
  katana.runNegociate         ( Katana.Flags.NoFlags )

  return cell
