program muahang;
uses crt;
 const
       tfi      =       'bai.inp';
       tfo      =       'bai1.out';
       nmax     =       1000000;
var
        a       :       array[0..nmax] of longint;
        i,n     :       longint;
        fi,fo   :       text;
BEGIN
        assign(fi,tfi);reset(fi);
        readln(fi,n);
          for i:=1 to n do  readln(fi,a[i]);
          close(fi);
          for i:=1 to n do
            a[i]:=a[i]+a[i-1];
          a[0]:=0;
            assign(fo,tfo);rewrite(fo);
               for i:=0 to n do  writeln(fo,a[i],' ');
            close(fo);
END.