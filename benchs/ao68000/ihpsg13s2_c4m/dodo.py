
import os
from   pathlib import Path
from   doit    import get_var
from   pdks.ihpsg13g2_c4m import setup

setup( checkToolkit=Path('../../..') )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task               import ShellEnv, Tasks
from coriolis.designflow.copy               import Copy
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
PnR.textMode = True
reuseBlif    = get_var( 'reuse-blif', None )


from doDesign  import scriptMain

if reuseBlif:
    ruleYosys = Copy.mkRule( 'yosys', 'ao68000.blif', './non_generateds/ao68000.{}.blif'.format( reuseBlif ))
else:
    ruleYosys = Yosys   .mkRule( 'yosys', 'ao68000.v' )

rulePnR   = PnR     .mkRule( 'pnr'  , [ 'ao68000_cts_r.gds'
                                      , 'ao68000_cts_r.spi'
                                      , 'ao68000_cts_r.vst' ]
                                    , [ruleYosys]
                                    , scriptMain )
staLayout   = rulePnR.file_target( 2 )
ruleCgt     = PnR    .mkRule( 'cgt' )
ruleGds     = Alias  .mkRule( 'gds' , [rulePnR] )
ruleDrc     = DRC    .mkRule( 'drc' , rulePnR.file_target(0), DRC.NoDensity )
ruleSTA     = STA    .mkRule( 'sta' , staLayout )
ruleXTas    = XTas   .mkRule( 'xtas', ruleSTA.file_target(0) )
ruleClean   = Clean  .mkRule( [ 'ao68000.00.density.histogram.dat'
                             , 'ao68000.00.density.histogram.plt'
                             , 'ao68000.katana.dat' ] ) 
