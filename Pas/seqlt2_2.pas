uses crt;
var
       a,dem    :       array[1..500000] of longint;
       n,j,i,max    :       longint;
BEGIN
       read(n);
       for i:=1 to n do
        read(a[i]);
       j:=1;
       for i:=1 to n do

        begin
         a[n+1]:=-1000000001;
         if a[i]<=a[i+1] then
          begin
           inc(j);
           dem[i]:=j;
          end;
         if a[i]>a[i+1] then
          begin
           j:=1;
           dem[i]:=j;
          end;
        end;
       max:= dem[1];
       for i:=2 to n do
        if max< dem[i] then max:=dem[i];
       write(max);


END.
