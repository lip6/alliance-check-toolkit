#!/bin/bash

 declare -A benchRules
 benchRules["adder/cmos"]="druc lvx clean"
 benchRules["AM2901/standart_cells"]="druc lvx clean"
 benchRules["6502/cmos"]="druc lvx clean"
 benchRules["6502/cmos45"]="lvx clean"
 benchRules["arlet6502/cmos350"]="lvx clean"
 benchRules["MIPS/microprogrammed"]="druc lvx clean"
 benchRules["MIPS/pipeline"]="druc lvx clean"
 benchRules["snx/cmos"]="lvx clean"
 benchRules["snx/cmos45"]="layout clean"
 benchRules["VexRiscv/cmos"]="druc clean"
 benchRules["VexRiscv/cmos45"]="layout clean"
 benchRules["ARM/cmos"]="druc lvx clean"
 benchRules["RingOscillator"]="druc lvx clean"

 benchs=""
 benchs="${benchs} adder/cmos"
 benchs="${benchs} AM2901/standart_cells/cmos"
 benchs="${benchs} 6502/cmos"
 benchs="${benchs} 6502/cmos45"
 benchs="${benchs} arlet6502/cmos350"
 benchs="${benchs} MIPS/microprogrammed"
 benchs="${benchs} MIPS/pipeline"
 benchs="${benchs} snx/cmos"
 benchs="${benchs} snx/cmos45"
 benchs="${benchs} VexRiscv/cmos"
 benchs="${benchs} VexRiscv/cmos45"
#benchs="${benchs} ARM/cmos"
 benchs="${benchs} RingOscillator"

 for bench in ${benchs}; do
   rules="${benchRules[$bench]}"
     
   echo "============================================================================="
   echo "Running bench <${bench}> with rules \"${rules}\""
   echo "============================================================================="

   if [ ! -d "${bench}" ]; then
     echo "[WARNING] No bench directory \"${bench}\", skipped."
     continue
   fi

   pushd ${bench}
   for rule in ${rules}; do
     make clean
     make ${rule}
     if [ $? -ne 0 ]; then
       echo ""
       echo ""
       echo "[ERROR] go.sh: bench <${bench}> has failed."
       exit 1
     fi
   done
   popd
 done
 exit 0
