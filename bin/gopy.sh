#!/bin/bash

 getString ()
 {
   string=`echo $1 | cut -d '=' -f 2-` 
   echo $string
 }

 onGithub="false"
 while [ $# -gt 0 ]; do
   case $1 in
     --github-runner) echo "Github/runner mode..";
                      onGithub="true";;
   esac
   shift
 done

 declare -A benchRules
 benchRules["adder/cmos"]="druc lvx"
 benchRules["adder/cmos45"]="lvx"
 benchRules["adder/tsmc_c180"]="gds"
 benchRules["adder/freepdk45_c4m"]="gds"
 benchRules["AM2901/standart_cells/cmos"]="druc lvx"
 benchRules["AM2901/datapath"]="druc lvx"
 benchRules["6502/cmos"]="druc lvx"
 benchRules["6502/cmos45"]="lvx"
 benchRules["arlet6502/cmos"]="druc lvx"
 benchRules["arlet6502/cmos350"]="lvx"
 benchRules["arlet6502/tsmc_c018"]="gds"
 benchRules["arlet6502/freepdk45_c4m"]="gds"
 benchRules["arlet6502/sky130_c4m"]="gds"
 benchRules["MIPS/microprogrammed"]="druc lvx"
 benchRules["MIPS/pipeline"]="druc lvx"
 benchRules["snx/cmos"]="druc lvx"
 benchRules["snx/cmos45"]="lvx"             # fail.
 benchRules["ao68000/tsmc_c018"]="gds"
 benchRules["ao68000/freepdk45_c4m"]="gds"
 benchRules["ao68000/sky130_c4m"]="gds"
 benchRules["RISC-V/Vex/cmos"]="druc lvx"
 benchRules["RISC-V/Vex/cmos45"]="lvx"
 benchRules["ARM/cmos"]="druc lvx"
 benchRules["RingOscillator"]="druc lvx asimut"
 benchRules["nmigen/ALU16"]="lvx druc gds"
 benchRules["RISC-V/Minerva/sky130_c4m"]="gds"
 benchRules["DCT/lvl0"]="layout"

 benchs=""
 benchs="${benchs} adder/cmos"
 benchs="${benchs} adder/cmos45"
 benchs="${benchs} AM2901/standart_cells/cmos"
#benchs="${benchs} AM2901/datapath/cmos"
 benchs="${benchs} 6502/cmos"
 benchs="${benchs} 6502/cmos45"
 benchs="${benchs} arlet6502/cmos"
#benchs="${benchs} arlet6502/cmos350"
 benchs="${benchs} MIPS/microprogrammed"
 benchs="${benchs} MIPS/pipeline"
 benchs="${benchs} snx/cmos"
 benchs="${benchs} snx/cmos45"
 benchs="${benchs} RISC-V/Vex/cmos"
#benchs="${benchs} RISC-V/Vex/cmos45"
 benchs="${benchs} ARM/cmos"
 benchs="${benchs} RingOscillator"
#benchs="${benchs} nmigen/ALU16"
 benchs="${benchs} DCT/lvl0"

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
 if [ -e "../pdkmaster/C4M.Sky130" ]; then
   benchs="${benchs} arlet6502/sky130_c4m"
   benchs="${benchs} ao68000/sky130_c4m"
   benchs="${benchs} RISC-V/Minerva/sky130_c4m"
 fi

 crlenv="`pwd`/../bin/crlenv.py"
 if [ ! -x "${crlenv}" ]; then
   echo "[ERROR] gopy.sh: Unable to find crlenv.py script."
   echo "        (${crlenv})"
   exit 1
 fi

 mode="stopOnFailure"
#mode="ignoreFailure"
 benchLog="`pwd`/doit-gopy.log"
 failedTag="`pwd`/doit-gopy.failed"
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

   result="success."
   pushd ${bench} > /dev/null
   ${crlenv} -- doit clean_flow --extras >> ${benchLog} 2>&1
   for rule in ${rules}; do
     ${crlenv} -- doit ${rule} >> ${benchLog} 2>&1
     if [ $? -ne 0 ]; then
       result="\"${rule}\" failed."
       if [ "${onGithub}" = "true" ]; then
         touch ${failedTag}
         exit 0	   
       fi
       if [ "${mode}" = "stopOnFailure" ]; then
         echo ""
         echo ""
         echo "[ERROR] gopy.sh: bench <${bench}> has failed."
         exit 1
       fi
       break
     fi
   done
   ${crlenv} -- doit clean_flow --extras >> ${benchLog} 2>&1
   echo " ${result}"
   popd > /dev/null
 done
 exit 0
