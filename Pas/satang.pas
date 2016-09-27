CONST
        tfi     =       'saptang.inp';
        tfo     =       'saptang.out';
TYPE
        arr     =       array[1..100000] of longint;
VAR
        a,b     :       arr;
        n,j,i,tg:       longint;
        fi,fo   :       text;
PROCEDURE   NHAP;
     BEGIN
         ASSIGN(fi,tfi);reset(fi);
         read(fi,n);
           for i:=1 to n do
           read(fi,a[i]);
           for i:=1 to n do
           read(fi,b[i]);
        close(fi);
     END;
procedure   sapxep(  var  x,y     :       longint);
        begin

             begin
                tg:=x;
                x:=y;
                y:=tg;
             end;
        end;
procedure   xuly;
        begin
            for i:=1 to n-1 do
            for j:=i+1 to n do
            if (a[i]>a[j]) or (a[i]=a[j]) and (b[i]>b[j]) then
             begin
                   sapxep(a[i],a[j]);
                   sapxep(b[i],b[j]);
             end;
        end;
procedure  inkq;
    begin
       assign(fo,tfo);rewrite(fo);
         for i:=1 to n do
          write(fo,a[i],' ');
          write(fo,b[i],' ');
       close(fo);
    end;
    begin
          nhap;
          xuly;
          inkq;
    end.