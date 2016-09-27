uses math ;
const
        tfi     =       'alert.inp';
        tfo     =       'alert.out';
        Nmax    =       222 ;
        vc=100000000 ;
type
        arr1    =       array[0..Nmax] of longint ;
var
        fi,fo   :       text;
        n,m,ff,rr,cc,res,s,t,l,ci,dem     :       longint;
        dd,lab,q,trc,head,kq  :       array[0..Nmax] of longint ;
        c,f:array[0..Nmax,0..Nmax] of longint ;
procedure Union(x,y,z: longint) ;
begin
        c[x,y] := z + C[x,y];
        c[y,x] := z + C[y,x];
end;
function findpath :boolean;
var
        i,j,k: longint;
begin
        for i := 1 to t do trc[i] := 0;
        trc[s] := -1;
        ff := 1;
        rr := 1;
        q[1] := s;
        while ff <= rr do
         begin
                i := q[ff];inc(ff) ;
                if i = t then exit(true) ;
                for j := 1 to t do if  (c[i,j] > f[i,j]) and (trc[j] =0 ) then
                 begin
                        trc[j] := i ;
                        inc(rr);q[rr] := j ;
                 end;
         end;
         exit(false) ;
end;
procedure incpath ;
var
        i,delta,u :longint;
begin
        i := t;
        delta := vc;
        while i <> s do
        begin
                u := trc[i];
                delta := min(delta,c[u,i]-f[u,i]) ;
                i := u;
        end ;
        i := t;
        while i <> s do
        begin
                u := trc[i] ;
                inc(f[u,i],delta) ;
                dec(f[i,u],delta) ;
                i := u ;
        end;
        res := res - delta ;
end;
procedure process;
var
        i,j,k,u,v,ic: longint;
begin
        read(fi,n) ;
        read(fi,l) ;
        for i := 1 to l do
        begin
                read(fi,k) ;
                dd[k] := 1;
        end;
        read(fi,ci) ;
        for i := 1 to ci do
        begin
                read(fi,k) ;
                dd[k] := 2 ;
        end;
        dem := 0 ;
        For i := 1 to n do if dd[i]  = 0 then
          begin
                inc(dem) ;
                lab[i] := dem ;
          end;
        s := dem + 1;
        t := dem + 2;
        inc(dem,2) ;
        read(fi,m) ;
        for i := 1 to m do
         begin
                read(fi,u,v,ic) ;
                inc(res,ic) ;
                if dd[u] <> 0 then begin
                        if dd[u] = 1 then u := t else u := s;
                end else u := lab[u];
                if dd[v]  <> 0 then
                 begin
                        if dd[v] = 1 then v := t else v := s;
                 end else v := lab[v] ;
                Union(u,v,ic) ;
         end;
        // for i := 1 to n do if lab[i] <> 0 then Union(s,lab[i],vc,0) ;
         repeat
                if findpath = false then break ;
                incpath ;
         until false;
        write(fo,res,' ') ;
        dem := 0 ;
        For i := 1 to n do if (dd[i] = 1) or ((dd[i] = 0) and (trc[lab[i]] = 0)) then
         begin
                inc(dem) ;
                kq[dem] := i ;
         end;
       writeln(fo,dem);
       for i := 1 to dem do write(fo,kq[i],' ') ;
end;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                process;
        close(fi);
        close(fo) ;
end.