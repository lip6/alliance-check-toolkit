
# This file is part of the Coriolis Software.
# Copyright (c) Sorbonne Université 2019-2023, All Rights Reserved
#
# +-----------------------------------------------------------------+
# |                   C O R I O L I S                               |
# |          Alliance / Hurricane  Interface                        |
# |                                                                 |
# |  Author      :                    Jean-Paul CHAPUT              |
# |  E-mail      :            Jean-Paul.Chaput@lip6.fr              |
# | =============================================================== |
# |  Python      :       "./etc/symbolic/cmos45/__init__.py"        |
# +-----------------------------------------------------------------+


import coriolis.Cfg as Cfg
from   coriolis.helpers    import truncPath, tagConfModules
from   coriolis.helpers.io import vprint
vprint( 1, '  o  Loading "symbolic.cmos45" technology.' )
vprint( 2, '     - "%s".' % truncPath(__file__) )

from coriolis.Hurricane import DataBase
from coriolis.CRL       import System

Cfg.Configuration.pushDefaultPriority( Cfg.Parameter.Priority.ConfigurationFile )

DataBase.create()
System.get()

from . import misc
from . import technology
from . import display
from . import analog
from . import alliance
from . import etesian
from . import kite
from . import plugins
from . import stratus1

Cfg.Configuration.popDefaultPriority()

tagConfModules()
