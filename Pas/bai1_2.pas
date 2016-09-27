program bai3;
uses crt;
const
          tfi    =       'bai3.inp';
          tfo    =       'bai3.out';
var
        fi,fo   :       text;
        a,s      :       array[1..2000000] of longint ;
        n,i,j     :       longint;
BEGIN
      assign(fi,tfi);reset(fi);
          readln(fi,n);
        for i:=1 to n do  readln(fi,a[i]);
        close(fi);
        assign(fo,tfo);rewrite(fo);
           for i:=1 to n do
            begin
            s[0]:=0;s[1]:=1;j:=2;
              while s[j]<a do
               begin
               s[j]:=s[j-1]+s[j-2];
               if s[j]=a[i] writeln(fo,a[i]);
               inc(j);
               end;
          end;
        close(fo);
END.