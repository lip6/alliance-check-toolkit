#!/bin/bash


   ioLib="../../../cells/niolib"
 ioCells="GPIO IOVDD IOVSS VDD VSS"

 for cell in ${ioCells}; do
    echo "Processing \"${cell}dup.ap -> \"${ioLib}/${cell}.ap\".\""
    sed -i -e "s,${cell}dup,${cell},g" ${cell}dup.ap
    mv ${cell}dup.ap ${ioLib}/${cell}.ap
 done
