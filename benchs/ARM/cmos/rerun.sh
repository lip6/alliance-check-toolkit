#!/bin/bash

 rm *.ap *.vst *.spi
 cp uniquified/*.vst .
 rm arm_chip.vst arm_corona.vst corona* chip*
 ../../../bin/crlenv.py doit cgt > cgt.log 2>&1 &

