#!/bin/sh

 benchs=""
 benchs="${benchs} adder"
 benchs="${benchs} AM2901/standart_cells"
 benchs="${benchs} AM2901/datapath"
 benchs="${benchs} snx"

 echo "Calling make with rules: $*"

 for bench in ${benchs}; do
   echo "============================================================================="
   echo "Running bench <${bench}>"
   echo "============================================================================="

   pushd ${bench}
   make $*
   if [ $? -ne 0 ]; then
     echo ""
     echo ""
     echo "[ERROR] go.sh: bench <${bench}> has failed."
     exit 1
   fi
   popd
 done
 exit 0
