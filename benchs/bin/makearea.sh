#!/bin/sh
for i in *.ap
do
  sh area.sh `basename $i .ap` > `basename $i .ap`.area
done
