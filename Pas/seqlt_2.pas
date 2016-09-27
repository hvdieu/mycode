uses crt;
const
        tfi     =       'seqlt.inp';
        tfo     =       'seqlt.out';
var
       fi,fo    :       text;
       a,dem    :       array[1..500001] of longint;
       n,j,i,max    :       longint;
BEGIN
      assign(fi,tfi);reset(fi);
       read(fi,n);
       for i:=1 to n do
        read(fi,a[i]);
       close(fi);
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
       assign(fo,tfo);rewrite(fo);
       write(fo,max);
       close(fo);


END.
