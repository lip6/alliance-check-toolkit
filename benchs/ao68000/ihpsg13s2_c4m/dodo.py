
import os
from   pathlib import Path
from   pdks.ihpsg13g2_c4m import setup

setup( checkToolkit=Path('../../..') )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task               import ShellEnv, Tasks
from coriolis.designflow.pnr                import PnR
from coriolis.designflow.yosys              import Yosys
from coriolis.designflow.blif2vst           import Blif2Vst
from coriolis.designflow.alias              import Alias
from coriolis.designflow.klayout            import DRC
from coriolis.designflow.tasyagle           import TasYagle, STA, XTas
from coriolis.designflow.clean              import Clean
from pdks.ihpsg13g2_c4m.designflow.filler   import Filler
from pdks.ihpsg13g2_c4m.designflow.sealring import SealRing
from pdks.ihpsg13g2_c4m.designflow.drc      import DRC
PnR.textMode  = True

from doDesign  import scriptMain

ruleYosys = Yosys   .mkRule( 'yosys', 'ao68000.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , [ 'ao68000.vst' ]
                                    , [ruleYosys]
                                    , flags=0 )
rulePnR   = PnR     .mkRule( 'pnr'  , [ 'ao68000_cts_r.gds'
                                      , 'ao68000_cts_r.spi'
                                      , 'ao68000_cts_r.vst' ]
                                    , [ruleYosys]
                                    , scriptMain )
staLayout   = rulePnR.file_target( 2 )
ruleCgt     = PnR    .mkRule( 'cgt' )
ruleGds     = Alias  .mkRule( 'gds'    , [rulePnR] )
ruleDrcMin  = DRC    .mkRule( 'drc_min', rulePnR.file_target(0), DRC.Minimal )
ruleDrcMax  = DRC    .mkRule( 'drc_max', rulePnR.file_target(0), DRC.Maximal )
ruleDrcC4M  = DRC    .mkRule( 'drc_c4m', rulePnR.file_target(0), DRC.C4M )
ruleSTA     = STA    .mkRule( 'sta'    , staLayout )
ruleXTas    = XTas   .mkRule( 'xtas'   , ruleSTA.file_target(0) )
ruleClean   = Clean  .mkRule( [ 'ao68000.00.density.histogram.dat'
                             , 'ao68000.00.density.histogram.plt'
                             , 'ao68000.katana.dat' ] ) 
