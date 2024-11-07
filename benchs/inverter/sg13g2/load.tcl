avt_config tasGenerateConeFile yes
avt_config simVthHigh 0.8
avt_config simVthLow 0.2
avt_config simSlope 10e-12

avt_config simToolModel hspice
avt_config tasGenerateDetailTimingFile yes

avt_LoadFile ../openvaf/psp103_nqs.osdi osdi
#avt_LoadFile cornerMOShv.lib spice
#avt_LoadFile sg13g2_moslv_parm.lib spice
#avt_LoadFile sg13g2_moslv_stat.lib spice
#avt_LoadFile sg13g2_moslv_mod.lib spice

avt_LoadFile test.spice spice

set fig [hitas test]

set temp   [ttv_GetTimingFigureProperty $fig TEMP]
set supply [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]

set slope  [ttv_GetTimingFigureProperty $fig DEF_SLOPE]
set cload   [ttv_GetTimingFigureProperty $fig DEF_LOAD]
set date   [ttv_GetTimingFigureProperty $fig DATE]
