#!/bin/bash

 declare -A benchRules
 benchRules["adder/cmos"]="layout"
 benchRules["adder/cmos45"]="layout"
 benchRules["adder/tsmc_c180"]="gds"
 benchRules["adder/freepdk45_c4m"]="gds"
 benchRules["AM2901/standart_cells/cmos"]="layout"
 benchRules["AM2901/datapath/cmos"]="layout"
 benchRules["6502/cmos"]="layout"
 benchRules["6502/cmos45"]="layout"
 benchRules["arlet6502/cmos350"]="layout"
 benchRules["arlet6502/tsmc_c018"]="gds"
 benchRules["arlet6502/freepdk45_c4m"]="gds"
 benchRules["arlet6502/sky130_c4m"]="gds"
 benchRules["MIPS/microprogrammed"]="layout"
 benchRules["MIPS/pipeline"]="layout"
 benchRules["snx/cmos"]="layout"
 benchRules["snx/cmos45"]="layout"
 benchRules["ao68000/tsmc_c018"]="gds"
 benchRules["ao68000/freepdk45_c4m"]="gds"
 benchRules["ao68000/sky130_c4m"]="gds"
 benchRules["RISC-V/Vex/cmos"]="layout"
 benchRules["RISC-V/Vex/cmos45"]="layout"
 benchRules["ARM/cmos"]="layout"
 benchRules["RISC-V/Minerva/sky130_c4m"]="gds"

 benchRules["DCT/lvl3"]="layout"
 benchRules["DCT/lvl2"]="layout"
 benchRules["DCT/lvl1"]="layout"
 benchRules["DCT/lvl0"]="layout"
 benchRules["DCT/dct_lvl3"]="layout"
 benchRules["DCT/dct_lvl2"]="layout"
 benchRules["DCT/dct_lvl1"]="layout"
 benchRules["DCT/dct_lvl0"]="layout"
 benchRules["eFPGA/04x04"]="layout"
 benchRules["eFPGA/04x08"]="layout"
 benchRules["eFPGA/08x08"]="layout"
 benchRules["eFPGA/08x16"]="layout"
 benchRules["eFPGA/16x16"]="layout"
 benchRules["ieee_division"]="layout"
 benchRules["vld"]="layout"

 benchs=""
 benchs="${benchs} arlet6502/sky130_c4m"
 benchs="${benchs} DCT/lvl3"
 benchs="${benchs} DCT/lvl2"
 benchs="${benchs} DCT/lvl1"
 benchs="${benchs} DCT/lvl0"
 benchs="${benchs} eFPGA/04x04"
 benchs="${benchs} DCT/dct_lvl1"
 benchs="${benchs} DCT/dct_lvl0"
 benchs="${benchs} eFPGA/04x08"
 benchs="${benchs} DCT/dct_lvl3"
 benchs="${benchs} DCT/dct_lvl2"
 benchs="${benchs} ao68000/sky130_c4m"
 benchs="${benchs} ieee_division"
 benchs="${benchs} eFPGA/08x08"
 benchs="${benchs} vld"
 benchs="${benchs} eFPGA/08x16"
 benchs="${benchs} RISC-V/Minerva/sky130_c4m"
 benchs="${benchs} eFPGA/16x16"

#benchs="${benchs} adder/cmos"
#benchs="${benchs} adder/cmos45"
#benchs="${benchs} AM2901/standart_cells/cmos"
#benchs="${benchs} AM2901/datapath/cmos"
#benchs="${benchs} 6502/cmos"
#benchs="${benchs} 6502/cmos45"
#benchs="${benchs} arlet6502/cmos350"
#benchs="${benchs} MIPS/microprogrammed"
#benchs="${benchs} MIPS/pipeline"
#benchs="${benchs} snx/cmos"
#benchs="${benchs} snx/cmos45"
#benchs="${benchs} RISC-V/Vex/cmos"
#benchs="${benchs} RISC-V/Vex/cmos45"
#benchs="${benchs} ARM/cmos"
#
#if [ -e "/dsk/l1/jpc/crypted/soc/techno/etc/coriolis2/NDA/node180/tsmc_c018" ]; then
#  benchs="${benchs} adder/tsmc_c180"
#  benchs="${benchs} arlet6502/tsmc_c018"
#  benchs="${benchs} ao68000/tsmc_c018"
#fi
#if [ -e "/dsk/l1/jpc/coriolis-2.x/src/libre-soc/c4m-pdk-freepdk45" ]; then
#  benchs="${benchs} adder/freepdk45_c4m"
#  benchs="${benchs} arlet6502/freepdk45_c4m"
#  benchs="${benchs} ao68000/freepdk45_c4m"
#fi
#if [ -e "../pdkmaster/C4M.Sky130" ]; then
#  benchs="${benchs} arlet6502/sky130_c4m"
#  benchs="${benchs} ao68000/sky130_c4m"
#  benchs="${benchs} RISC-V/Minerva/sky130_c4m"
#fi

 statsTag="lepka/20220528"
 mode="stopOnFailure"
#mode="ignoreFailure"
 benchLog="`pwd`/make-stats.log"
 statsDir="`pwd`/statistics/${statsTag}"
 cumulativeStats="${statsDir}/katana.dat"
 rm -f "${benchLog}" "${cumulativeStats}"
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

   result="success."
   pushd ${bench} > /dev/null
   /bin/ls *.katana.dat > /dev/null 2>&1
   if [ $? -ne 0 ]; then
    #make clean >> ${benchLog} 2>&1
     for rule in ${rules}; do
       make ${rule} >> ${benchLog} 2>&1
       if [ $? -ne 0 ]; then
         result="\"${rule}\" failed."
         if [ "${mode}" = "stopOnFailure" ]; then
           echo ""
           echo ""
           echo "[ERROR] go.sh: bench <${bench}> has failed."
           exit 1
         fi
         break
       fi
     done
   else
     result="reuse previous run."
   fi
   cat *.katana.dat >> ${cumulativeStats}
  #make clean >> ${benchLog} 2>&1
   echo " ${result}"
   popd > /dev/null
 done

 pushd ${statsDir} > /dev/null
 ../../build.sh
 popd > /dev/null
 exit 0
