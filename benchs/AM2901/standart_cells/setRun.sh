#!/bin/bash

 run="$1"

 if [ "${run}" = "" ]; then
   echo "Usage: ./setRun No"
   return 1
 fi

 rm -f *_cts* *.ap
 rewritens="alu muxs muxe"
 for file in $rewritens; do
   if [ ! -e "runs/${file}-run${run}.vst" ]; then
     echo "Bad run number or missing run \"${run}\"."
     break
   fi
   cp runs/${file}-run${run}.vst ${file}.vst
 done

