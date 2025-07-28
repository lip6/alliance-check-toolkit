#!/usr/bin/env python3

import sys
import os
import traceback
from   coriolis            import CRL
from   coriolis.Hurricane  import DbU, Breakpoint, DataBase, Library
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, l, u, n
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip
from   coriolis.plugins.core2chip.sky130    import CoreToChip
af = CRL.AllianceFramework.get()



def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    loadOpenROAD = False
    buildChip    = False
    rvalue       = True
    try:
        #setTraceLevel( 540 )
        #Breakpoint.setStopLevel( 100 )
        if 'CHECK_TOOLKIT' in os.environ:
            checkToolkitDir   = os.environ[ 'CHECK_TOOLKIT' ]
            harnessProjectDir = checkToolkitDir + '/cells/sky130'
        else:
            print( '[ERROR] The "CHECK_TOOLKIT" environment variable has not been set.'  )
            print( '        Please check "./mk/users.d/user-CONFIG.mk".'  )
            sys.exit( 1 )
        cell, editor = plugins.kwParseMain( **kw )

        if loadOpenROAD:
            db      = DataBase.getDB()
            tech    = db.getTechnology()
            rootlib = db.getRootLibrary()
            orLib   = Library.create(rootlib, 'OpenROAD')
            gdsPath = '../sky130_OpenROAD/picorv32_openroad.gds'
            CRL.Gds.load( orLib, gdsPath, CRL.Gds.Layer_0_IsBoundary|CRL.Gds.NoBlockages )
            af.wrapLibrary( orLib, 1 ) 
            cell, editor = plugins.kwParseMain( **kw )
            cell = af.getCell( 'picorv32', CRL.Catalog.State.Logical )
            if editor:
                editor.setCell( cell ) 
                editor.setDbuMode( DbU.StringModePhysical )
            return True

        cellName = 'picorv32'
        if buildChip:
            cellName += '_harness'
        cell = af.getCell( 'picorv32', CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        if buildChip:
            ioPinsSpec = [ ]
            ioPadsSpec = [ (None, None, 'power_0'  , 'vccd1'      , 'vdd'    )
                         , (None, None, 'ground_0' , 'vssd1'      , 'vss'    )
                         , (None, None, None       , 'io_in(37)'  , 'clk'    )
                         , (None, None, None       , 'io_in(0)'   , 'di(0)'  )
                         , (None, None, None       , 'io_in(1)'   , 'di(1)'  )
                         , (None, None, None       , 'io_in(2)'   , 'di(2)'  )
                         , (None, None, None       , 'io_in(3)'   , 'di(3)'  )
                         , (None, None, None       , 'io_in(4)'   , 'di(4)'  )
                         , (None, None, None       , 'io_in(5)'   , 'di(5)'  )
                         , (None, None, None       , 'io_in(6)'   , 'di(6)'  )
                         , (None, None, None       , 'io_in(7)'   , 'di(7)'  )
            
                         , (None, None, None       , 'io_out(8)'  , 'do(0)'  )
                         , (None, None, None       , 'io_out(9)'  , 'do(1)'  )
                         , (None, None, None       , 'io_out(10)' , 'do(2)'  )
                         , (None, None, None       , 'io_out(11)' , 'do(3)'  )
                         , (None, None, None       , 'io_out(12)' , 'do(4)'  )
                         , (None, None, None       , 'io_out(13)' , 'do(5)'  )
                         , (None, None, None       , 'io_out(14)' , 'do(6)'  )
                         , (None, None, None       , 'io_out(15)' , 'do(7)'  )
            
                         , (None, None, None       , 'io_in(16)'  , 'a(0)'   )
                         , (None, None, None       , 'io_in(17)'  , 'a(1)'   )
                         , (None, None, None       , 'io_in(18)'  , 'a(2)'   )
                         , (None, None, None       , 'io_in(19)'  , 'a(3)'   )
                         , (None, None, None       , 'io_in(20)'  , 'a(4)'   )
                         , (None, None, None       , 'io_in(21)'  , 'a(5)'   )
                         , (None, None, None       , 'io_in(22)'  , 'a(6)'   )
                         , (None, None, None       , 'io_in(23)'  , 'a(7)'   )
                         , (None, None, None       , 'io_in(24)'  , 'a(8)'   )
                         , (None, None, None       , 'io_in(25)'  , 'a(9)'   )
                         , (None, None, None       , 'io_in(26)'  , 'a(10)'  )
                         , (None, None, None       , 'io_in(27)'  , 'a(11)'  )
                         , (None, None, None       , 'io_in(28)'  , 'a(12)'  )
                         , (None, None, None       , 'io_in(29)'  , 'a(13)'  )
                         , (None, None, None       , 'io_in(30)'  , 'a(14)'  )
                         , (None, None, None       , 'io_in(31)'  , 'a(15)'  )
            
                         , (None, None, None       , 'io_in(32)'  , 'irq'    )
                         , (None, None, None       , 'io_in(33)'  , 'nmi'    )
                         , (None, None, None       , 'io_in(34)'  , 'rdy'    )
                         , (None, None, None       , 'io_in(35)'  , 'reset'  )
                         , (None, None, None       , 'io_in(36)'  , 'we'     )
                         ]
        else:
            m1pitch    = u(0.46)
            m2pitch    = u(0.51)
            vspace     = m2pitch * 10
            hspace     = m1pitch * 9
            ioPadsSpec = [ ]
            ioPinsSpec = [ (18, 'trace_data({})'  ,     vspace, vspace, range(0, 36))
                         , (18, 'mem_la_wdata({})',  38*vspace, vspace, range(0, 32))
                         , (18, 'mem_la_addr({})' ,  70*vspace, vspace, range(0, 32))
                         , (17, 'eoi({})'         ,     vspace, vspace, range(0, 32))
                         , (17, 'mem_addr({})'    ,  33*vspace, vspace, range(0, 32))
                         , (17, 'mem_wdata({})'   ,  65*vspace, vspace, range(0, 32))
                         , (17, 'mem_rdata({})'   ,  97*vspace, vspace, range(0,  4))
                         , (20, 'mem_rdata({})'   ,     hspace+5*m1pitch, hspace, range(4, 32))
                         , (20, 'irq({})'         ,  33*hspace, hspace, range(0, 32))
                         , (20, 'pcpi_insn({})'   ,  65*hspace, hspace, range(0, 32))
                         , (20, 'pcpi_rs1({})'    ,  97*hspace, hspace, range(0,  8))
                         , (24, 'pcpi_rs1({})'    ,     hspace, hspace, range(8, 32))
                         , (24, 'pcpi_rd({})'     ,  33*hspace, hspace, range(0, 32))
                         , (24, 'pcpi_rs2({})'    ,  97*hspace, hspace, range(8, 32))
                         , (24, 'mem_wstrb({})'   , 121*hspace, hspace, range(0,  4))
                         , (24, 'mem_la_wstrb({})', 125*hspace, hspace, range(0,  4))
                         , (24, 'mem_la_write'    , 129*hspace, 0, range(0, 1))
                         , (24, 'trap'            , 130*hspace, 0, range(0, 1))
                         , (24, 'resetn'          , 131*hspace, 0, range(0, 1))
                         , (24, 'mem_instr'       , 132*hspace, 0, range(0, 1))
                         , (24, 'mem_valid'       , 133*hspace, 0, range(0, 1))
                         , (24, 'mem_la_read'     , 134*hspace, 0, range(0, 1))
                         , (24, 'pcpi_wr'         , 135*hspace, 0, range(0, 1))
                         , (24, 'pcpi_wait'       , 136*hspace, 0, range(0, 1))
                         , (24, 'trace_valid'     , 137*hspace, 0, range(0, 1))
                         , (24, 'mem_ready'       , 138*hspace, 0, range(0, 1))
                         , (24, 'clk'             , 139*hspace, 0, range(0, 1))
                         , (24, 'pcpi_valid'      , 140*hspace, 0, range(0, 1))
                         , (24, 'pcpi_ready'      , 141*hspace-7*m1pitch, 0, range(0, 1))]
            #connectors placement in block design
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        conf.cfg.misc.catchCore              = False
        conf.cfg.misc.minTraceLevel          = 12300
        conf.cfg.misc.maxTraceLevel          = 12400
        conf.cfg.misc.info                   = False
        conf.cfg.misc.paranoid               = False
        conf.cfg.misc.bug                    = False
        conf.cfg.misc.logMode                = False
        conf.cfg.misc.verboseLevel1          = True
        conf.cfg.misc.verboseLevel2          = True
       #conf.cfg.etesian.bloat               = 'Flexlib'
        conf.cfg.etesian.densityVariation    = 0.05
        conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        conf.cfg.etesian.spaceMargin         = 0.02
        conf.cfg.anabatic.searchHalo         = 2
        conf.cfg.anabatic.globalIterations   = 20
        conf.cfg.anabatic.topRoutingLayer    = 'm4'
        conf.cfg.katana.hTracksReservedLocal = 10
        conf.cfg.katana.vTracksReservedLocal = 10
        conf.cfg.katana.hTracksReservedMin   = 4
        conf.cfg.katana.vTracksReservedMin   = 2
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = True
        conf.cfg.katana.dumpMeasures         = True
        conf.cfg.block.spareSide             = u(7*12)
        conf.cfg.chip.minPadSpacing          = u(1.46)
        conf.cfg.chip.supplyRailWidth        = u(20.0)
        conf.cfg.chip.supplyRailPitch        = u(40.0)
        if buildChip:
            conf.cfg.harness.path            = harnessProjectDir + '/user_project_wrapper.def'
        conf.editor              = editor
        conf.useSpares           = True
        conf.useClockTree        = True
        conf.useHFNS             = True
        conf.bColumns            = 2
        conf.bRows               = 2
        conf.chipName            = 'chip'
        conf.coreSize            = ( u( 788*0.76), u(100*6.0) )
        conf.chipSize            = ( u(   2020.0), u( 2060.0) )
        conf.coreToChipClass     = CoreToChip
        if buildChip:
            conf.useHTree( 'io_in_from_pad(0)', Spares.HEAVY_LEAF_LOAD )
            conf.useHTree( 'io_in_from_pad(28)' )
        else:
            conf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
            conf.useHTree( 'resetn' )
        #conf.useHTree( 'core.subckt_0_cpu.abc_11829_new_n340' )
        if buildChip:
            chipBuilder = Chip( conf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
            if editor:
                editor.setCell( conf.chip )
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( conf )
            rvalue = blockBuilder.doPnR()
            blockBuilder.save()
    except Exception as e:
        catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue


if __name__ == '__main__':
    rvalue = scriptMain()
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
