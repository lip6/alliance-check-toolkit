#!/bin/bash

 declare -A benchRules
 benchRules["adder/cmos"]="druc lvx clean"
 benchRules["AM2901/standart_cells"]="druc lvx clean"
 benchRules["MIPS/microprogrammed"]="druc lvx clean"
 benchRules["MIPS/pipeline"]="druc lvx clean"
 benchRules["snx/cmos"]="druc lvx clean"
 benchRules["VexRiscv/cmos"]="druc     clean"
 benchRules["RingOscillator"]="druc lvx clean"

 benchs=""
 benchs="${benchs} adder/cmos"
 benchs="${benchs} AM2901/standart_cells"
 benchs="${benchs} MIPS/microprogrammed"
 benchs="${benchs} MIPS/pipeline"
 benchs="${benchs} snx/cmos"
 benchs="${benchs} VexRiscv/cmos"
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
