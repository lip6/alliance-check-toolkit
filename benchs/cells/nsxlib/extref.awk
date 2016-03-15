BEGIN {FS=" ||,"; ADDDIF=100; DIFWID=20; ADDTIE=-120; ADDALU1=100; ADDTRAN=300; ADDALU2=-150; ADDWELL=600;}
/^R / {printf "%s %ld,%ld,%s,%s\n", $1,$2*2,$3*2,$4,$5;}
