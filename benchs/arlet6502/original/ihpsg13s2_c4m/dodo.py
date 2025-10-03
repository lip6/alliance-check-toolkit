
import os
from   pathlib import Path
from   pdks.ihpsg13g2_c4m import setup

setup( checkToolkit=Path('../../../..') )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis                               import CRL
from coriolis.designflow.task               import ShellEnv, Tasks
from coriolis.designflow.yosys              import Yosys
from coriolis.designflow.blif2vst           import Blif2Vst
from coriolis.designflow.klayout            import Klayout
from coriolis.designflow.pnr                import PnR
from coriolis.designflow.lvx                import Lvx
from coriolis.designflow.x2y                import x2y
from coriolis.designflow.tasyagle           import TasYagle, STA, XTas
from coriolis.designflow.alias              import Alias
from coriolis.designflow.clean              import Clean
from pdks.ihpsg13g2_c4m.designflow.filler   import Filler
from pdks.ihpsg13g2_c4m.designflow.sealring import SealRing
from pdks.ihpsg13g2_c4m.designflow.drc      import DRC
import doDesign

PnR.textMode       = True
pnrSuffix          = '_cts_r'
topName            = 'arlet6502'
#drcFlags           = DRC.SHOW_ERRORS
drcFlags           = 0

ruleYosys = Yosys   .mkRule( 'yosys', 'Arlet6502.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , 'arlet6502.vst', [ruleYosys], flags=0 )

if doDesign.buildChip:
    TasYagle.ClockName = 'clk_from_pad'
    # Rule for chip generation.
    ruleSeal  = SealRing.mkRule( 'sealring', targets=[ 'chip_r_seal.gds' ] , size=[2200.0, 2200.0] )
    rulePnR   = PnR.mkRule( 'gds'  , [ 'chip_r.gds'
                                     , 'chip_r.vst'
                                     , 'chip_r.spi'
                                     , 'chip.vst'
                                     , 'chip.spi'
                                     , 'corona_cts_r.vst'
                                     , 'corona_cts_r.spi'
                                     , 'corona.vst'
                                     , 'corona.spi'
                                     , 'Arlet6502_cts.spi'
                                     , 'arlet6502_cts.vst' ]
                                     , [ruleB2V, ruleSeal]
                                   , doDesign.scriptMain
                                   , topName=topName )
    staLayout = rulePnR.file_target( 6 )
else:
    TasYagle.ClockName = 'clk'
    # Rule for block generation.
    rulePnR = PnR.mkRule( 'gds'    , [ 'Arlet6502_cts_r.gds'
                                     , 'arlet6502_cts_r.vst'
                                     , 'Arlet6502_cts_r.spi' ]
                                     , [ruleB2V]
                                   , doDesign.scriptMain
                                   , topName=topName )
    ruleX2Y = x2y.mkRule( 'spi2vst', 'arlet6502_cts_r_spi.vst', 'Arlet6502_cts_r.spi' )
    ruleLvx = Lvx.mkRule( 'lvx_spi', [ 'arlet6502_cts_r.vst'
                                     , 'Arlet6502_cts_r.spi' ]
                                   , Lvx.MergeSupply|Lvx.Flatten )
    staLayout = rulePnR.file_target( 2 )

ruleDrcMin  = DRC    .mkRule( 'drc_min', rulePnR.file_target(0), drcFlags|DRC.Minimal )
ruleDrcMax  = DRC    .mkRule( 'drc_max', rulePnR.file_target(0), drcFlags|DRC.Maximal )
ruleDrcC4M  = DRC    .mkRule( 'drc_c4m', rulePnR.file_target(0), drcFlags|DRC.C4M )
ruleSTA     = STA    .mkRule( 'sta'    , staLayout )
ruleXTas    = XTas   .mkRule( 'xtas'   , ruleSTA.file_target(0) )
ruleCgt     = PnR    .mkRule( 'cgt' )
ruleKlayout = Klayout.mkRule( 'klayout', depends=rulePnR.file_target(0) )
ruleClean   = Clean  .mkRule( [ 'lefRWarning.log', 'cgt.log' ] )
