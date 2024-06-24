#!/bin/sh
for i in *.ap
do
  s2r `basename $i .ap`
done

