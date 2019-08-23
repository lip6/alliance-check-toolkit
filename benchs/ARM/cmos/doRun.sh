#!/bin/bash

 make clean > /dev/null

 rewritens="ifetch_model exec_model shifter alu mem"
 for file in $rewritens; do
   cp non_generated/${file}.vst runs/${file}-ref.vst
 done
 cp non_generated/*.vst .

    maxRuns=20
        run=0
  successes=0
   failures=0
 
 while [ $run -lt $maxRuns ]; do
   echo -n "Run $run ..."
   runSuccess=1
   start=`date +%s`

   make clean > /dev/null 
   make lvx   > runs/make-lvx-run${run}.log 2>&1 
   if [ $? -ne 0 ]; then
     runSuccess=0
     echo -n " P&R"
    #break
   fi
   end=`date +%s`
   runtime=$((end-start))

   for file in $rewritens; do
     cp ${file}.vst runs/${file}-run${run}.vst
   done

   pushd runs > /dev/null
   for file in $rewritens; do
     lvx vst vst ${file}-ref ${file}-run${run} > /dev/null 2>&1
     if [ $? -ne 0 ]; then
       runSuccess=0
       echo -n " VST driver on \"$file\""
      #break
     fi

   done
   popd > /dev/null

  #gvimdiff runs/make-lvx-run1.log runs/make-lvx-run2.log &

   if [ $runSuccess -eq 1 ]; then
     echo " Success (${runtime}s)."
     successes=`expr $successes + 1`
   else
     echo " Failed (${runtime}s)"
     failures=`expr $failures + 1`
   fi
   run=`expr $run + 1`
 done

 percent=`expr \( $successes \* 100 \) / $run`
 echo "$successes succces, $failures failures (${percent}%)."
