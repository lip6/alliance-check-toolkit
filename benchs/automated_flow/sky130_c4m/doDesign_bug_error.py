#!/usr/bin/env python3

import sys
import os
import traceback
from   coriolis            import CRL
from   coriolis.Hurricane  import DbU, Breakpoint
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
    rvalue = True
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
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
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
            ioPadsSpec = [ ]
            ioPinsSpec 	= [(18, 'trace_data({})', 193800, 193800, range(0, 36)), (18, 'mem_la_wdata({})', 7170600, 193800, range(0, 32)), (18, 'mem_la_addr({})', 13372200, 193800, range(0, 32)), (17, 'eoi({})', 193800, 193800, range(0, 32)), (17, 'mem_addr({})', 6395400, 193800, range(0, 32)), (17, 'mem_wdata({})', 12597000, 193800, range(0, 32)), (17, 'mem_rdata({})', 18798600, 193800, range(0, 4)), (20, 'mem_rdata({})', 193200, 193200, range(4, 32)), (20, 'irq({})', 5602800, 193200, range(0, 32)), (20, 'pcpi_insn({})', 11785200, 193200, range(0, 32)), (20, 'pcpi_rs1({})', 17967600, 193200, range(0, 8)), (24, 'pcpi_rs1({})', 193200, 193200, range(8, 32)), (24, 'pcpi_rd({})', 4830000, 193200, range(0, 32)), (24, 'pcpi_rs2({})', 11012400, 193200, range(8, 32)), (24, 'mem_wstrb({})', 15649200, 193200, range(0, 4)), (24, 'mem_la_wstrb({})', 16422000, 193200, range(0, 4)), (24, 'mem_la_write', 17194800, 0, range(0, 1)), (24, 'trap', 17388000, 0, range(0, 1)), (24, 'resetn', 17581200, 0, range(0, 1)), (24, 'mem_instr', 17774400, 0, range(0, 1)), (24, 'mem_valid', 17967600, 0, range(0, 1)), (24, 'mem_la_read', 18160800, 0, range(0, 1)), (24, 'pcpi_wr', 18354000, 0, range(0, 1)), (24, 'pcpi_wait', 18547200, 0, range(0, 1)), (24, 'trace_valid', 18740400, 0, range(0, 1)), (24, 'mem_ready', 18933600, 0, range(0, 1)), (24, 'clk', 19126800, 0, range(0, 1)), (24, 'pcpi_valid', 19320000, 0, range(0, 1)), (24, 'pcpi_ready', 19513200, 0, range(0, 1))]
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
        conf.cfg.katana.hTracksReservedLocal = 6
        conf.cfg.katana.vTracksReservedLocal = 3
        conf.cfg.katana.hTracksReservedMin   = 3
        conf.cfg.katana.vTracksReservedMin   = 1
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
        conf.coreSize            = ( u( 1000), u(1000) )
        conf.chipSize            = ( u(  2020.0), u(  2060.0) )
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
