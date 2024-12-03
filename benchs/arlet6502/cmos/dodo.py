
from coriolis.designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task     import Tasks
from coriolis.designflow.task     import Tasks
from coriolis.designflow.cougar   import Cougar
from coriolis.designflow.lvx      import Lvx
from coriolis.designflow.druc     import Druc
from coriolis.designflow.pnr      import PnR
from coriolis.designflow.yosys    import Yosys
from coriolis.designflow.blif2vst import Blif2Vst
from coriolis.designflow.clean    import Clean
PnR.textMode = True

from doDesign import scriptMain

buildChip = True
if buildChip:
    pnrFiles = [ 'chip_r.ap'
               , 'chip_r.vst'
               , 'chip_r.spi'
               , 'chip.vst'
               , 'chip.spi'
               , 'corona_cts_r.ap'
               , 'corona_cts_r.vst'
               , 'corona_cts_r.spi'
               , 'corona.vst'
               , 'corona.spi'
               , 'arlet6502_cts.ap'
               , 'arlet6502_cts.vst'
               , 'arlet6502_cts.spi'
               , 'arlet6502.spi'
               ]
else:
    pnrFiles = [ 'arlet6502_cts_r.ap'
               , 'arlet6502_cts_r.vst'
               , 'arlet6502_cts_r.spi'
               ]

ruleYosys  = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
ruleB2V    = Blif2Vst.mkRule( 'b2v'  , 'arlet6502.vst', [ruleYosys], flags=0 )
rulePnR    = PnR     .mkRule( 'pnr'  , pnrFiles, [ruleB2V], scriptMain )
ruleCougar = Cougar  .mkRule( 'cougar'
                            , 'arlet6502_cts_r_ext.al'
                            , [rulePnR]
                            , flags=Cougar.Verbose|Cougar.Flatten )
ruleLvx    = Lvx     .mkRule( 'lvx'
                            , [ rulePnR.file_target(1)
                              , ruleCougar.file_target(0) ]
                            , flags=Lvx.Flatten )
ruleDruc   = Druc    .mkRule( 'druc', [rulePnR], flags=0 )
ruleCgt    = PnR     .mkRule( 'cgt' )
ruleClean  = Clean   .mkRule()
