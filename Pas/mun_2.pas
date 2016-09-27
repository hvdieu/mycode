const
        tfi     =       'mun.inp';
        tfo     =       'mun.out';
var
        fi,fo   :       text;
        a,n     :       longint;
procedure       nhap;
        begin
             assign(fi,tfi);reset(fi);
               read(fi,a,n);
             close(fi);
        end;
function        mn(a,n:longint) : longint;
        var  tg : longint;
                begin
                     if n=0 then exit(1);
                     if n=1 then exit(a);
                     tg:=mn(a,n div 2);
                     if n mod 2=0 then exit(tg*tg);
                     if n mod 2=1 then exit(tg*tg*a);
                end;
procedure       inkq;
        begin
           assign(fo,tfo);rewrite(fo);
           write(fo,mn(a,n));
           close(fo);
        end;
BEGIN
    nhap;
    inkq;
END.