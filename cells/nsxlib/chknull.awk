BEGIN {FS=" ||,"; WID=300; }
/^S / { 
	if(($2==$4) && ($3==$5))
		printf "%d: %s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", FNR, $1,$2,$3,$4,$5,$6,$7,$8,$9;
}
/EOF/ {print $0}
