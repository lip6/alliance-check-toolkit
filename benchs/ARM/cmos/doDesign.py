
import sys
import traceback
from   coriolis.Hurricane  import Breakpoint, DbU
from   coriolis            import Cfg, CRL
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import setTraceLevel, trace, overlay, l, u, n
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.core2chip.cmos      import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore               = False
        cfg.misc.info                    = False
        cfg.misc.paranoid                = False
        cfg.misc.bug                     = False
        cfg.misc.logMode                 = True
        cfg.misc.verboseLevel1           = True
        cfg.misc.verboseLevel2           = True
        cfg.misc.minTraceLevel           = 1590
        cfg.misc.maxTraceLevel           = 1600
        cfg.etesian.graphics             = 3
    DbU.setStringMode( DbU.StringModeSymbolic )

    global af
    rvalue = True
    try:
        #setTraceLevel( 550 )
        #Breakpoint.setStopLevel( 100 )
        buildChip    = True
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'arm_core', CRL.Catalog.State.Logical )
        if cell is None:
            print( ErrorMessage( 2, 'doDesign.scriptMain(): Unable to load cell "{}".'.format('arm_core') ))
            sys.exit( 1 )
        cell.uniquify( 100 )
        if editor: editor.setCell( cell ) 
        #     Spec:  | Side        | Pos | Instance     | Pad net     |Core net       |
        ioPadsSpec = [ (IoPin.SOUTH, None, 'if_adr_0'   , 'if_adr(0)' , 'if_adr(0)'   )
                     , (IoPin.SOUTH, None, 'if_adr_1'   , 'if_adr(1)' , 'if_adr(1)'   )
                     , (IoPin.SOUTH, None, 'if_adr_2'   , 'if_adr(2)' , 'if_adr(2)'   )
                     , (IoPin.SOUTH, None, 'if_adr_3'   , 'if_adr(3)' , 'if_adr(3)'   )
                     , (IoPin.SOUTH, None, 'if_adr_4'   , 'if_adr(4)' , 'if_adr(4)'   )
                     , (IoPin.SOUTH, None, 'if_adr_5'   , 'if_adr(5)' , 'if_adr(5)'   )
                     , (IoPin.SOUTH, None, 'if_adr_6'   , 'if_adr(6)' , 'if_adr(6)'   )
                     , (IoPin.SOUTH, None, 'if_adr_7'   , 'if_adr(7)' , 'if_adr(7)'   )
                     , (IoPin.SOUTH, None, 'if_adr_8'   , 'if_adr(8)' , 'if_adr(8)'   )
                     , (IoPin.SOUTH, None, 'if_adr_9'   , 'if_adr(9)' , 'if_adr(9)'   )
                     , (IoPin.SOUTH, None, 'if_adr_10'  , 'if_adr(10)', 'if_adr(10)'  )
                     , (IoPin.SOUTH, None, 'if_adr_11'  , 'if_adr(11)', 'if_adr(11)'  )
                     , (IoPin.SOUTH, None, 'if_adr_12'  , 'if_adr(12)', 'if_adr(12)'  )
                     , (IoPin.SOUTH, None, 'if_adr_13'  , 'if_adr(13)', 'if_adr(13)'  )
                     , (IoPin.SOUTH, None, 'if_adr_14'  , 'if_adr(14)', 'if_adr(14)'  )
                     , (IoPin.SOUTH, None, 'if_adr_15'  , 'if_adr(15)', 'if_adr(15)'  )
                     , (IoPin.SOUTH, None, 'allpower_0' , 'vddpad'    , 'vdd'         )
                     , (IoPin.SOUTH, None, 'allground_0', 'vsspad'    , 'vss'         )
                     , (IoPin.SOUTH, None, 'if_adr_16'  , 'if_adr(16)', 'if_adr(16)'  )
                     , (IoPin.SOUTH, None, 'if_adr_17'  , 'if_adr(17)', 'if_adr(17)'  )
                     , (IoPin.SOUTH, None, 'if_adr_18'  , 'if_adr(18)', 'if_adr(18)'  )
                     , (IoPin.SOUTH, None, 'if_adr_19'  , 'if_adr(19)', 'if_adr(19)'  )
                     , (IoPin.SOUTH, None, 'if_adr_20'  , 'if_adr(20)', 'if_adr(20)'  )
                     , (IoPin.SOUTH, None, 'if_adr_21'  , 'if_adr(21)', 'if_adr(21)'  )
                     , (IoPin.SOUTH, None, 'if_adr_22'  , 'if_adr(22)', 'if_adr(22)'  )
                     , (IoPin.SOUTH, None, 'if_adr_23'  , 'if_adr(23)', 'if_adr(23)'  )
                     , (IoPin.SOUTH, None, 'if_adr_24'  , 'if_adr(24)', 'if_adr(24)'  )
                     , (IoPin.SOUTH, None, 'if_adr_25'  , 'if_adr(25)', 'if_adr(25)'  )
                     , (IoPin.SOUTH, None, 'if_adr_26'  , 'if_adr(26)', 'if_adr(26)'  )
                     , (IoPin.SOUTH, None, 'if_adr_27'  , 'if_adr(27)', 'if_adr(27)'  )
                     , (IoPin.SOUTH, None, 'if_adr_28'  , 'if_adr(28)', 'if_adr(28)'  )
                     , (IoPin.SOUTH, None, 'if_adr_29'  , 'if_adr(29)', 'if_adr(29)'  )
                     , (IoPin.SOUTH, None, 'if_adr_30'  , 'if_adr(30)', 'if_adr(30)'  )
                     , (IoPin.SOUTH, None, 'if_adr_31'  , 'if_adr(31)', 'if_adr(31)'  )
                     , (IoPin.SOUTH, None, 'if_adr_valid_pad', 'if_adr_valid', 'if_adr_valid' )
                     , (IoPin.SOUTH, None, 'ic_stall_pad'    , 'ic_stall'    , 'ic_stall'     )
                     , (IoPin.SOUTH, None, 'mem_stw_pad'     , 'mem_stw'     , 'mem_stw'      )
                     , (IoPin.SOUTH, None, 'mem_stb_pad'     , 'mem_stb'     , 'mem_stb'      )
                     , (IoPin.SOUTH, None, 'mem_load_pad'    , 'mem_load'    , 'mem_load'     )
                     , (IoPin.SOUTH, None, 'reset_pad'       , 'reset_n'     , 'reset_n'      )
                     , (IoPin.SOUTH, None, 'dc_stall_pad'    , 'dc_stall'    , 'dc_stall'     )
                     , (IoPin.NORTH, None, 'clock_0'         , 'ck'          , 'ck'           )
                     , (IoPin.SOUTH, None, 'ic_inst_0'   , 'ic_inst(0)' , 'ic_inst(0)'   )
                     , (IoPin.SOUTH, None, 'ic_inst_1'   , 'ic_inst(1)' , 'ic_inst(1)'   )

                     , (IoPin.EAST, None, 'ic_inst_2'   , 'ic_inst(2)' , 'ic_inst(2)'   )
                     , (IoPin.EAST, None, 'ic_inst_3'   , 'ic_inst(3)' , 'ic_inst(3)'   )
                     , (IoPin.EAST, None, 'ic_inst_4'   , 'ic_inst(4)' , 'ic_inst(4)'   )
                     , (IoPin.EAST, None, 'ic_inst_5'   , 'ic_inst(5)' , 'ic_inst(5)'   )
                     , (IoPin.EAST, None, 'ic_inst_6'   , 'ic_inst(6)' , 'ic_inst(6)'   )
                     , (IoPin.EAST, None, 'ic_inst_7'   , 'ic_inst(7)' , 'ic_inst(7)'   )
                     , (IoPin.EAST, None, 'ic_inst_8'   , 'ic_inst(8)' , 'ic_inst(8)'   )
                     , (IoPin.EAST, None, 'ic_inst_9'   , 'ic_inst(9)' , 'ic_inst(9)'   )
                     , (IoPin.EAST, None, 'ic_inst_10'  , 'ic_inst(10)', 'ic_inst(10)'  )
                     , (IoPin.EAST, None, 'ic_inst_11'  , 'ic_inst(11)', 'ic_inst(11)'  )
                     , (IoPin.EAST, None, 'ic_inst_12'  , 'ic_inst(12)', 'ic_inst(12)'  )
                     , (IoPin.EAST, None, 'ic_inst_13'  , 'ic_inst(13)', 'ic_inst(13)'  )
                     , (IoPin.EAST, None, 'ic_inst_14'  , 'ic_inst(14)', 'ic_inst(14)'  )
                     , (IoPin.EAST, None, 'ic_inst_15'  , 'ic_inst(15)', 'ic_inst(15)'  )
                     , (IoPin.EAST, None, 'ic_inst_16'  , 'ic_inst(16)', 'ic_inst(16)'  )
                     , (IoPin.EAST, None, 'ic_inst_17'  , 'ic_inst(17)', 'ic_inst(17)'  )
                     , (IoPin.EAST, None, 'allpower_1'  , 'vddpad'     , 'vdd'          )
                     , (IoPin.EAST, None, 'allground_1' , 'vsspad'     , 'vss'          )
                     , (IoPin.EAST, None, 'ic_inst_18'  , 'ic_inst(18)', 'ic_inst(18)'  )  
                     , (IoPin.EAST, None, 'ic_inst_19'  , 'ic_inst(19)', 'ic_inst(19)'  )
                     , (IoPin.EAST, None, 'ic_inst_20'  , 'ic_inst(20)', 'ic_inst(20)'  )
                     , (IoPin.EAST, None, 'ic_inst_21'  , 'ic_inst(21)', 'ic_inst(21)'  )
                     , (IoPin.EAST, None, 'ic_inst_22'  , 'ic_inst(22)', 'ic_inst(22)'  )
                     , (IoPin.EAST, None, 'ic_inst_23'  , 'ic_inst(23)', 'ic_inst(23)'  )
                     , (IoPin.EAST, None, 'ic_inst_24'  , 'ic_inst(24)', 'ic_inst(24)'  )
                     , (IoPin.EAST, None, 'ic_inst_25'  , 'ic_inst(25)', 'ic_inst(25)'  )
                     , (IoPin.EAST, None, 'ic_inst_26'  , 'ic_inst(26)', 'ic_inst(26)'  )
                     , (IoPin.EAST, None, 'ic_inst_27'  , 'ic_inst(27)', 'ic_inst(27)'  )
                     , (IoPin.EAST, None, 'ic_inst_28'  , 'ic_inst(28)', 'ic_inst(28)'  )
                     , (IoPin.EAST, None, 'ic_inst_29'  , 'ic_inst(29)', 'ic_inst(29)'  )
                     , (IoPin.EAST, None, 'ic_inst_30'  , 'ic_inst(30)', 'ic_inst(30)'  )
                     , (IoPin.EAST, None, 'ic_inst_31'  , 'ic_inst(31)', 'ic_inst(31)'  )
                     , (IoPin.EAST, None, 'dc_data_31'  , 'dc_data(31)', 'dc_data(31)'  )
                     , (IoPin.EAST, None, 'dc_data_30'  , 'dc_data(30)', 'dc_data(30)'  )
                     , (IoPin.EAST, None, 'dc_data_29'  , 'dc_data(29)', 'dc_data(29)'  )
                     , (IoPin.EAST, None, 'dc_data_28'  , 'dc_data(28)', 'dc_data(28)'  )
                     , (IoPin.EAST, None, 'dc_data_27'  , 'dc_data(27)', 'dc_data(27)'  )
                     , (IoPin.EAST, None, 'dc_data_26'  , 'dc_data(26)', 'dc_data(26)'  )
                     , (IoPin.EAST, None, 'dc_data_25'  , 'dc_data(25)', 'dc_data(25)'  )
                     , (IoPin.EAST, None, 'dc_data_24'  , 'dc_data(24)', 'dc_data(24)'  )
                     , (IoPin.EAST, None, 'dc_data_23'  , 'dc_data(23)', 'dc_data(23)'  )
                     , (IoPin.EAST, None, 'dc_data_22'  , 'dc_data(22)', 'dc_data(22)'  )
                     , (IoPin.EAST, None, 'dc_data_21'  , 'dc_data(21)', 'dc_data(21)'  )
                     , (IoPin.EAST, None, 'dc_data_20'  , 'dc_data(20)', 'dc_data(20)'  )

                     , (IoPin.NORTH, None, 'mem_data_10', 'mem_data(10)', 'mem_data(10)'  )
                     , (IoPin.NORTH, None, 'mem_data_11', 'mem_data(11)', 'mem_data(11)'  )
                     , (IoPin.NORTH, None, 'mem_data_12', 'mem_data(12)', 'mem_data(12)'  )
                     , (IoPin.NORTH, None, 'mem_data_13', 'mem_data(13)', 'mem_data(13)'  )
                     , (IoPin.NORTH, None, 'mem_data_14', 'mem_data(14)', 'mem_data(14)'  )
                     , (IoPin.NORTH, None, 'mem_data_15', 'mem_data(15)', 'mem_data(15)'  )
                     , (IoPin.NORTH, None, 'mem_data_16', 'mem_data(16)', 'mem_data(16)'  )
                     , (IoPin.NORTH, None, 'mem_data_17', 'mem_data(17)', 'mem_data(17)'  )
                     , (IoPin.NORTH, None, 'mem_data_18', 'mem_data(18)', 'mem_data(18)'  )
                     , (IoPin.NORTH, None, 'mem_data_19', 'mem_data(19)', 'mem_data(19)'  )
                     , (IoPin.NORTH, None, 'mem_data_20', 'mem_data(20)', 'mem_data(20)'  )
                     , (IoPin.NORTH, None, 'mem_data_21', 'mem_data(21)', 'mem_data(21)'  )
                     , (IoPin.NORTH, None, 'mem_data_22', 'mem_data(22)', 'mem_data(22)'  )
                     , (IoPin.NORTH, None, 'mem_data_23', 'mem_data(23)', 'mem_data(23)'  )
                     , (IoPin.NORTH, None, 'mem_data_24', 'mem_data(24)', 'mem_data(24)'  )
                     , (IoPin.NORTH, None, 'mem_data_25', 'mem_data(25)', 'mem_data(25)'  )
                     , (IoPin.NORTH, None, 'mem_data_26', 'mem_data(26)', 'mem_data(26)'  )
                     , (IoPin.NORTH, None, 'mem_data_27', 'mem_data(27)', 'mem_data(27)'  )
                     , (IoPin.NORTH, None, 'mem_data_28', 'mem_data(28)', 'mem_data(28)'  )
                     , (IoPin.NORTH, None, 'mem_data_29', 'mem_data(29)', 'mem_data(29)'  )
                     , (IoPin.NORTH, None, 'mem_data_30', 'mem_data(30)', 'mem_data(30)'  )
                     , (IoPin.NORTH, None, 'mem_data_31', 'mem_data(31)', 'mem_data(31)'  )
                     , (IoPin.NORTH, None, 'dc_data_0'  , 'dc_data(0)' , 'dc_data(0)'   )
                     , (IoPin.NORTH, None, 'dc_data_1'  , 'dc_data(1)' , 'dc_data(1)'   )
                     , (IoPin.NORTH, None, 'allpower_2' , 'vddpad'     , 'vdd'          )
                     , (IoPin.NORTH, None, 'allground_2', 'vsspad'     , 'vss'          )
                     , (IoPin.NORTH, None, 'dc_data_2'  , 'dc_data(2)' , 'dc_data(2)'   )
                     , (IoPin.NORTH, None, 'dc_data_3'  , 'dc_data(3)' , 'dc_data(3)'   )
                     , (IoPin.NORTH, None, 'dc_data_4'  , 'dc_data(4)' , 'dc_data(4)'   )
                     , (IoPin.NORTH, None, 'dc_data_5'  , 'dc_data(5)' , 'dc_data(5)'   )
                     , (IoPin.NORTH, None, 'dc_data_6'  , 'dc_data(6)' , 'dc_data(6)'   )
                     , (IoPin.NORTH, None, 'dc_data_7'  , 'dc_data(7)' , 'dc_data(7)'   )
                     , (IoPin.NORTH, None, 'dc_data_8'  , 'dc_data(8)' , 'dc_data(8)'   )
                     , (IoPin.NORTH, None, 'dc_data_9'  , 'dc_data(9)' , 'dc_data(9)'   )
                     , (IoPin.NORTH, None, 'dc_data_10' , 'dc_data(10)', 'dc_data(10)'  )
                     , (IoPin.NORTH, None, 'dc_data_11' , 'dc_data(11)', 'dc_data(11)'  )
                     , (IoPin.NORTH, None, 'dc_data_12' , 'dc_data(12)', 'dc_data(12)'  )
                     , (IoPin.NORTH, None, 'dc_data_13' , 'dc_data(13)', 'dc_data(13)'  )
                     , (IoPin.NORTH, None, 'dc_data_14' , 'dc_data(14)', 'dc_data(14)'  )
                     , (IoPin.NORTH, None, 'dc_data_15' , 'dc_data(15)', 'dc_data(15)'  )
                     , (IoPin.NORTH, None, 'dc_data_16' , 'dc_data(16)', 'dc_data(16)'  )
                     , (IoPin.NORTH, None, 'dc_data_17' , 'dc_data(17)', 'dc_data(17)'  )
                     , (IoPin.NORTH, None, 'dc_data_18' , 'dc_data(18)', 'dc_data(18)'  )
                     , (IoPin.NORTH, None, 'dc_data_19' , 'dc_data(19)', 'dc_data(19)'  )
                       
                     , (IoPin.WEST, None, 'mem_adr_0'   , 'mem_adr(0)' , 'mem_adr(0)'   )
                     , (IoPin.WEST, None, 'mem_adr_1'   , 'mem_adr(1)' , 'mem_adr(1)'   )
                     , (IoPin.WEST, None, 'mem_adr_2'   , 'mem_adr(2)' , 'mem_adr(2)'   )
                     , (IoPin.WEST, None, 'mem_adr_3'   , 'mem_adr(3)' , 'mem_adr(3)'   )
                     , (IoPin.WEST, None, 'mem_adr_4'   , 'mem_adr(4)' , 'mem_adr(4)'   )
                     , (IoPin.WEST, None, 'mem_adr_5'   , 'mem_adr(5)' , 'mem_adr(5)'   )
                     , (IoPin.WEST, None, 'mem_adr_6'   , 'mem_adr(6)' , 'mem_adr(6)'   )
                     , (IoPin.WEST, None, 'mem_adr_7'   , 'mem_adr(7)' , 'mem_adr(7)'   )
                     , (IoPin.WEST, None, 'mem_adr_8'   , 'mem_adr(8)' , 'mem_adr(8)'   )
                     , (IoPin.WEST, None, 'mem_adr_9'   , 'mem_adr(9)' , 'mem_adr(9)'   )
                     , (IoPin.WEST, None, 'mem_adr_10'  , 'mem_adr(10)', 'mem_adr(10)'  )
                     , (IoPin.WEST, None, 'mem_adr_11'  , 'mem_adr(11)', 'mem_adr(11)'  )
                     , (IoPin.WEST, None, 'mem_adr_12'  , 'mem_adr(12)', 'mem_adr(12)'  )
                     , (IoPin.WEST, None, 'mem_adr_13'  , 'mem_adr(13)', 'mem_adr(13)'  )
                     , (IoPin.WEST, None, 'mem_adr_14'  , 'mem_adr(14)', 'mem_adr(14)'  )
                     , (IoPin.WEST, None, 'mem_adr_15'  , 'mem_adr(15)', 'mem_adr(15)'  )
                     , (IoPin.WEST, None, 'allpower_3'  , 'vddpad'     , 'vdd'          )
                     , (IoPin.WEST, None, 'allground_3' , 'vsspad'     , 'vss'          )
                     , (IoPin.WEST, None, 'mem_adr_16'  , 'mem_adr(16)', 'mem_adr(16)'  )
                     , (IoPin.WEST, None, 'mem_adr_17'  , 'mem_adr(17)', 'mem_adr(17)'  )
                     , (IoPin.WEST, None, 'mem_adr_18'  , 'mem_adr(18)', 'mem_adr(18)'  )
                     , (IoPin.WEST, None, 'mem_adr_19'  , 'mem_adr(19)', 'mem_adr(19)'  )
                     , (IoPin.WEST, None, 'mem_adr_20'  , 'mem_adr(20)', 'mem_adr(20)'  )
                     , (IoPin.WEST, None, 'mem_adr_21'  , 'mem_adr(21)', 'mem_adr(21)'  )
                     , (IoPin.WEST, None, 'mem_adr_22'  , 'mem_adr(22)', 'mem_adr(22)'  )
                     , (IoPin.WEST, None, 'mem_adr_23'  , 'mem_adr(23)', 'mem_adr(23)'  )
                     , (IoPin.WEST, None, 'mem_adr_24'  , 'mem_adr(24)', 'mem_adr(24)'  )
                     , (IoPin.WEST, None, 'mem_adr_25'  , 'mem_adr(25)', 'mem_adr(25)'  )
                     , (IoPin.WEST, None, 'mem_adr_26'  , 'mem_adr(26)', 'mem_adr(26)'  )
                     , (IoPin.WEST, None, 'mem_adr_27'  , 'mem_adr(27)', 'mem_adr(27)'  )
                     , (IoPin.WEST, None, 'mem_adr_28'  , 'mem_adr(28)', 'mem_adr(28)'  )
                     , (IoPin.WEST, None, 'mem_adr_29'  , 'mem_adr(29)', 'mem_adr(29)'  )
                     , (IoPin.WEST, None, 'mem_adr_30'  , 'mem_adr(30)', 'mem_adr(30)'  )
                     , (IoPin.WEST, None, 'mem_adr_31'  , 'mem_adr(31)', 'mem_adr(31)'  )
                     , (IoPin.WEST, None, 'mem_data_0'  , 'mem_data(0)', 'mem_data(0)'  )
                     , (IoPin.WEST, None, 'mem_data_1'  , 'mem_data(1)', 'mem_data(1)'  )
                     , (IoPin.WEST, None, 'mem_data_2'  , 'mem_data(2)', 'mem_data(2)'  )
                     , (IoPin.WEST, None, 'mem_data_3'  , 'mem_data(3)', 'mem_data(3)'  )
                     , (IoPin.WEST, None, 'mem_data_4'  , 'mem_data(4)', 'mem_data(4)'  )
                     , (IoPin.WEST, None, 'mem_data_5'  , 'mem_data(5)', 'mem_data(5)'  )
                     , (IoPin.WEST, None, 'mem_data_6'  , 'mem_data(6)', 'mem_data(6)'  )
                     , (IoPin.WEST, None, 'mem_data_7'  , 'mem_data(7)', 'mem_data(7)'  )
                     , (IoPin.WEST, None, 'mem_data_8'  , 'mem_data(8)', 'mem_data(8)'  )
                     , (IoPin.WEST, None, 'mem_data_9'  , 'mem_data(9)', 'mem_data(9)'  )
                     ]
        conf = ChipConf( cell , ioPins=[] , ioPads=ioPadsSpec )
       #conf.cfg.etesian.bloat                = 'nsxlib'
        conf.cfg.etesian.bloat                = 'disabled'
        conf.cfg.etesian.effort               = 2
        conf.cfg.etesian.densityVariation     = 0.05
        conf.cfg.etesian.aspectRatio          = 1.0
        conf.cfg.etesian.spaceMargin          = 0.10
        conf.cfg.block.spareSide              = l(350)
        conf.cfg.spares.maxSink               = 30
        conf.cfg.anabatic.topRoutingLayer     = 'METAL5'
        conf.cfg.katana.hTracksReservedLocal  = 14
        conf.cfg.katana.vTracksReservedLocal  = 13
        conf.cfg.katana.terminalReservedLocal = 10
        conf.cfg.katana.hTracksReservedMin    = 8
        conf.cfg.katana.vTracksReservedMin    = 7
        conf.cfg.katana.eventsLimit           = 4000000
        conf.cfg.katana.runRealignStage       = False
        conf.editor              = editor
        conf.useHFNS             = False
        conf.useSpares           = True
        conf.padsHavePosition    = False
        conf.bColumns            = 2
        conf.bRows               = 2
        conf.chipConf.name       = 'chip'
        conf.chipConf.ioPadGauge = 'pxlib'
        conf.coreSize            = ( l( 6100.0), l( 6150.0) )
        conf.chipSize            = ( l(10300.0), l(10300.0) )
        conf.coreToChipClass     = CoreToChip
        #conf.doLvx               = False
        conf.useHTree( 'ck' )
       #conf.useHTree( 'reset_n' )
        if buildChip:
            chipBuilder = Chip( conf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
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
