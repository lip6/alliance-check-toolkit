#!/bin/sh
export RDS_TECHNO_NAME=../etc/phen06.rds
export MBK_CATA_LIB=.:../cells/nsxlib:phlib
export RDS_OUT=gds
export RDS_IN=gds

for i in ../cells/nsxlib/*.ap phlib/*.ap
do
	echo `basename $i .ap` >&2
	druc `basename $i .ap`
done > druc.list
exit 0

