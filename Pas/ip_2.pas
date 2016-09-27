uses crt;
const
        tfi     =       'ip.inp';
        tfo     =       'ip.out';
var
       fi,fo    :       text;
       d        :       array[1..500001] of longint;
       n,j,i    :       longint;
BEGIN
      assign(fi,tfi);reset(fi);
       read(fi,n);
       for i:=1 to n do
        begin
         read(fi,j);
         if j<500001 then d[j]:=1;
        end;
      close(fi);
      assign(fo,tfo);rewrite(fo);
       for i:=1 to n+1 do if d[i]=0 then
        begin
         write(fo,i);
         break;
        end;
      close(fo);

END.