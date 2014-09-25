#!/usr/bin/env python

import sys
from   helpers  import ErrorMessage
from   helpers  import WarningMessage
import Alliance
from   Alliance import Probe
from   Alliance import Source
from   Alliance import Rule
from   Alliance import Boom
from   Alliance import Boog
from   Alliance import Loon
from   Alliance import Genlib
from   Alliance import Genpat
from   Alliance import Asimut
from   Alliance import Ocp
from   Alliance import Nero
from   Alliance import Cougar
from   Alliance import Lvx
from   Alliance import Druc
from   Alliance import Tools

try:
  Alliance.commandFlags = Alliance.ShowCommand|Alliance.ShowDots

  showEnv_sh            = Source()
  pattern_c             = Source()
  amd2901_ctl_vbe       = Source()
  amd2901_ctl_lax       = Source()
  amd2901_dpt_c         = Source()
  amd2901_core_c        = Source()
  amd2901_chip_c        = Source()
  amd2901_core_place_ap = Source()
  amd2901_core_ioc      = Source()

  showenv_sh = Probe( showEnv_sh )
  showenv_sh.IN_LO = 'al'
    
  amd2901_ctl_boom_vbe = Boom( amd2901_ctl_vbe )
  amd2901_ctl_boom_vbe.flags = Boom.Verbose|Alliance.commandFlags
  
  amd2901_ctl_boog_vst = Boog( amd2901_ctl_boom_vbe )
  amd2901_ctl_boog_vst.optimMode = 2
  amd2901_ctl_boog_vst.laxFile   = amd2901_ctl_lax
  
  amd2901_ctl_vst = Loon( amd2901_ctl_boog_vst )
  amd2901_ctl_vst.optimMode = 2

  amd2901_dpt_vst = Genlib( amd2901_dpt_c )

  amd2901_core_vst = Genlib( amd2901_core_c )
  amd2901_core_vst.addDependency( amd2901_ctl_vbe )
  amd2901_core_vst.addDependency( amd2901_ctl_vst )
  amd2901_core_vst.addDependency( amd2901_dpt_vst )

  amd2901_chip_vst = Genlib( amd2901_chip_c )
  amd2901_chip_vst.addDependency( amd2901_core_vst )

  pattern_pat = Genpat( pattern_c )

  test_chip_pat = Asimut( amd2901_chip_vst, pattern_pat )
  test_chip_pat.flags = Asimut.ZeroDelay|Alliance.commandFlags

  amd2901_core_p_ap = Ocp( amd2901_core_vst )
  amd2901_core_p_ap.partial = amd2901_core_place_ap
  amd2901_core_p_ap.ioc     = amd2901_core_ioc

  amd2901_core_ap = Nero( amd2901_core_vst )
  amd2901_core_ap.placement = amd2901_core_p_ap
  amd2901_core_ap.flags     = Nero.Use2Layers|Alliance.commandFlags

  amd2901_core_al = Cougar( amd2901_core_ap )
  amd2901_core_al.flags = Cougar.CatalogFlatten|Alliance.commandFlags

  stamp_lvx_core = Lvx( amd2901_core_vst, amd2901_core_al )
  stamp_lvx_core.flags = Lvx.CatalogFlatten|Alliance.commandFlags

  stamp_druc_core = Druc( amd2901_core_ap )

  rule_core = Rule( stamp_lvx_core, stamp_druc_core )
  
  Tools.run( sys.argv[1:] )

except ErrorMessage, e:
  print e
  sys.exit( 1 )

sys.exit( 0 )
