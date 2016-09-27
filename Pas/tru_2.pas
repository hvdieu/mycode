const
        tfi     =       'tru.inp';
        tfo     =       'tru.out';
var
        fi,fo   :       text;
        ch      :       char;
        a,b,c,kt   :       array[1..5001] of longint;
        i,j,nho,tg,m,n,dem  :       longint;
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
  {  for i:=n downto 1 do
     begin
      if a[i]<b[i] then
       begin
        for j:=1 to n do
         begin
          tg:=a[j];
          a[j]:=b[j];
          b[j]:=tg;
         end;
        inc(dem);
        break;
       end;
      if a[i]>b[i] then break;
     end;
    for i:=1 to n do
     if a[i]<b[i] then
     begin
       c[i]:=10+(a[i]-b[i]-nho)mod 10;
       nho:=1+(a[i]-b[i]-nho)div 10;
     end
     else
       begin }
       for i:=1 to n do
        if (a[i]-nho)>=b[i] then
         begin
          c[i]:=(a[i]-b[i]-nho)mod 10;
          nho:=0;
         end
        else
         begin
          c[i]:=(a[i]+10-b[i]-nho)mod 10 ;
          nho:=1;
         end;

     if dem>0 then
      begin
        while (c[n]=0) and (n>1) do
         begin
          dec(n);
         end;
       c[n]:=-1*c[n];
      end;
    assign(fo,tfo);rewrite(fo);
    while (c[n]=0) and (n>1) do
     dec(n);
    for j:=n downto 1 do
     write(fo,c[j]);
    close(fo);
end.
