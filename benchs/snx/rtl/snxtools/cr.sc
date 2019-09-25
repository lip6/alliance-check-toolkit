a=0xff00;
*a=0x55aa;
a++;
*a=0x1234;
a++;
*a=0x5678;
a++;
*a=0x9abc;
for(i=0;i<4;i++) {
	z[i]=*a;
	a--;
}
halt;
