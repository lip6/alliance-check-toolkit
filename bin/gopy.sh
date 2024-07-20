#!/bin/bash

 getString ()
 {
   string=`echo $1 | cut -d '=' -f 2-` 
   echo $string
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
 benchRules["adder/cmos"]="lvx"
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
 benchRules["arlet6502/gf180mcu_c4m"]="gds"
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
 benchsSet1="${benchsSet1} adder/cmos45"
 benchsSet1="${benchsSet1} AM2901/standart_cells/cmos"
#benchsSet1="${benchsSet1} AM2901/datapath/cmos"
 benchsSet1="${benchsSet1} 6502/cmos"
 benchsSet1="${benchsSet1} 6502/cmos45"
 benchsSet1="${benchsSet1} arlet6502/cmos"
#benchsSet1="${benchsSet1} arlet6502/cmos350"
 benchsSet2="${benchsSet2} MIPS/microprogrammed"
 benchsSet2="${benchsSet2} MIPS/pipeline"
#benchsSet1="${benchsSet1} snx/cmos"
 benchsSet1="${benchsSet1} snx/cmos45"
 benchsSet2="${benchsSet2} RISC-V/Vex/cmos"
#benchsSet1="${benchsSet1} RISC-V/Vex/cmos45"
 benchsSet3="${benchsSet3} ARM/cmos"
 benchsSet1="${benchsSet1} RingOscillator"
#benchsSet1="${benchsSet1} nmigen/ALU16"
 benchsSet1="${benchsSet1} DCT/lvl0"

 if [ -e "../../gf180mcu-pdk" ]; then
   benchsSet1="${benchsSet1} arlet6502/gf180mcu_c4m"
 fi
 if [ -e "../pdkmaster/C4M.Sky130" ]; then
   benchsSet1="${benchsSet1} arlet6502/sky130_c4m"
   benchsSet1="${benchsSet1} ao68000/sky130_c4m"
   benchsSet4="${benchsSet4} RISC-V/Minerva/sky130_c4m"
 fi
 if [ -e "/dsk/l1/jpc/crypted/soc/techno/etc/coriolis2/NDA/node180/tsmc_c018" ]; then
   benchsSet1="${benchsSet1} adder/tsmc_c180"
   benchsSet1="${benchsSet1} arlet6502/tsmc_c018"
   benchsSet3="${benchsSet3} ao68000/tsmc_c018"
 fi
 if [ -e "../../libre-soc/c4m-pdk-freepdk45" ]; then
   benchsSet1="${benchsSet1} adder/freepdk45_c4m"
   benchsSet1="${benchsSet1} arlet6502/freepdk45_c4m"
   benchsSet5="${benchsSet5} ao68000/freepdk45_c4m"
 fi

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
  hline="===  ==  ==============================  ================  ==========  ==========="
 header="Set  No  Bench                           Rule                 Runtime  Status     "

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
     statusLine="%3u  %2u  %-30s  %-16s  %10s  %-7s "
  
     if [ ! -d "${bench}" ]; then
       echo ""
       echo "[WARNING] No bench directory \"${bench}\", skipped."
       continue
     fi
  
     success="true"
     pushd ${bench} > /dev/null
     ${crlenv} -- doit clean_flow --extras >> ${benchLog} 2>&1
     for rule in ${rules}; do
       /usr/bin/time -f '%E' -o time.txt ${crlenv} -- doit ${rule} >> ${benchLog} 2>&1
       if [ $? -ne 0 ]; then
         success="false"
         printf "${statusLine}\n" $setId $benchCount "<${bench}>" "${rule}" "`tail -n 1 time.txt`" "FAILED"
         touch ${failedTag}
	 rm -f time.txt
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
       printf "${statusLine}\n" $setId       \
                                $benchCount  \
                                "<${bench}>" \
				"`echo \"${rules}\" | sed 's/ /,/g'`" \
				"`tail -n 1 time.txt`" \
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
   setId="$1"
   rvalue=0
   timeSet="time-set-${setId}.txt"
   /usr/bin/time -f '%E' -o ${timeSet} ../bin/gopy.sh --run-set=${setId}
   if [ $? -ne 0 ]; then rvalue=1; fi
   printf "         **Benchs set %u completed** %33s\n" "${setId}" "`tail -n 1 ${timeSet}`"
   rm -f ${timeSet}
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
