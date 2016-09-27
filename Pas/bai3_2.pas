program bai3;
uses crt;
const
          tfi    =       'bai3.inp';
          tfo    =       'bai3.out';
var
        fi,fo   :       text;
        a      :       array[1..2000000] of longint ;
        n,i,f0,f1,f2     :       longint;
BEGIN
      assign(fi,tfi);reset(fi);
          readln(fi,n);
        for i:=1 to n do  readln(fi,a[i]);
        close(fi);
        assign(fo,tfo);rewrite(fo);
           for i:=1 to n do
            begin
            f0:=0;f1:=1;f2:=2;
              while f2<a[i] do
               begin
               f2:=f1+f0;
               f0:=f1;
               f1:=f2;
               if f2=a[i] then writeln(fo,a[i]);

               end;
          end;
        close(fo);
END.