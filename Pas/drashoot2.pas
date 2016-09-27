uses math ;
const
        tfi     =       'drashoot.inp';
        tfo     =       'dra.ou1';
        Nmax    =       100001;
type
        node    =       record
                s,sm : longint ;
                end;
        arr1    =       array[0..Nmax] of longint ;
        arr2    =       array[0..4 * Nmax] of node ;
var
        fi,fo   :       text;
        n,m     :       longint ;
        a       :       arr1 ;
        t       :       arr2 ;
procedure Nhap;
var
        i,j,k :longint;
begin
        REadln(fi,n);
        for i := 1 to n do Readln(fi,a[i]) ;
        Readln(fi,m) ;
end;
procedure INN(i,lo,hi :longint) ;
var
        mid :longint;
begin
        if lo = hi then
         begin
              t[i].sm := a[lo];
              exit;
         end ;
        mid := (lo + hi) shr 1;
        Inn(i*2,lo,mid) ;
        Inn(i*2+1,mid+1,hi) ;
        t[i].sm := max(t[i*2].sm,t[i*2+1].sm) ;
end;
function find(i,lo,hi,x :longint ):longint ;
var
        mid :longint ;
begin
        if lo = hi then
         begin
                if t[i].s = x then exit(lo) ;
                exit(0);
         end;
        mid := (lo + hi) shr 1;
        if t[i*2].s >= x then exit(Find(i*2,lo,mid,x)) ;
        find := find(i*2+1,mid+1,hi,x- t[i*2].s) ;
end;
function find2(i,lo,hi,x :longint) :longint;
var
        mid :longint;
begin
        if lo = hi then exit(lo);
        mid := (lo + hi) shr 1;
        if mid - lo + 1 - t[i*2].s >= x then exit(find2(i*2,lo,mid,x))
         else exit(find2(i*2+1,mid+1,hi,x - (mid - lo + 1 - t[i*2].s))) ;
end;
function Qr(i,lo,hi,u,v :longint ): longint;
var
        mid :longint;
begin
        if (u > hi) or (v < lo) then exit(-1);
        if (u <= lo) and (hi <= v) then exit(t[i].sm) ;
        mid := (lo + hi) shr 1;
        Qr := max(Qr(i*2,lo,mid,u,v),Qr(i*2+1,mid+1,hi,u,v)) ;
end;
procedure UPdate(i,lo,hi,u :longint );
var
        mid :longint;
begin
        if (u > hi) or (u < lo) then exit ;
        if lo=  hi then
         begin
                t[i].sm := -1;
                t[i].s := 1;
                exit ;
         end;
         mid := (lo + hi) shr 1;
         Update(i*2,lo,mid,u);
         UPdate(i*2+1,mid+1,hi,u) ;
         t[i].s := t[i*2].s + t[i*2+1].s ;
         t[i].sm := max(t[i*2].sm,t[i*2+1].sm) ;
end;
procedure Init;
var
        i,j,k: longint;
begin
        inn(1,1,n);
end;
procedure xuly;
var
        i,u,v,x: longint;
        ch :char ;
begin
        for i := 1 to m do
         begin
               Read(fi,ch) ;
               if ch = 'S' then
                begin
                        Readln(fi,ch,u) ;
                        u := find2(1,1,n,u) ;
                        UPdate(1,1,n,u);
                end else
                 begin
                        REadln(fi,ch,u,v) ;
                        if u < 0 then u := 0 ;
                        if u > v then writeln(fo,'NONE') else
                         begin
                                if t[1].s < u then u := n + 1
                                 else
                                  begin
                                   if u = 0 then u := 1 else
                                     u := find(1,1,n,u) + 1;
                                  end ;
                                if t[1].s < v + 1 then v := n else
                                 v := min(n,find(1,1,n,v + 1) - 1);
                                if u <= v then
                                 begin
                                  x := qr(1,1,n,u,v) ;
                                  if x <> -1 then writeln(fo,x) else
                                   writeln(fo,'NONE');
                                 end else
                                  writeln(fo,'NONE');
                         end;
                 end;
         end ;
end;
procedure inkq;
var
        i,j,k: longint;
begin

end;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                  Nhap;
                  init;
                  xuly;
                  inkq;
        close(fo);
        close(fi);
end.

