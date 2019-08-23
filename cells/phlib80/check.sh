#!/bin/bash -eu
for i in *.vbe
do
  make ./check/`basename $i .vbe`.ok
done
exit 0
