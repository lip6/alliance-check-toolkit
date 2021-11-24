#!/bin/bash


 for fpga in 04x04 04x08 08x08 08x16 16x16; do
     pushd $fpga > /dev/null 2>&1
     echo "Running $fpga ..."
     make layout > make-layout.log 2>&1
     popd > /dev/null 2>&1
 done
