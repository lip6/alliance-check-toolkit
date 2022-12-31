
from designflow.technos import setupFreePDK45_c4m

setupFreePDK45_c4m( '../../..', '../../../../libre-soc/c4m-pdk-freepdk45' )

DOIT_CONFIG = { 'verbosity' : 2 }

import CRL
from designflow.pnr      import PnR
from designflow.yosys    import Yosys
from designflow.blif2vst import Blif2Vst
from designflow.alias    import Alias
from designflow.clean    import Clean
PnR.textMode  = True

from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , [ 'arlet6502.vst'
                                      , 'Arlet6502.spi' ]
                                    , [ruleYosys]
                                    , flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'chip_r.gds'
                                      , 'chip_r.spi'
                                      , 'chip_r.vst'
                                      , 'chip.vst'
                                      , 'chip.spi'
                                      , 'corona_cts_r.vst'
                                      , 'corona_cts_r.spi'
                                      , 'corona.vst'
                                      , 'corona.spi'
                                      , 'arlet6502.spi'
                                      , 'arlet6502_cts.vst'
                                      , 'arlet6502_cts.spi'
                                      ]
                                    , [ruleB2V]
                                    , scriptMain )
ruleCgt   = PnR     .mkRule( 'cgt' )
ruleGds   = Alias   .mkRule( 'gds', [rulePnR] )
ruleClean = Clean   .mkRule()
