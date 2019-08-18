#!/usr/bin/env python

enableProfiling = False

try:
  import sys
  import re
  import traceback
  import os.path
  import optparse
  import Cfg        
  import Hurricane  
  from   Hurricane  import DbU
  from   Hurricane  import UpdateSession
  from   Hurricane  import Breakpoint
  from   Hurricane  import Transformation
  from   Hurricane  import Instance
  import Viewer
  import CRL
  import helpers
  from   helpers.io import ErrorMessage
  from   helpers    import showPythonTrace
  import Anabatic
  import Katana
  import Etesian
  import Katabatic
  import Kite
  import Unicorn
  import clocktree.ClockTree
  import plugins
  import plugins.ClockTreePlugin
 #import plugins.CoreToChip_cmos
  import plugins.ChipPlace
  import plugins.RSavePlugin
  if enableProfiling:
    import numpy      as     np
    from   matplotlib import pyplot
    from   matplotlib import ticker
except ImportError, e:
  showPythonTrace( __file__, e, False )
  sys.exit(1)
except Exception, e:
  showPythonTrace( __file__, e )
  sys.exit(2)


GenerateChip  = 0x0001
DoChip        = 0x0002
DoClockTree   = 0x0004
DoPlacement   = 0x0008
DoRouting     = 0x0010
UseKite       = 0x0020
ProfileRouter = 0x0040
ChipStages    = DoChip|DoPlacement|DoRouting

framework     = CRL.AllianceFramework.create(0)
print framework.getEnvironment().getPrint()

technoName = Hurricane.DataBase.getDB().getTechnology().getName()
coreToChip = None
if technoName == 'cmos':  import plugins.CoreToChip_cmos
if technoName == 'c35b4': import plugins.CoreToChip_c35b4


class RouterProfile ( object ):

    @staticmethod
    def _xticklabel ( x, pos ): return '%dk' % (x/1000)

    def __init__ ( self, flags ):
      self.flags       = flags
      self.routerName  = 'katana'
      if flags & UseKite: self.routerName = 'kite'
      self.pathProfile = self.routerName + '.profile.txt'
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
      pyplot.title ( '%s Event Costs' % self.routerName.capitalize() )
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
      pyplot.savefig( '%s.profile.pdf' % self.routerName, format='pdf' )
      return

    def show ( self ):
      if not self.plotted: self._plot()
      pyplot.show()
      return

    def close ( self ):
      pyplot.close()
      return


def ScriptMain ( **kw ):
  success  = False
  doStages = kw['doStages']
  views    = kw['views']

  try:
    cell, editor = plugins.kwParseMain( **kw )
    corona       = None
    chip         = None 

    if doStages & GenerateChip:
      print '  o  Technology selected for I/O pad ring: %s.' % technoName
      if technoName == 'cmos':  success = plugins.CoreToChip_cmos .ScriptMain( **kw )
      if technoName == 'c35b4': success = plugins.CoreToChip_c35b4.ScriptMain( **kw )
      if not success: return False

      for instance in cell.getSlaveInstances():
        corona = instance.getCell()
        break

      for instance in corona.getSlaveInstances():
        chip = instance.getCell()
        break

      cell         = chip
      kw[ 'cell' ] = cell

    if doStages & DoPlacement:
      if doStages & DoChip:
        chip    = cell
        success = plugins.ChipPlace.ScriptMain( **kw )
        if not success: return False

        coronaPattern = re.compile(r'.*corona.*')
        for instance in cell.getInstances():
          if coronaPattern.match( instance.getName() ):
            cell   = instance.getMasterCell()
            corona = cell
            
        if not corona:          
          print '[ERROR] Cannot guess the corona instance/model, must contains the word "corona"...'
          sys.exit(1)
      else:
       #if cell.getAbutmentBox().isEmpty():
       #  cellGauge   = framework.getCellGauge()
       #  spaceMargin = (Cfg.getParamPercentage('etesian.spaceMargin').asPercentage()) / 100.0
       #  aspectRatio =  Cfg.getParamPercentage('etesian.aspectRatio').asPercentage()  / 100.0
       #  clocktree.ClockTree.computeAbutmentBox( cell, spaceMargin, aspectRatio, cellGauge )
       #  if editor: editor.fit()

        if doStages & DoClockTree:
          success = plugins.ClockTreePlugin.ScriptMain( **kw )
         #if not success: return False
        else:
          print cell
          etesian = Etesian.EtesianEngine.create( cell )
          etesian.place()
          etesian.destroy()
      if editor: editor.refresh()
      plugins.RSavePlugin.ScriptMain( **kw )

    if doStages & DoRouting:
      routingNets = []
      if doStages & UseKite:
        kite = Kite.KiteEngine.create( cell )
        kite.runGlobalRouter  ( Kite.KtBuildGlobalRouting )
        kite.loadGlobalRouting( Katabatic.EngineLoadGrByNet, routingNets )
        kite.layerAssign      ( Katabatic.EngineNoNetLayerAssign )
        kite.runNegociate     ()
        success = kite.getToolSuccess()
        kite.finalizeLayout()
        kite.destroy()
      else:
        katana = Katana.KatanaEngine.create( cell )
       #katana.printConfiguration   ()
        katana.digitalInit          ()
       #katana.runNegociatePreRouted()
        katana.runGlobalRouter      ()
        katana.loadGlobalRouting    ( Anabatic.EngineLoadGrByNet )
        katana.layerAssign          ( Anabatic.EngineNoNetLayerAssign )
        katana.runNegociate         ( Katana.Flags.NoFlags )
        success = katana.getToolSuccess()
        katana.finalizeLayout()
        katana.destroy()

    if doStages & DoPlacement:
      plugins.RSavePlugin.ScriptMain( **kw )

    if doStages & DoRouting:
      if doStages & DoChip: cell = chip
      
      saveCellName  = cell.getName()
      saveCellName += '_r'
      cell.setName( saveCellName )
      framework.saveCell( cell, CRL.Catalog.State.Views|views )

    if doStages & ProfileRouter:
      profile = RouterProfile ( doStages )
      profile.savefig()
      profile.close()
      return
      

  except Exception, e:
    print e

  return success


if __name__ == '__main__':
  try:
    parser = optparse.OptionParser()
    parser.add_option( '-c', '--cell'  , type='string',                      dest='cell'         , help='The name of the chip to build, without extension.')
    parser.add_option( '-s', '--script', type='string',                      dest='script'       , help='The name of a Python script, without extension.')
    parser.add_option( '-b', '--blif'  , type='string',                      dest='blif'         , help='The name of a BLIF netlist, without extension.')
    parser.add_option( '-v', '--verbose'              , action='store_true', dest='verbose'      , help='First level of verbosity.')
    parser.add_option( '-V', '--very-verbose'         , action='store_true', dest='veryVerbose'  , help='Second level of verbosity.')
    parser.add_option( '-p', '--place'                , action='store_true', dest='doPlacement'  , help='Perform chip placement step only.')
    parser.add_option( '-r', '--route'                , action='store_true', dest='doRouting'    , help='Perform routing step only.')
    parser.add_option( '-G', '--generate-chip'        , action='store_true', dest='generateChip' , help='Generate a chip netlist from a core.')
    parser.add_option( '-C', '--chip'                 , action='store_true', dest='doChip'       , help='Run place & route on a complete chip.')
    parser.add_option( '-T', '--clock-tree'           , action='store_true', dest='doClockTree'  , help='In block mode, create a clock-tree.')
    parser.add_option( '-K', '--kite'                 , action='store_true', dest='useKite'      , help='Use old Knik/Kite digital only router.')
    parser.add_option(       '--profile'              , action='store_true', dest='profileRouter', help='Activate cost profiling of Kite/Katana.')
    parser.add_option( '-S', '--save-all'             , action='store_true', dest='saveAll'      , help='Save both physical and logical views.')
    parser.add_option(       '--vst-use-concat'       , action='store_true', dest='vstUseConcat' , help='The VST driver will use "&" (concat) in PORT MAP.')
    (options, args) = parser.parse_args()
    
    views    = CRL.Catalog.State.Physical
    doStages = 0
    if options.verbose:
      Cfg.getParamBool('misc.verboseLevel1').setBool(True)
    if options.veryVerbose:
      Cfg.getParamBool('misc.verboseLevel1').setBool(True)
      Cfg.getParamBool('misc.verboseLevel2').setBool(True)
    if options.saveAll:      views    |= CRL.Catalog.State.Logical
    if options.vstUseConcat: views    |= CRL.Catalog.State.VstUseConcat
    if options.doPlacement:  doStages |= DoPlacement
    if options.doRouting:    doStages |= DoRouting
    if options.doChip:       doStages |= DoChip
    if options.generateChip: doStages |= GenerateChip
    if options.doClockTree:  doStages |= DoClockTree
    if options.useKite  :    doStages |= UseKite  
    if not doStages:         doStages  = ChipStages
    if options.profileRouter:
      Cfg.getParamBool(  'kite.profileEventCosts').setBool(True)
      Cfg.getParamBool('katana.profileEventCosts').setBool(True)
      doStages |= ProfileRouter
    
    kw = { 'doStages':doStages, 'views':views }
    if options.script:
      try:
        sys.path.append(os.path.dirname(options.script))
       #print sys.path
    
        module = __import__( options.script, globals(), locals() )
        if not module.__dict__.has_key('ScriptMain'):
            print '[ERROR] Script module <%s> do not contains a ScripMain() function.' % options.script
            sys.exit(1)
    
        cell = module.__dict__['ScriptMain']( **kw )
        kw['cell'] = cell
    
      except ImportError, e:
        module = str(e).split()[-1]
        print '[ERROR] The <%s> script cannot be loaded.' % module
        print '        Please check your design hierarchy.'
        sys.exit(1)
      except Exception, e:
        print '[ERROR] A strange exception occurred while loading the Python'
        print '        script <%s>. Please check that module for error:\n' % options.script
        showPythonTrace( options.script, e )
        sys.exit(2)
    elif options.cell:
      kw['cell'] = framework.getCell( options.cell, CRL.Catalog.State.Views )
      if not kw['cell']:
        print '[ERROR] Unable to load cell "%s" (option "--cell=...")' % options.cell
    elif options.blif:
      kw['cell'] = CRL.Blif.load( options.blif )
      if not kw['cell']:
        print '[ERROR] Unable to load cell "%s" (option "--blif=...")' % options.blif
    
    success      = ScriptMain( **kw )
    shellSuccess = 0
    if not success: shellSuccess = 1

  except Exception, e:
    helpers.io.catch( e )

  sys.exit( shellSuccess )
