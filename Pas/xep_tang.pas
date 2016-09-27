
var
        fi,fo:text;
        a:array[1..1000] of longint;
        n,i,j,tg:longint;
BEGIN
        assign(fi,'dayso.inp');reset(fi);
        write('nhap n=');readln(fi,n);
        for i:=1 to n do
         read(fi,a[i]);
        close(fi);
        for i:=1 to n-1 do
         for j:=i+1 to n do
          if a[i]>a[j] then
           begin
            tg:=a[i];
            a[i]:=a[j];
            a[j]:=tg;
           end;
       assign(fo,'dayso.out');rewrite(fo);
              for i:=1 to n do
                  write(fo,a[i],' ');
       close(fo);
END.
