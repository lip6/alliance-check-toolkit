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
import Unicorn


def ScriptMain ( **kw ):
  editor = None
  if kw.has_key('editor') and kw['editor']:
    editor = kw['editor']

  cell    = CRL.Blif.load( 'snx' )
  if editor: editor.setCell( cell )

  return cell
