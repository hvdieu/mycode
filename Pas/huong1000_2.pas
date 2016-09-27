program garden;
var
        a,sum:       array[0..1001,0..1001] of longint;
        n,sl,k,i,max,j,u,v,tg,p:longint;
BEGIN
    read(n,p,k);
    for i:=1 to p do
     begin
         readln(u,v);
         a[u,v]:=1;
     end;

    for i:=1 to n do
     for j:=1 to n do
      sum[i,j]:=sum[i-1,j]+sum[i,j-1]-sum[i-1,j-1]+a[i,j];

    max:=-1;

    for i:=k to n do
     for j:= k to n do
      begin
          tg:=sum[i,j]-sum[i-k,j]-sum[i,j-k]+sum[i-k,j-k];
          if tg> max
           then
            begin
              max:=tg;
              sl:=1;
            end
           else if tg=max then inc(sl);

      end;
    writeln(max);
    writeln(sl);
  readln;
END.