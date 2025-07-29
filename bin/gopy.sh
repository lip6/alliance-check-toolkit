#!/bin/bash

 getString ()
 {
   string=`echo $1 | cut -d '=' -f 2-` 
   echo $string
 }

 getRuntime ()
 {
   startTime="$1"
   mins=$(( (SECONDS - startTime)/60 ))
   secs=$(( (SECONDS - startTime)%60 ))
   printf "%u:%02u" $mins $secs
 }

 runSetId="not_set"
 onGithub="false"
 while [ $# -gt 0 ]; do
   case $1 in
     --github-runner) echo "Github/runner mode..";
                      onGithub="true";;
     --run-set=*)     runSetId=`getString $1`;;
   esac
   shift
 done

 declare -A benchRules
 benchRules["adder/cmos"]="druc lvx"
 benchRules["adder/tsmc_c180"]="gds"
 benchRules["adder/freepdk45_c4m"]="gds"
 benchRules["AM2901/standart_cells/cmos"]="druc lvx"
 benchRules["AM2901/datapath"]="druc lvx"
 benchRules["6502/cmos"]="druc lvx"
 benchRules["arlet6502/original/cmos"]="druc lvx"
 benchRules["arlet6502/original/cmos350"]="lvx"
 benchRules["arlet6502/original/tsmc_c018"]="gds"
 benchRules["arlet6502/original/freepdk45_c4m"]="gds"
 benchRules["arlet6502/original/sky130_c4m"]="gds"
 benchRules["arlet6502/original/ihpsg13s2_c4m"]="gds"
 benchRules["arlet6502/original/gf180mcu_c4m"]="gds"
 benchRules["arlet6502/original/gf180mcu_gf"]="gds"
 benchRules["MIPS/microprogrammed"]="druc lvx"
 benchRules["MIPS/pipeline"]="druc lvx"
 benchRules["snx/cmos"]="druc lvx"
 benchRules["ao68000/tsmc_c018"]="gds"
 benchRules["ao68000/freepdk45_c4m"]="gds"
 benchRules["ao68000/sky130_c4m"]="gds"
 benchRules["ao68000/ihpsg13s2_c4m"]="gds"
 benchRules["ao68000/gf180mcu_gf"]="gds"
 benchRules["RISC-V/Vex/cmos"]="druc lvx"
 benchRules["RISC-V/picorv32/sky13_c4m"]="gds"
 benchRules["RISC-V/picorv32/ihpsg13g2_c4m"]="gds"
 benchRules["RISC-V/picorv32/gf180mcu_gf"]="gds"
 benchRules["ARM/cmos"]="druc lvx"
 if [ "${onGithub}" = "true" ]; then
   benchRules["RingOscillator"]="druc lvx"
 else
   benchRules["RingOscillator"]="druc lvx asimut"
 fi
 benchRules["nmigen/ALU16"]="lvx druc gds"
 benchRules["RISC-V/Minerva/sky130_c4m"]="gds"
 benchRules["DCT/lvl0"]="layout"

 benchsSet1=""
 benchsSet1="${benchsSet1} adder/cmos"
 benchsSet1="${benchsSet1} AM2901/standart_cells/cmos"
#benchsSet1="${benchsSet1} AM2901/datapath/cmos"
 benchsSet1="${benchsSet1} 6502/cmos"
 benchsSet1="${benchsSet1} arlet6502/original/cmos"
#benchsSet1="${benchsSet1} arlet6502/original/cmos350"
 benchsSet2="${benchsSet2} MIPS/microprogrammed"
 benchsSet2="${benchsSet2} MIPS/pipeline"
#benchsSet1="${benchsSet1} snx/cmos"
 benchsSet2="${benchsSet2} RISC-V/Vex/cmos"
 benchsSet3="${benchsSet3} ARM/cmos"
 benchsSet1="${benchsSet1} RingOscillator"
#benchsSet1="${benchsSet1} nmigen/ALU16"
 benchsSet1="${benchsSet1} DCT/lvl0"

 if [ -e "../pdkmaster/C4M.Sky130" ]; then
   benchsSet1="${benchsSet1} arlet6502/original/sky130_c4m"
   benchsSet3="${benchsSet3} RISC-V/picorv32/sky130_c4m"
   benchsSet2="${benchsSet2} ao68000/sky130_c4m"
  #benchsSet4="${benchsSet4} RISC-V/Minerva/sky130_c4m"
 fi
 if [ -e "../../coriolis-pdk-gf180mcu" ]; then
   benchsSet1="${benchsSet1} arlet6502/original/gf180mcu_gf"
   benchsSet1="${benchsSet1} RISC-V/picorv32/gf180mcu_gf"
   benchsSet4="${benchsSet4} ao68000/gf180mcu_gf"
 fi
 if [ -e "../../coriolis-pdk-gf180mcu-c4m" ]; then
   benchsSet1="${benchsSet1} arlet6502/original/gf180mcu_c4m"
 fi
 if [ -e "../../coriolis-pdk-ihpsg13g2-c4m" ]; then
   benchsSet1="${benchsSet1} arlet6502/original/ihpsg13s2_c4m"
   benchsSet1="${benchsSet1} RISC-V/picorv32/ihpsg13g2_c4m"
   benchsSet4="${benchsSet4} ao68000/ihpsg13s2_c4m"
 fi
 if [ -e "/dsk/l1/jpc/crypted/soc/techno/etc/coriolis2/NDA/node180/tsmc_c018" ]; then
   benchsSet1="${benchsSet1} adder/tsmc_c180"
   benchsSet1="${benchsSet1} arlet6502/original/tsmc_c018"
   benchsSet3="${benchsSet3} ao68000/tsmc_c018"
 fi
#if [ -e "../../libre-soc/c4m-pdk-freepdk45" ]; then
#  benchsSet1="${benchsSet1} adder/freepdk45_c4m"
#  benchsSet1="${benchsSet1} arlet6502/original/freepdk45_c4m"
#  benchsSet5="${benchsSet5} ao68000/freepdk45_c4m"
#fi

 crlenv="`pwd`/../bin/crlenv.py"
 if [ ! -x "${crlenv}" ]; then
   echo "[ERROR] gopy.sh: Unable to find crlenv.py script."
   echo "        (${crlenv})"
   exit 1
 fi
#mode="stopOnFailure"
 mode="ignoreFailure"
# hline="+---+----+--------------------------------+------------+----------+-----------+"
#header="|Set| No |             bench              |    Rule    |  Runtime |  Status   |"
  hline="=====  ==  ==================================  ================  ==========  ==========="
 header="Set    No  Bench                               Rule                 Runtime  Status     "

 runSet () {
   setId="$1"
   benchCount=1

   benchLog="`pwd`/runset-${setId}.log"
   failedTag="`pwd`/runset-${setId}.failed"
   rm -f "${benchLog}" "${failedTag}"
   benchsSetName="benchsSet${setId}"
   for bench in ${!benchsSetName}; do
     rules="${benchRules[$bench]}"
       
     echo -e "\n\n\n\n" >> ${benchLog}
     echo "=============================================================================" >> ${benchLog}
     echo "Running bench <${bench}> with rules \"${rules}\""                              >> ${benchLog}
     echo "=============================================================================" >> ${benchLog}

    #statusLine="| %u | %2u | %-30s | %-10s | %10s | %-7s |"
     statusLine="%s  %2u  %-34s  %-16s  %10s  %-7s "
  
     if [ ! -d "${bench}" ]; then
       echo ""
       echo "[WARNING] No bench directory \"${bench}\", skipped."
       continue
     fi
  
     case $setId in
       1) setIdStr="1    ";;
       2) setIdStr=" 2   ";;
       3) setIdStr="  3  ";;
       4) setIdStr="   4 ";;
       5) setIdStr="    5";;
       *) setIdStr="    X";;
     esac
     success="true"
     pushd ${bench} > /dev/null
     startTime="$SECONDS"
     ${crlenv} -- doit clean_flow --extras >> ${benchLog} 2>&1
     for rule in ${rules}; do
       ${crlenv} -- doit ${rule} >> ${benchLog} 2>&1
       if [ $? -ne 0 ]; then
         success="false"
         printf "${statusLine}\n" "$setIdStr" $benchCount "<${bench}>" "${rule}" "`getRuntime $startTime`" "FAILED"
         touch ${failedTag}
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
     if [ "${success}" = "true" ]; then
       printf "${statusLine}\n" "$setIdStr"  \
                                $benchCount  \
                                "<${bench}>" \
				"`echo \"${rules}\" | sed 's/ /,/g'`" \
				"`getRuntime $startTime`" \
				"success"
     fi
     popd > /dev/null
     benchCount=`expr ${benchCount} + 1`
   done
  #echo "${hline}"
  #echo "|       | Benchs set ${setId} completed         |                                   |"
  #echo "${hline}"
 }


 timedRunSet () {
   startTime="$SECONDS"
   setId="$1"
   rvalue=0
   ../bin/gopy.sh --run-set=${setId}
   if [ $? -ne 0 ]; then rvalue=1; fi
   printf "           **Benchs set %u completed** %37s\n" "${setId}" "`getRuntime $startTime`"
   exit $rvalue
 }


 if [ "${runSetId}" = "not_set" ]; then
   echo ""
   echo "${hline}"
   echo "${header}"
   echo "${hline}"
   timedRunSet 1 &
   timedRunSet 2 &
   timedRunSet 3 &
   timedRunSet 4 &
   timedRunSet 5 &
   wait
   echo "${hline}"
   echo ""
   if [ -e "`pwd`/runset-1.failed" ]; then exit 1; fi
   if [ -e "`pwd`/runset-2.failed" ]; then exit 1; fi
   if [ -e "`pwd`/runset-3.failed" ]; then exit 1; fi
   if [ -e "`pwd`/runset-4.failed" ]; then exit 1; fi
   if [ -e "`pwd`/runset-5.failed" ]; then exit 1; fi
 else
   runSet ${runSetId}
 fi
 
 exit 0
