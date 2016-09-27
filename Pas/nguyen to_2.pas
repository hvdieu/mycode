CONST
        tfi     =       'nguyento.inp';
        tfo     =       'nguyento.out';
TYPE
        arr     =       array[1..100000] of longint;
VAR
        a       :       arr;
        n,res,i :       longint;
        fi,fo   :       text;
PROCEDURE    NHAP;
   begin
     assign(fi,tfi);reset(fi);
      read(fi,n);
     for i:=1 to n do
       read(fi,a[i]);
     close(fi);
   end;
function   KT(x:longint) : boolean;
      begin
      if x<2 then exit(false);
        for i:=2 to trunc((sqrt(x)) do
         begin
             if x mod i:=0 then
             exit(false);
         end;
         exit(true);
      end;
PROCEDURE XULY;
          res:=0;
      BEGIN
          for i:=2 to x do
            if kt:=true then inc(res);
      END;
PROCEDURE  INKQ;
      BEGIN
          assign(fo,tfo);
          rewrite(fo,res);
          close(fo);
      END;
      begin
          nhap;
          xuly;
          inkq;
      end
