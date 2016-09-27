uses  math ;
{========================================}
const
        tfi     =       'mbipalin.inp';
        tfo     =       'asd.out';
        Nmax    =       1000001;
type
        arr1    =       array[0..Nmax] of longint  ;
var
        fi,fo   :       text;
        n,m     :       longint;
        res,n2     :       int64 ;
        fl      :       arr1;
        t       :       int64 ;
{========================================}
procedure Nhap;
var
        i,j,k:longint;
begin
        Read(fi,n,m);
end;
{========================================}
procedure Pushl(x:longint);
var
        s:string;
        i,c:longint;
begin
        c := 0;
        str(x,s);
        for i := n div 2 downto 1 do s := s + s[i];
        For i := 1 to n do c := (c * 10 + ord(s[i])-48) mod m;
        c := t * c mod m;
        inc(fl[c]);
end;
procedure Pushr(x:longint);
var
        s:string;
        i,c:longint;
begin
        c := 0;
        str(x,s);
        while length(s) < n2 do s := '0' + s;
        For i := n div 2 downto 1 do s := s + s[i];
        For i := 1 to n do c := (c * 10 + ord(s[i])-48) mod m;
        c := ( m - c ) mod m;
        res := res + Fl[c];
end;
{========================================}
procedure init;
var
        i,j,k,dau,cuoi :longint;
begin
        n := n div 2;
        n2 := (n+1) div 2;
        cuoi := 10 ** n2 - 1 ;
        t := 10 ** n ;
        dau := 10 ** (n2-1) ;
        For i := dau to cuoi do Pushl(i);
        For i := 0 to cuoi do Pushr(i);
end;
{========================================}
{========================================}
procedure xuly;
var
        i,j,k:longint;
begin
        if n = 2 then
          begin
                for i := 10 to 99 do if i mod m = 0 then inc(res);
                exit ;
          end;
        init ;
end;
{========================================}
procedure inkq;
var
        i,j,k:longint;
begin
        writeln(fo,res);
end;
{========================================}
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
        Nhap;
        xuly;
        inkq;
        close(fi);
        close(fo);
end.
{========================================}


