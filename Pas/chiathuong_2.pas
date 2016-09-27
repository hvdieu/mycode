const
        tfi     =       'chiathuong.inp';
        tfo     =       'chiathuong.out';
var
        fi,fo   :       text;
        m,n     :       longint;
procedure       nhap;
        begin
            assign(fi,tfi);reset(fi);
            read(fi,m,n);
            close(fi);
        end;
function     f(m,n:longint) : longint;
        begin
           if n=0 then exit(0);
           if (m=1) or (m=0) then exit(1);
           if  m<n then f:=f(m,m)
           else f:=f(m-n,n)+f(m,n-1);
        end;
procedure       inkq;
        begin
            assign(fo,tfo);rewrite(fo);
              write(fo,f(m,n));
            close(fo);
        end;
BEGIN
    nhap;
    inkq;
END.