#!/bin/sh

 benchs=""
 benchs="${benchs} adder"
 benchs="${benchs} AM2901/standart_cells"
 benchs="${benchs} AM2901/datapath"
 benchs="${benchs} snx_flat_clock"

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
   fi
   popd
 done
