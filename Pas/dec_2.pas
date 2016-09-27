const
        tfi     =       'dec.inp';
        tfo     =       'dec.out';
var
        fi,fo   :       text;
        ch      :       char;
        a,b,c,kt   :       array[1..5001] of longint;
        i,j,nho,tg,m,n  :       longint;
begin
    assign(fi,tfi);reset(fi);

    while not seekeoln(fi) do
     begin
      inc(n);
      read(fi,ch);
      kt[n]:=ord(ch)-ord('0');
     end;
    readln(fi);
    for i:=1 to n do
     a[i]:=kt[n-i+1];

    while not seekeoln(fi) do
     begin
      inc(m);
      read(fi,ch);
      kt[m]:=ord(ch)-ord('0');
     end;
    readln(fi);
    for i:=1 to m do
     b[i]:=kt[m-i+1];
    close(fi);

    if m>n then
     begin
         tg:=m;
         m:=n;
         n:=tg;
     end;
    for i:=1 to n do
     if a[i]>
     begin
       c[i]:=(a[i]-b[i]-nho)mod 10;
       nho:=(a[i]-b[i]-nho)div 10;
     end;
