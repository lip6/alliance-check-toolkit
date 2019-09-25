int foo(arg) {
 if(arg<2) return arg;
 else return foo(arg-2)+foo(arg-1);
}

for(i=0;i<10;i++) z[i]=foo(i);
halt;

