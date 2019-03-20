#!/bin/sh

 generators=""
 generators="${generators} block_rf2"
#generators="${generators} block_rf2d"
 generators="${generators} block_rf2r0"
#generators="${generators} block_rf2dr0"

 echo "Calling generator make with rules: $*"

 for generator in ${generators}; do
   echo "============================================================================="
   echo "Checking generator <${generator}>"
   echo "============================================================================="

   make -f ./Makefile.${generator} $*
   if [ $? -ne 0 ]; then
     echo ""
     echo ""
     echo "[ERROR] makeAll.sh: generator <${generator}> has failed."
     exit 1
   fi
 done
 exit 0
