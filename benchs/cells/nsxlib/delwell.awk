BEGIN {FS=" ||,"; ADDDIF=100; DIFWID=20; ADDTIE=-120; ADDALU1=100; ADDTRAN=300; ADDALU2=-150; ADDWELL=600;}
/^H / {print $0}
/^R / {printf "%s %ld,%ld,%s,%s\n", $1,$2,$3,$4,$5;}
/^I / {printf "%s %ld,%ld,%s,%s,%s\n", $1,$2,$3,$4,$5,$6;}
/^C / {printf "%s %ld,%ld,%ld,%s,%s,%s,%s\n", $1,$2,$3,$4,$5,$6,$7,$8;}
/^A / {printf "%s %ld,%ld,%ld,%ld\n", $1,$2,$3,$4,$5;}
/^S / { 
	if(match($0, "UP,[NP]WELL"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2,$3+ADDWELL,$4,$5-ADDWELL,$6-ADDWELL*2,$7,$8,$9;
	else if(match($0, "DOWN,[NP]WELL"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2,$3+ADDWELL,$4,$5-ADDWELL,$6+ADDWELL*2,$7,$8,$9;
	else if(match($0, "LEFT,[NP]WELL"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2+ADDWELL,$3,$4-ADDWELL,$5,$6-ADDWELL*2,$7,$8,$9;
	else if(match($0, "RIGHT,[NP]WELL"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2+ADDWELL,$3,$4-ADDWELL,$5,$6-ADDWELL*2,$7,$8,$9;
	else
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2,$3,$4,$5,$6,$7,$8,$9;
}
/^V / {if(NF<5) print $0; else printf "%s %ld,%ld,%s,%s\n", $1,$2,$3,$4,$5;}
/EOF/ {print $0}
