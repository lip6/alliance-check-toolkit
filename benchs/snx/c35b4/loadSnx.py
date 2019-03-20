#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re
import traceback
import os.path
import optparse
import numpy      as     np
#from   matplotlib import pyplot
#from   matplotlib import ticker
import Cfg
import Hurricane
from   Hurricane  import DbU
from   Hurricane  import DataBase
from   Hurricane  import UpdateSession
from   Hurricane  import Breakpoint
from   Hurricane  import Transformation
from   Hurricane  import Instance
import Viewer     
import CRL        
from   helpers    import ErrorMessage
import Unicorn
import Etesian
import Anabatic
import Katana


class RouterProfile ( object ):

    @staticmethod
    def _xticklabel ( x, pos ): return '%dk' % (x/1000)

    def __init__ ( self, flags ):
      self.flags       = flags
      self.pathProfile = 'katana.profile.txt'
      self.priorities  = ( ([],[]), ([],[]), ([],[]), ([],[]), ([],[]), ([],[]) )
      self.plotted     = False
      self.eventTicks  = 0

      fdDatas = open( self.pathProfile, 'r' )
      for line in fdDatas.readlines():
        self.eventTicks += 1

        datas = line.split()
        for i in range(5):
          if float(datas[i+1]) != 0.0:
            self.priorities[i][0].append( datas[0  ] )
            self.priorities[i][1].append( float(datas[i+1]) )
      fdDatas.close()

      return


    def _plot ( self ):
      colors = [ 'b<', 'c<', 'r<', 'g<', 'y<' ]

      xticks = np.arange( 0, self.eventTicks+1, 1000 )

      figwidth = self.eventTicks/2000
      if figwidth < 5: figwidth = 5

      pyplot.figure( 1, figsize=(figwidth,5), dpi=200 )
      pyplot.axes  ( [ 0.01, 0.1, 0.98, 0.8 ]  )
      pyplot.title ( 'Katana Event Costs' )
      pyplot.xlabel( 'events(count)' )
      pyplot.ylabel( 'event priority' )
      pyplot.yscale( 'log' )
      pyplot.grid  ( True )
      axes = pyplot.gca()
      axes.set_xlim( 0, self.eventTicks+1 )
      axes.set_xticks( xticks )
      axes.xaxis.set_major_formatter(ticker.FuncFormatter(RouterProfile._xticklabel))
      for i in range(6):
        if not len(self.priorities[i][1]): continue

        pyplot.plot( self.priorities[i][0]
                   , self.priorities[i][1]
                   , colors[i]
                   , linewidth=1.0
                   , fillstyle="none"
                   , label='Metal %d' % (i+1) )

      pyplot.legend( frameon=False, loc='upper left', bbox_to_anchor=(0.0,1.12), ncol=6, numpoints=1 )
        
      self.plotted = True

    def savefig ( self ):
      if not self.plotted: self._plot()
      pyplot.savefig( 'katana.profile.pdf', format='pdf' )
      return

    def show ( self ):
      if not self.plotted: self._plot()
      pyplot.show()
      return

    def close ( self ):
      pyplot.close()
      return


def ScriptMain ( **kw ):
  editor = None
  if kw.has_key('editor') and kw['editor']:
    editor = kw['editor']

  library = CRL.LefImport.load( '/dsk/l1/jpc/crypted/soc/techno/AMS/035hv-4.10/cds/HK_C35/LEF/c35b4/c35b4.lef' )
  library = CRL.LefImport.load( '/dsk/l1/jpc/crypted/soc/techno/AMS/035hv-4.10/cds/HK_C35/LEF/c35b4/CORELIB.lef' )
  CRL.Blif.add( library )
  cell = CRL.Blif.load( 'snx' )

 #cell = DataBase.getDB().getCell( 'AND2X1' )
 #CRL.Gds.load( cell, '/dsk/l1/jpc/coriolis-2.x/work/DKs/FreePDK45/osu_soc/lib/source/gds/AND2X1.gds' )
  if editor: editor.setCell( cell )

  etesian = Etesian.EtesianEngine.create(cell)
  etesian.place()
  if editor: editor.fit()

 #Cfg.getParamBool('katana.profileEventCosts').setBool(True)

  katana = Katana.KatanaEngine.create(cell)
  katana.digitalInit          ()
  katana.runGlobalRouter      ()
  katana.loadGlobalRouting    ( Anabatic.EngineLoadGrByNet )
  katana.layerAssign          ( Anabatic.EngineLayerAssignNoGlobalM2V )
  katana.runNegociate         ( Katana.Flags.NoFlags )

 #profile = RouterProfile ( 0 )
 #profile.savefig()
 #profile.close()

  return cell
