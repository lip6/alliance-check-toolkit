#!/bin/sh
awk 'BEGIN {FS=","}\
   function ceil(valor)
   {
      return (valor == int(valor)) ? valor : int(valor)+1
   }
/^A/ {print ceil(($3/100)*($4/100)*0.09*0.09)}' $1.ap > $1.area

