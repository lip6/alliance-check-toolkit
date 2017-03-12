
set techno [lindex $argv 0]
set cell   [lindex $argv 1]

puts "Using technology:        <$techno>"
puts "Extracting boolean cell: <$cell.spi>"

#inf_SetFigureName   $cell
#inf_MarkSignal      *sff_m "FLIPFLOP+MASTER"
#inf_MarkSignal      *sff_s SLAVE

inf_SetFigureName   $cell

# This script has been customized for "xpu_core" only.
# Those configurations should eventually go into "xpu_core_yag.inf".

# Registers below are correctly matcheds.
#inf_DefineRename    n_pc_*_ins_sff_m n_pc_*
#inf_MarkSignal      n_pc_* "FLIPFLOP+MASTER"
#inf_DefineRename    n_op_*_ins_sff_m n_op_*
#inf_MarkSignal      n_op_* "FLIPFLOP+MASTER"
#inf_DefineRename    n_im_*_ins_sff_m n_im_*
#inf_MarkSignal      n_im_* "FLIPFLOP+MASTER"
#inf_DefineRename    n_acc_*_ins_sff_m n_acc_*
#inf_MarkSignal      n_acc_* "FLIPFLOP+MASTER"
#inf_DefineRename    n_count_*_ins_sff_m n_count_*
#inf_MarkSignal      n_count_* "FLIPFLOP+MASTER"
#inf_DefineRename    n_nextpc_*_ins_sff_m n_nextpc_*
#inf_MarkSignal      n_nextpc_* "FLIPFLOP+MASTER"

# Registers below are *not* correctly matcheds.
# They are not recognized *at all* as registers, but if we
# change the new name from "n_exe" to "n_exe_m" they are matched.
# My guess is that there is something specific to those nets.
# (and it is not the absence of wildcard that causes problem)
#inf_DefineRename    n_exe_ins_sff_m n_exe
#inf_MarkSignal      n_exe "FLIPFLOP+MASTER"
#
#inf_DefineRename    n_imm_ins_sff_m n_imm
#inf_MarkSignal      n_imm "FLIPFLOP+MASTER"
#
#inf_DefineRename    n_ift_ins_sff_m n_ift
#inf_MarkSignal      n_ift "FLIPFLOP+MASTER"

#inf_MarkSignal      *ins_sff_m "FLIPFLOP+MASTER"
#inf_MarkSignal      *ins_sff_s SLAVE

avt_config   simToolModel  hspice
avt_LoadFile $techno       spice
avt_LoadFile $cell.spi     spice
avt_LoadFile $cell.inf     inf
avt_config   avtVddName    vdd
avt_config   avtVssName    vss

yagle $cell

