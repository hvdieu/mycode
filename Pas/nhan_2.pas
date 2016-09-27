const
  tfi = 'nhan.inp';
  tfo = 'nhan.out';
type
  arr = array[0..10000] of longint;
var
  a,b,c,kt: arr;
  i,na,nb,nc,nho,j,s: longint;
  ch: char;
  fi,fo: text;
begin
    assign(fi,tfi);
    reset(fi);
    na:=0;
    while not seekeoln(fi) do
      begin
          inc(na);
          read(fi,ch);
          kt[na]:= ord(ch) - ord('0');
      end;
    for i:=1 to na do  a[i]:= kt[na-i+1];
    for i:=na+1 to na+nb-1 do a[i]:=0;
    readln(fi);
    nb:=0;
    while not seekeoln(fi) do
      begin
          inc(nb);
          read(fi,ch);
          kt[nb]:= ord(ch) - ord('0');
      end;
    for i:=1 to nb do  b[i]:= kt[nb-i+1];
    for i:=nb+1 to na+nb-1 do b[i]:=0;
    close(fi);
    nc:= na+nb-1;
     nho:=0;
     for i:=1 to nc do
     begin
       begin
        for j:=1 to i+1 do
        s:= s+ a[j] * b[i+1-j];
       end;
           c[i]:= (s + nho) mod 10;
           nho:= (s+nho) div 10;
           s:=0;
     end;
      while nho>0 do
        begin
            inc(nc);
            c[nc]:=nho mod 10;
            nho:= nho div 10;
        end;
    assign(fo,tfo);
    rewrite(fo);
    while (c[nc] = 0) and (nc <> 1)  do dec(nc);
    for i:=nc downto 1 do write(fo,c[i]);
    close(fo);
end.
