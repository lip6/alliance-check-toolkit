#!/bin/awk
BEGIN {FS=","}
/^S/ && /TRANS/ { printf "%s%s%s%s%s%s%s%s\n", $1",",$2",",$3",",$4",",$5",","t"$6",",$7",",$8}
!/^S/ || !/TRANS/	{print $0}


