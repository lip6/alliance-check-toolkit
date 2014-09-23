BEGIN {FS=" ||,"; ADDDIF=100; DIFWID=20; ADDTIE=-120; ADDALU1=100; ADDTRAN=300; ADDALU2=-150; ADDWELL=600;}
/^H / {print $0}
/^I / {printf "%s %ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2,$4,$5,$6;}
/^C / {printf "%s %ld,%ld,%ld,%s,%s,%s,%s\n", $1,$2*2,$3*2,$4*1.5,$5,$6,$7,$8;}
/^A / {printf "%s %ld,%ld,%ld,%ld\n", $1,$2,$3,$4*2,$5*2;}
/^S / { if(match($0,"UP,[NP]TRANS")) 
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDTRAN,$4*2,$5*2-ADDTRAN,$6*2,$7,$8,$9;
	else if(match($0,"DOWN,[NP]TRANS")) 
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDTRAN,$4*2,$5*2-ADDTRAN,$6*2,$7,$8,$9;
	else if(match($0, "RIGHT,[NP]TRANS"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDTRAN,$3*2,$4*2-ADDTRAN,$5*2,$6*2,$7,$8,$9;
	else if(match($0, "LEFT,[NP]TRANS"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDTRAN,$3*2,$4*2-ADDTRAN,$5*2,$6*2,$7,$8,$9;
	else if(match($0, "RIGHT,[NP]DIF"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDDIF,$3*2,$4*2-ADDDIF,$5*2,$6*2+DIFWID,$7,$8,$9;
	else if(match($0, "LEFT,[NP]DIF"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDDIF,$3*2,$4*2-ADDDIF,$5*2,$6*2+DIFWID,$7,$8,$9;
	else if(match($0, "UP,[NP]DIF"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDDIF,$4*2,$5*2-ADDDIF,$6*2+DIFWID,$7,$8,$9;
	else if(match($0, "DOWN,[NP]DIF"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDDIF,$4*2,$5*2-ADDDIF,$6*2+DIFWID,$7,$8,$9;
	else if(match($0, "RIGHT,[NP]TIE"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDTIE,$3*2,$4*2-ADDTIE,$5*2,$6*2,$7,$8,$9;
	else if(match($0, "LEFT,[NP]TIE"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDTIE,$3*2,$4*2-ADDTIE,$5*2,$6*2,$7,$8,$9;
	else if(match($0, "UP,[NP]TIE"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDTIE,$4*2,$5*2-ADDTIE,$6*2,$7,$8,$9;
	else if(match($0, "DOWN,[NP]TIE"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDTIE,$4*2,$5*2-ADDTIE,$6*2,$7,$8,$9;
	else if(match($0, "RIGHT,ALU1"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDALU1,$3*2,$4*2-ADDALU1,$5*2,$6*2+(($6<150)?100:0),$7,$8,$9;
	else if(match($0, "LEFT,ALU1"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDALU1,$3*2,$4*2-ADDALU1,$5*2,$6*2+(($6<150)?100:0),$7,$8,$9;
	else if(match($0, "UP,ALU1"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDALU1,$4*2,$5*2-ADDALU1,$6*2+(($6<150)?100:0),$7,$8,$9;
	else if(match($0, "DOWN,ALU1"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDALU1,$4*2,$5*2-ADDALU1,$6*2+(($6<150)?100:0),$7,$8,$9;
	else if(match($0, "RIGHT,ALU[23]")) {
		if($6==200) 
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDALU2,$3*2,$4*2-ADDALU2,$5*2,$6*2+200,$7,$8,$9;
		else
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDALU2,$3*2,$4*2-ADDALU2,$5*2,$6*2,$7,$8,$9;
	}
	else if(match($0, "LEFT,ALU[23]")) {
		if($6==200) 
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDALU2,$3*2,$4*2-ADDALU2,$5*2,$6*2+200,$7,$8,$9;
		else
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2+ADDALU2,$3*2,$4*2-ADDALU2,$5*2,$6*2,$7,$8,$9;
	}
	else if(match($0, "UP,ALU[23]")) {
		if($6==200) 
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDALU2,$4*2,$5*2-ADDALU2,$6*2+200,$7,$8,$9;
		else
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDALU2,$4*2,$5*2-ADDALU2,$6*2,$7,$8,$9;
	}
	else if(match($0, "DOWN,ALU[23]")) {
		if($6==200) 
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDALU2,$4*2,$5*2-ADDALU2,$6*2+200,$7,$8,$9;
		else
		printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2+ADDALU2,$4*2,$5*2-ADDALU2,$6*2,$7,$8,$9;
	}
	else if(match($0, "UP,[NP]WELL"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2-ADDWELL,$4*2,$5*2+ADDWELL,$6*2+ADDWELL*2,$7,$8,$9;
	else if(match($0, "DOWN,[NP]WELL"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2-ADDWELL,$4*2,$5*2+ADDWELL,$6*2+ADDWELL*2,$7,$8,$9;
	else if(match($0, "LEFT,[NP]WELL"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2-ADDWELL,$3*2,$4*2+ADDWELL,$5*2,$6*2+ADDWELL*2,$7,$8,$9;
	else if(match($0, "RIGHT,[NP]WELL"))
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2-ADDWELL,$3*2,$4*2+ADDWELL,$5*2,$6*2+ADDWELL*2,$7,$8,$9;
	else
	printf "%s %ld,%ld,%ld,%ld,%ld,%s,%s,%s\n", $1,$2*2,$3*2,$4*2,$5*2,$6*2,$7,$8,$9;
}
/^V / {if(NF<5) print $0; else printf "%s %ld,%ld,%s,%s\n", $1,$2*2,$3*2,$4,$5;}
/EOF/ {print $0}
