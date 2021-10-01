#!/bin/bash

 declare -A benchRules
 benchRules["adder/cmos"]="druc lvx"
 benchRules["adder/cmos45"]="lvx"
 benchRules["adder/tsmc_c180"]="gds"
 benchRules["adder/freepdk45_c4m"]="gds"
 benchRules["AM2901/standart_cells"]="druc lvx"
 benchRules["AM2901/datapath"]="druc lvx"
 benchRules["6502/cmos"]="druc lvx"
 benchRules["6502/cmos45"]="lvx"
 benchRules["arlet6502/cmos350"]="lvx"
 benchRules["arlet6502/tsmc_c018"]="gds"
 benchRules["arlet6502/freepdk45_c4m"]="gds"
 benchRules["MIPS/microprogrammed"]="druc lvx"
 benchRules["MIPS/pipeline"]="druc lvx"
 benchRules["snx/cmos"]="druc lvx"
 benchRules["snx/cmos45"]="layout"
 benchRules["ao68000/tsmc_c018"]="gds"
 benchRules["ao68000/freepdk45_c4m"]="gds"
 benchRules["VexRiscv/cmos"]="druc"
 benchRules["VexRiscv/cmos45"]="layout"
 benchRules["ARM/cmos"]="druc lvx"
 benchRules["RingOscillator"]="druc lvx"
 benchRules["nmigen/ALU16"]="lvx druc gds"

 benchs=""
 benchs="${benchs} adder/cmos"
 benchs="${benchs} adder/cmos45"
 benchs="${benchs} AM2901/standart_cells/cmos"
#benchs="${benchs} AM2901/datapath/cmos"
 benchs="${benchs} 6502/cmos"
 benchs="${benchs} 6502/cmos45"
#benchs="${benchs} arlet6502/cmos350"
 benchs="${benchs} MIPS/microprogrammed"
 benchs="${benchs} MIPS/pipeline"
 benchs="${benchs} snx/cmos"
 benchs="${benchs} snx/cmos45"
 benchs="${benchs} VexRiscv/cmos"
 benchs="${benchs} VexRiscv/cmos45"
#benchs="${benchs} ARM/cmos"
 benchs="${benchs} RingOscillator"
#benchs="${benchs} nmigen/ALU16"

 if [ -e "/dsk/l1/jpc/crypted/soc/techno/etc/coriolis2/NDA/node180/tsmc_c018" ]; then
   benchs="${benchs} adder/tsmc_c180"
   benchs="${benchs} arlet6502/tsmc_c018"
   benchs="${benchs} ao68000/tsmc_c018"
 fi
 if [ -e "/dsk/l1/jpc/coriolis-2.x/src/libre-soc/c4m-pdk-freepdk45" ]; then
   benchs="${benchs} adder/freepdk45_c4m"
   benchs="${benchs} arlet6502/freepdk45_c4m"
   benchs="${benchs} ao68000/freepdk45_c4m"
 fi

 benchLog="`pwd`/make-go.log"
 rm -f "${benchLog}"
 for bench in ${benchs}; do
   rules="${benchRules[$bench]}"
     
   echo -e "\n\n\n\n" >> ${benchLog}
   echo "=============================================================================" >> ${benchLog}
   echo "Running bench <${bench}> with rules \"${rules}\""                              >> ${benchLog}
   echo "=============================================================================" >> ${benchLog}
   echo -n "Running bench <${bench}> with rules \"${rules}\" ..."

   if [ ! -d "${bench}" ]; then
     echo ""
     echo "[WARNING] No bench directory \"${bench}\", skipped."
     continue
   fi

   pushd ${bench} > /dev/null
   for rule in ${rules}; do
     make clean   >> ${benchLog} 2>&1
     make ${rule} >> ${benchLog} 2>&1
     if [ $? -ne 0 ]; then
       echo ""
       echo ""
       echo "[ERROR] go.sh: bench <${bench}> has failed."
       exit 1
     fi
   done
   make clean >> ${benchLog} 2>&1
   echo " success."
   popd > /dev/null
 done
 exit 0
