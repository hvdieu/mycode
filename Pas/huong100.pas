var
        a,sum,s : array[1..5000,1..5000] of longint;
        i,j,k,n,m,max : longint;
BEGIN
    write('nhap n=');readln(n);
    write('nhap k=');readln(k);
    for i:=1 to n do
      for j:=1 to n do
        begin
           write('a[',i,',',j,']=');readln(a[i,j]);
        end;
    for i:=2 to n do
     for j:=2 to n do
      sum[i,j]:=a[i-1,j]+a[i,j-1]+a[i-1,j-1]+a[i,j];
    for i:=k to n do
      for j:=k to n do
        s[i,j]:=sum[i,j]-sum[i-k,j]-sum[i,j-k]+sum[i-k,j-k];
    max:=s[k,k];
    for i:=k to n do
     for j:=k+1 to n do
      if s[i,j]>max then max:=s[i,j];
    write('s=',max);
END.