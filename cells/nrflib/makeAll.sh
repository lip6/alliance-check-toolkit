#!/bin/sh

 generators=""
 generators="${generators} rf1"
#generators="${generators} rf1d"
 generators="${generators} rf1r0"
#generators="${generators} rf1dr0"
 generators="${generators} fifo"

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
