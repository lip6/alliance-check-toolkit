#!/bin/bash


 logFile="$1"

sed -E -e 's,.*/coriolis-2.x/,,' \
       -e '/Cfg.so loaded/d'     \
       -e '/[KMG]b$/d'           \
       -e '/bytes$/d'            \
       -e '/[[:digit:]]s$/d'     \
       -e 's/([[:digit:]]+ sec)/(X sec)/' \
       -e 's/0x[[:xdigit:]]{5,}\>/0xXXXXXXXX/g' \
       -e '/^(\.)|(--) +fifo32$/d'        \
       -e '/^(\.)|(--) +fifo32_u01$/d'    \
       -e '/^(\.)|(--) +fifo72$/d'        \
       -e '/^(\.)|(--) +fifo129$/d'       \
       -e '/^(\.)|(--) +shifter$/d'       \
       -e '/^(\.)|(--) +decod_model$/d'   \
       -e '/^(\.)|(--) +arm_core$/d'      \
       -e '/^(\.)|(--) +exec$/d'          \
       -e '/^(\.)|(--) +ifetch_model$/d'  \
       -e '/^(\.)|(--) +alu$/d'           \
       -e '/^(\.)|(--) +mem$/d'           \
       -e '/^(\.)|(--) +reg$/d'           \
       -e '/^(\.)|(--) +exec_model$/d'    \
       -e '/^(\.)|(--) +ifetch$/d'        \
       -e '/^(\.)|(--) +decod$/d'         \
       -e '/^(\.)|(--) +muxs$/d'          \
       -e '/^(\.)|(--) +ram$/d'           \
       -e '/^(\.)|(--) +accu$/d'          \
       -e '/^(\.)|(--) +muxe$/d'          \
       -e '/^(\.)|(--) +coeur$/d'         \
       -e '/^End of script/d'    \
       -e '/^Time spent/d'       \
       -e 's/yosys-abc-[[:alnum:]]+/yosys-abc-XXXX/'  \
       -e 's/^ABC: Memory = .*/ABC: Memory = DETER/'  \
       -e 's/Time = .*/Time = DETER/' \
       "${logFile}" > "${logFile}.clean" 
