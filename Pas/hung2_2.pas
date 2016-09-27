program bai2;
uses crt;
const
       tfi      =       'bonus.inp';
       tfo      =       'bonus.out';
var
        a,sum:       array[0..1001,0..1001] of longint;
        fi,fo :  text;
        n,sl,k,i,max,j,u,v,tg:longint;
BEGIN
    assign(fi,tfi);reset(fi);
    readln(fi,n,k);
    for i:=1 to n do
        for j:=1 to n do
            readln(fi,a[i,j]);
     close(fi);
    for i:=1 to n do
     for j:=1 to n do
     begin
      sum[i,j]:=sum[i-1,j]+sum[i,j-1]-sum[i-1,j-1]+a[i,j];
     end;
    max:=0;

    for i:=k to n do
     for j:= k to n do
      begin
          tg:=sum[i,j]-sum[i-k,j]-sum[i,j-k]+sum[i-k,j-k];
          if tg> max then max:=tg;
      end;
             assign(fo,tfo);rewrite(fo);
          writeln(fo,tg);
          close(fo);
END.