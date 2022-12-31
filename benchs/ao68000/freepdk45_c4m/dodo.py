
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

ruleYosys = Yosys   .mkRule( 'yosys', 'ao68000.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , [ 'ao68000.vst'
                                      , 'ao68000.spi' ]
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
                                      , 'ao68000_cts.vst'
                                      , 'ao68000_cts.spi'
                                      ]
                                    , [ruleB2V]
                                    , scriptMain )
ruleCgt   = PnR     .mkRule( 'cgt' )
ruleGds   = Alias   .mkRule( 'gds', [rulePnR] )
ruleClean = Clean   .mkRule( [ 'corona.00.density.histogram.dat'
                             , 'corona.00.density.histogram.plt'
                             , 'corona.katana.dat' ] ) 

