uses crt;
var
       d        :       array[1..500001] of longint;
       n,j,i    :       longint;
BEGIN
       read(n);
       for i:=1 to n do
        begin
         read(j);
         if j<500001 then d[j]:=1;
        end;
       for i:=1 to n+1 do if d[i]=0 then
        begin
         write(i);
         break;
        end;

END.