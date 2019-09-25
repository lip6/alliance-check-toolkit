interrupt foo() {
	a=0x55aa;
	return;
}
mem[0xff02] = ,foo;
mem[0xff00] = 1;
b=0;c=0;
halt;
