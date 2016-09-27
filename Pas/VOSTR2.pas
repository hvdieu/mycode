{$H+}
uses math ;
const
        tfi     =       'VOSTR.INP';
        tfo     =       'VOSTR.OU1';
        Nmax    =       1000001;
        p      =        1000000007 ;
type
        arr1    =       array[0..Nmax] of longint;
var
        fi,fo   :       text;
        n,m,q     :    longint;
        a,b:string ;
        sa,sb,mu:arr1 ;
procedure Nhap;
begin
        readln(fi,m,n) ;
        readln(fi,a) ;
        readln(fi,b) ;
end ;
procedure init;
var
        i: longint;
begin
        mu[0] :=1 ;
        for i := 1 to max(m,n) do
           mu[i] := int64(mu[i-1]) * 26 mod p ;
        for i := 1 to m do
                Sa[i] := (int64(Sa[i-1]) * 26 + ord(a[i]) - ord('a')) mod p ;
        for i := 1 to n do
                Sb[i] := (int64(sb[i-1]) * 26 + ord(b[i]) - ord('a')) mod p ;
end;
function GetA(i,j: longint) :longint;
begin
         GetA := ((Sa[i+j-1] - int64(sa[i-1]) * mu[j]) mod p + p) mod p ;
end;
function GetB(i,j :longint) :longint;
begin
        GetB := ((sb[i+j-1] - int64(sb[i-1]) * mu[j]) mod p + p) mod p ;
end;
function find(i,j,k: longint) :longint;
var
        l,r,mid :longint;
        begin
                l := 1;
                r := k ;
                while l <= r do
                begin
                        mid := (l + r) shr 1;
                        if GetA(i,mid) = Getb(j,mid) then
                         begin
                                find := mid ;
                                l := mid + 1;
                         end else r := mid - 1;
                end ;
        end;
procedure xuly;
var
        i,j,k,l,r,u,v,x,y: longint ;
begin
        readln(fi,q) ;
        for i := 1 to q do
        begin
                readln(fi,l,r,u,v) ;
                if a[l] <> b[u] then
                begin
                        if a[l] < b[u] then write(fo,'<')
                         else write(fo,'>') ;
                end else
                 begin
                        x := r - l + 1;
                        y := v - u + 1;
                        k := find(l,u,min(x,y)) ;
                        if k <> min(x,y) then
                         begin
                                if A[l+k] < B[u+k] then
                                 write(fo,'<') else write(fo,'>')
                         end else
                          begin
                                if x  = y then write(fo,'=') else
                                 begin
                                        if x < y then write(fo,'<')
                                         else write(fo,'>') ;
                                 end;
                          end;
                 end ;
        end;
end;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
              nhap;
              init;
              xuly;
        close(fi);
        close(fo);
end.






