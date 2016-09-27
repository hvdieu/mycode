const
  tfi = 'invers.inp';
  tfo = 'invers.out';
type
  arr = array[1..5001] of longint;
var
  a,b,c,kt: arr;
  i,na,nb,nc,nho,j,n,k: longint;
  ch: char;
  fi,fo: text;
begin
    assign(fi,tfi);
    reset(fi);
    readln(fi,n);
     assign(fo,tfo);
    rewrite(fo);
   for k:=1 to n do
   begin
    na:=0;
    i:=1;
    while not seekeoln(fi) do
      begin
          inc(na);
          read(fi,ch);
          kt[na]:= ord(ch) - ord('0');
          b[i]:= kt[na];
          inc(i);
      end;
    for i:=1 to na do  a[i]:= kt[na-i+1];
   readln(fi);


    nho:=0;
    for i:=1 to na do
      begin
          c[i]:= (a[i] + b[i] + nho) mod 10;
          nho:= (a[i] + b[i] + nho) div 10;
      end;
    while nho > 0 do
      begin
          inc(na);
          c[na]:= nho mod 10;
          nho:= nho div 10;
      end;

    for i:=na downto 1 do
    write(fo,c[i]);
    writeln(fo);
    end;
    close(fi);



    close(fo);

end.