BEGIN {FS=" ||,"; ADDVSD=100; }
/^H / {print $0}
/^R / {printf "%s %ld,%ld,%s,%s\n", $1,$2,$3,$4,$5;}
/^I / {printf "%s %ld,%ld,%s,%s,%s\n", $1,$2,$3,$4,$5,$6;}
/^C / {printf "%s %ld,%ld,%ld,%s,%s,%s,%s\n", $1,$2,$3,$4,$5,$6,$7,$8;}
/^A / {printf "%s %ld,%ld,%ld,%ld\n", $1,$2,$3,$4,$5;}
/^S / { 
	if(match($0, "vss,RIGHT,CALU1"))
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2,$3+ADDVSD,$4,$5+ADDVSD,$6,$7,$8,$9;
	else if(match($0, "vdd,RIGHT,CALU1"))
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2,$3-ADDVSD,$4,$5-ADDVSD,$6,$7,$8,$9;
	else
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2,$3,$4,$5,$6,$7,$8,$9;
}
/^V / {if(NF<5) print $0; else printf "%s %ld,%ld,%s,%s\n", $1,$2,$3,$4,$5;}
/EOF/ {print $0}
