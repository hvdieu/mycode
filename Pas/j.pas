program bai3;
uses crt;
const
          tfi    =       'bai3.inp';
          tfo    =       'bai3.out';
var
        fi,fo    :       text;
        a,f      :       array[0..2000000] of longint ;
        i,n,m,j,l,r      :       longint;
BEGIN
    assign(fi,tfi);reset(fi);
      readln(fi,n);
      for i:=1 to n do readln(fi,a[i]);
    close(fi);
       f[0]:=0;
       f[1]:=1;
       i:=1;
       while f[i]<=1000000000 do
          begin
              inc(i);
              f[i]:=f[i-1]+f[i-2];
          end;
          m:=i;

              for i:=1 to n do
               begin
                 l:=1;r:=m;
                  while l<r do
                   begin
                      j:=(l+r) div 2;
                      if f[j]=a[i] then
                        begin
                        assign(fo,tfo);rewrite(fo);
                           writeln(fo,a[i]);
                           break;
                        end
                   else if f[j]>a[i] then r:=j-1
                   else l:=j+1;
                   end;
                 end;
          close(fo);

END.