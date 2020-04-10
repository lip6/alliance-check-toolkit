#!/usr/bin/python

import sys
import Cfg
import symbolic.cmos45
from   Hurricane import *
import CRL
from   helpers   import l


def toDbU ( value ): return DbU.fromPhysical( value, DbU.UnitPowerMicro )


def scriptMain ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']

    b1 = Box( l(0.0), l(0.0), l(10.0), l(5.0) )
    b2 = Box( l(0.0), l(0.0), l(10.0), l(5.0) )
    b3 = Box( l(0.0), l(0.0), l(10.0), l(6.0) )

    print 'b1:', repr(b1)
    print 'b2:', repr(b2)
    print 'b3:', repr(b3)

    if b1 == b2: print 'b1 == b2'
    else:        print 'b1 != b2'

    if b1 == b3: print 'b1 == b3'
    else:        print 'b1 != b3'

    af = CRL.AllianceFramework.get()
    cell1 = af.getCell( 'inv_x1', CRL.Catalog.State.Views )
    cell2 = af.getCell( 'inv_x1', CRL.Catalog.State.Views )
    cell3 = af.getCell( 'na2_x1', CRL.Catalog.State.Views )

    print 'cell1:', repr(cell1)
    print 'cell2:', repr(cell2)
    print 'cell3:', repr(cell3)

    if cell1 == cell2: print 'cell1 == cell2'
    else:              print 'cell1 != cell2'

    if cell1 == cell3: print 'cell1 == cell3'
    else:              print 'cell1 != cell3'

    if cell1 == b1: print 'cell1 == b1'
    else:           print 'cell1 != b1'

    if b1 == cell1: print 'b1 == cell1'
    else:           print 'b1 != cell1'

    return True
