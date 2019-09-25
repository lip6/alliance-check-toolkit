n=20;

for(i=0; i<n; i++) z[i]=n-i;

for(i=0; i<n-1; i++)
  for(j=n-1; j>i; j--)
    if(z[j]<z[j-1]) {
        w=z[j];
        z[j]=z[j-1];
        z[j-1]=w;
     }

halt;
