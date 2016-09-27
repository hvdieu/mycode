uses math ;
const
        tfi     =       'qtree.inp';
        tfo     =       'qtree.ou1';
        Nmax    =       10001;
type
        arr1    =       array[0..Nmax] of longint ;
var
        fi,fo   :       text;
        n,m,p,top,count,count2,dem,res     :       longint;
        head,num,thoat,nen,con,st,lab,l,r,gt,pos      :       arr1 ;
        t:array[0..4*Nmax] of longint ;
        f:array[0..Nmax,0..20] of longint ;
        a,next,ts:array[-Nmax..Nmax] of longint ;
procedure visit(i: longint) ;
var
j,k,m: longint;
begin
        for j := 1 to p do f[i,j] := f[f[i,j-1],j-1] ;
        inc(count) ;
        num[i] := count ;
        con[i] := 1 ;
        j := head[i];
        m := 0 ;
        while j<> 0 do
          begin
                k := a[j];
                if K <> f[i,0] then
                 begin
                    f[k,0] := i;
                    visit(k) ;
                    gt[k] := ts[j] ;
                    if m < con[k] then begin
                        m := con[k];nen[i] := k ;
                    end ;
                   con[i] := con[i] + con[k] ;
                 end;
                j := next[j] ;
          end ;
          inc(count2) ;
          thoat[i] := count2 ;
end;
function Cha(x,y: longint) :boolean;
begin
        exit((num[x] <= num[y]) and (thoat[x] >= thoat[y])) ;
end;
function LCA(x,y: longint) :longint;
var
        k: longint;
begin
        if cha(x,y) then exit(x) ;
        if cha(y,x) then exit(y) ;
        for k := p downto 0 do if cha(f[x,k],y) = false then
         x := f[x,k] ;
         exit(f[x,0]) ;
end;
function find(x,y:longint) :longint;
var
       k: longint;
begin
        for k := p downto 0 do if cha(f[x,k],y)=false then x := f[x,k] ;
        exit(x) ;
end;
procedure Visit2(i :longint) ;
var
j,k: longint;
begin
        if i = 0 then exit ;
        inc(top) ;
        st[top] := i ;
        lab[i] := dem ;
        visit2(nen[i]) ;
        j := head[i];
        while j<> 0 do
        begin
                k := a[j];
                if (f[k,0] = i) and (nen[i] <> k) then
                 begin
                        inc(dem) ;
                        Visit2(k) ;
                 end ;
                j := next[j];
        end ;
end;
procedure inn(i,lo,hi: longint);
var
        mid :longint;
begin
        if lo = hi then
         begin
                t[i] := gt[st[lo]] ;
                exit ;
         end;
        mid := (lo + hi) shr 1;
        Inn(i*2,lo,mid) ;
        inn(i*2+1,mid+1,hi) ;
        t[i] := max(t[i*2],t[i*2+1]) ;
end;
procedure Update(i,lo,hi,u,x: longint) ;
var
        mid :longint;
begin
        if (u > hi) or (u  <lo) then exit ;
        if lo = hi then
         begin
                t[i] := x;
                exit;
         end;
       mid := (lo + hi) shr 1;
       Update(i*2,lo,mid,u,x) ;
       Update(i*2+1,mid+1,hi,u,x) ;
       t[i] := max(t[i*2],t[i*2+1]) ;
end;
function Qr(i,lo,hi,u,v:longint) :longint;
var
        mid: longint;
begin
        if (u > hi) or (v <lo) then exit(-maxlongint) ;
        if (u <= lo) and (hi <= v ) then exit(t[i]) ;
        mid := (lo +hi ) shr 1;
        qr := max(qr(i*2,lo,mid,u,v),Qr(i*2+1,mid+1,hi,u,v)) ;
end;
procedure Get(u,v: longint);
var
        u2 :longint;
begin
        if lab[u] = lab[v] then begin
                res := max(res,Qr(1,1,n,pos[u],pos[v])) ;
                exit;
        end;
        u2 := st[l[pos[v]]] ;
        res := max(res,qr(1,1,n,pos[u2],pos[v])) ;
        Get(u,f[u2,0]) ;
end;
procedure xuly;
var
        i,x,y,u,v,u2,v2: longint ;
        c,c2:char;
begin
        readln(fi,n) ;
        for i := 0 to 20 do if 1 shl i <= n then p := i;
        inc(p) ;
        for i := 1 to n do
         begin
          head[i] := 0 ;
          nen[i] := 0 ;
          f[i,0] := 0 ;
         end;
        for i := 1 to n -1 do
        begin
                readln(fi,x,y,ts[i]) ;
                ts[-i] := ts[i] ;
                a[i] := y;next[i] := head[x];head[x] := i;
                a[-i] := x;next[-i] := head[y];head[y] := -i;
        end;
        f[1,0] := 1;
        gt[1] := 0 ;
        count := 0;
        count2 := 0;
        top := 0 ;
        dem := 1 ;
        visit(1) ;
        visit2(1) ;
        st[top+1] := 0 ;
        for i := 1 to top do
        begin
                pos[st[i]] := i ;
                if lab[st[i]] = lab[st[i-1]] then l[i] := l[i-1]
                 else l[i] := i ;
        end;
        for i := top downto 1 do if lab[st[i]] = lab[st[i+1]] then r[i] := r[i+1]
         else r[i] := i ;
         inn(1,1,n) ;
         repeat
                 read(fi,c) ;
                 case c of
                        'D' : begin
                                readln(fi);
                                exit;
                        end;
                        'Q' : begin
                              for i := 1 to 5 do read(fi,c2) ;
                              readln(fi,u,v) ;
                              x := lca(u,v) ;
                              res := -maxlongint ;
                              if x <> u then begin
                                     u2 := find(u,x) ;
                                     Get(u2,u) ;
                                   end;
                              if x <> v then
                              begin
                                      v2 := find(v,x) ;
                                      Get(v2,v) ;
                              end;
                              writeln(fo,res) ;
                        end ;
                        'C' : begin
                               for i := 1 to 6 do read(fi,c2) ;
                               read(fi,u,v) ;
                               if cha(a[-u],a[u]) then u := a[u] else u := a[-u] ;
                               Update(1,1,n,pos[u],v) ;
                        end;
                  end;
         until false;
end;
procedure process;
var
        i,j,k:longint;
begin
        readln(fi,k) ;
        for i := 1 to k do
         begin
                readln(fi) ;
                xuly ;
         end;
end ;
procedure make;
var
        i,j,k: longint;
begin
        assign(fi,tfi) ;rewrite(fi) ;
                randomize;
        close(fi) ;
end;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                process;
        close(fi);
        close(fo) ;
end.

