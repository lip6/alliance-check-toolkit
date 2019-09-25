void swap(ain, bin) {
 int temp;
 temp=z[ain];
 z[ain]=z[bin];
 z[bin]=temp;
 return;
}

void qsort(left, right) {
 int ileft,jright,pivot;
 ileft=left;
 jright=right;
 pivot=z[(left+right)>>1];
 while(1) {
   while(z[ileft]<pivot) ileft++;
   while(pivot < z[jright]) jright--;
   if(ileft>=jright) break;
   swap(ileft,jright);
   ileft++;
   jright--;
 }
 if(left<ileft-1) qsort(left,ileft-1);
 if(jright+1<right) qsort(jright+1,right);
 return;
}


for(i=0;i<20;i++) z[i]=20-i;
qsort(0,19);
halt;

