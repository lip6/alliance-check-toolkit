
from coriolis.designflow.technos import setupSky130_c4m

setupSky130_c4m( '../../..', '../../../pdkmaster/C4M.Sky130' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.alias    import Alias
from coriolis.designflow.clean    import Clean
PnR.textMode  = True


def printPnRSettings ():
    """
    Display on the terminals the size that will be used to define the GCell matrix.
    """
    from coriolis.Hurricane import DbU
    from coriolis           import CRL

    af = CRL.AllianceFramework.get()
    cellGauge   = af.getCellGauge()
    gcellHeight = cellGauge.getSliceHeight()
    gcellStep   = cellGauge.getSliceStep()
    gcellWidth  = cellGauge.getSliceHeight()
    if gcellWidth % gcellStep:
        gcellWidth = ((gcellWidth // gcellStep) + 1) * gcellStep
    gcellWidthStr = '{} ({} steps)'.format( DbU.getValueString(gcellWidth), gcellWidth // gcellStep )
    print( '' )
    print( '  +-----------------------------------------------------------+' )
    print( '  |                 Cell Gauge characterisics                 |' )
    print( '  +===========================================================+' )
    print( '  |          Parameter          |            Value            |' )
    print( '  +-----------------------------+-----------------------------+' )
    print( '  | Slice height & GCell height | {:27} |'.format( DbU.getValueString(gcellHeight) )) 
    print( '  | Slice step (GCell step)     | {:27} |'.format( DbU.getValueString(gcellStep  ) )) 
    print( '  | GCell width (computed)      | {:27} |'.format( gcellWidthStr )) 
    print( '  +-----------------------------+-----------------------------+' )
    print( '' )


printPnRSettings()


from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , [ 'arlet6502.vst' ]
                                    , [ruleYosys]
                                    , flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'arlet6502_cts_r.gds'
                                      , 'arlet6502_cts_r.spi'
                                      , 'arlet6502_cts_r.vst' ]
                                    , [ruleB2V]
                                    , scriptMain )
ruleCgt   = PnR     .mkRule( 'cgt' )
ruleGds   = Alias   .mkRule( 'gds', [rulePnR] )
ruleClean = Clean   .mkRule()
