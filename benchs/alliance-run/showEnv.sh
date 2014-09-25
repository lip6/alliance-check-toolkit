#!/bin/bash

 echo "  o  MBK Environment:"
 set | grep MBK | while read variable; do
   echo "     $variable"
 done
