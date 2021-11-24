#!/bin/bash


 rm -f katana.dat
 for dct in lvl0 lvl1 lvl2 lvl3 dct_lvl0 dct_lvl1 dct_lvl2 dct_lvl3; do
     pushd $dct > /dev/null 2>&1
     echo "Running $dct ..."
     make clean  > /dev/null 2>&1
     make layout > make-layout.log 2>&1
     cat *.katana.dat >> ../katana.dat
     popd > /dev/null 2>&1
 done
