#!/usr/bin/env python3

import sys
import numpy as np
import matplotlib
from matplotlib import pyplot
from matplotlib import ticker


class RouterProfile ( object ):

    @staticmethod
    def _xticklabel ( x, pos ): return '%dk' % (x/1000)

    def __init__ ( self, pathProfile ):
      self.pathProfile = pathProfile
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
      colors = [ 'b<', 'c<', 'r<', 'g<', 'm<' ]

      xticks = np.arange( 0, self.eventTicks+1, 1000 )

      figwidth = self.eventTicks/2000
      if figwidth < 5: figwidth = 5

      pyplot.figure( 1, figsize=(figwidth,5), dpi=200 )
      pyplot.axes  ( [ 0.01, 0.1, 0.98, 0.7 ]  )
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

      pyplot.legend( frameon=False, loc='upper left', bbox_to_anchor=(-0.0,1.2), ncol=6, numpoints=1 )
        
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


profile = RouterProfile ( 'katana.profile.txt' )
profile.savefig()
profile.close()
