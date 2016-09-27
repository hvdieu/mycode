uses math ;
const
        tfi     =       'QTREE.INP';
        tfo     =       'QTREEX.OU1';{spoj.out}
        Nmax    =       10001;
        vc      =       1000000001 ;
type
        arr1    =       array[0..Nmax] of longint ;
        arr2    =       array[-Nmax..Nmax] of longint ;
        arr3    =       array[0..Nmax,0..15] of longint ;
        node    =       record
                xmax,xmin,y :longint;
                end;
var
        fi,fo   :       text;
        n,m,top,count,count2,dem,p     :       longint ;
        head,num,thoat,st,pos,lab ,c,nen,con,dau,cuoi      :       arr1 ;
        next,a,ts     :       arr2 ;
        f       :      arr3 ;
        t       :      array[0..4*Nmax] of node ;
procedure Nhap;
var
        i,x,y,z :longint;
begin
        readln(fi,n) ;
        for i := 1 to n do
         begin
                lab[i] := 0;
                pos[i] := 0;
                head[i] := 0;
                f[i,0] := 0;
                nen[i] := 0;
         end ;
       for i := 1 to n - 1 do
         begin
           readln(fi,x,y,z) ;
           a[i] := y ;
           next[i] := head[x];
           head[x] := i ;
           a[-i] := x;
           next[-i] := head[y];
           head[y] := -i;
           ts[i] := z;
           ts[-i] := z;
         end;
       for i := 0 to 15 do if 1 shl i <= n then p := i;
end;
procedure DFS(i :longint) ;
var
        j,k :Longint;
begin
        inc(count)  ;
        num[i] := count ;
        for j := 1 to p do
          f[i,j] := f[f[i,j-1],j-1] ;
        j := head[i] ;
        con[i] := 1;
        while j <> 0 do
         begin
                k := a[j];
                if k <> f[i,0] then
                   begin
                        f[k,0] := i ;
                        DFS(k );
                        con[i] := con[i] + con[k] ;
                        if (nen[i] = 0) or (con[nen[i]] < con[k]) then
                          nen[i] := k ;
                       c[k] := ts[j] ;
                   end;
                 j := next[j] ;
         end;
         inc(count2) ;
         thoat[i] := count2 ;
end;
procedure DFS2(i :longint) ;
var
        j,k: longint;
begin
        if i = 0 then exit ;
        lab[i] := dem ;
        inc(top) ;
        st[top] := i ;
        DfS2(nen[i]) ;
        j := head[i];
        while j <> 0 do
         begin
                k := a[j];
                j := next[j] ;
                if (k <> nen[i]) and (f[k,0] = i) then
                 begin
                        inc(dem) ;
                        DFS2(k) ;
                 end;
         end ;
end;
function Cha(x,y :longint) :boolean;
begin
        cha := (num[x] <= num[y]) and (thoat[x] >= thoat[y]) ;
end;
function Lca(x,y: longint) :longint;
var
        k :longint;
begin
        if cha(x,y) then exit(x);
        if cha(y,x) then exit(y);
        for k := p downto 0 do if cha(f[x,k],y)= false then x := f[x,k] ;
        lca := f[x,0] ;
end;
function find(x,y :longint) :longint;
var
        k :longint;
begin
        for k := p downto 0 do if cha(y,f[x,k]) and (f[x,k] <> y) then
           x := f[x,k] ;
           find := x ;
end ;
procedure inn(i,lo,hi : longint) ;
var
        mid : longint ;
begin
        t[i].y := 0;
        if lo = hi then
         begin
            t[i].xmin := c[st[lo]] ;
            t[i].xmax := c[st[lo]] ;
            exit ;
         end;
       mid := (lo + hi) shr 1;
       inn(i*2,lo,mid);
       inn(i*2+1,mid+1,hi) ;
       t[i].xmin := min(t[i*2].xmin,t[i*2+1].xmin);
       t[i].xmax := max(t[i*2].xmax,t[i*2+1].xmax);
end;
procedure doicho(var x,y :longint );
var
        tg: longint;
begin
        tg := -x;
        x := -y ;
        y := tg ;
end;
procedure dondl(i :longint) ;
var
        j,k :longint;
begin
        j := i * 2;
        k := j + 1;
        t[j].y := 1 - t[j].y ;
        t[k].y := 1 - t[k].y ;
        doicho(t[j].xmax,t[j].xmin) ;
        doicho(t[k].xmax,t[k].xmin) ;
        t[i].y := 0 ;
end;
procedure Update(i,lo,hi,u,x :longint) ;
var
        mid :longint;
begin
        if (u > hi) or (u < lo) then exit ;
        if lo = hi then
         begin
                t[i].xmin := x ;
                t[i].xmax := x ;
                exit;
         end;
       mid := (lo + hi) shr 1;
       if t[i].y = 1 then Dondl(i) ;
       update(i*2,lo,mid,u,x);
       Update(i*2+1,mid+1,hi,u,x) ;
       t[i].xmin := min(t[i*2].xmin,t[i*2+1].xmin);
       t[i].xmax := max(t[i*2].xmax,t[i*2+1].xmax);
end;
procedure Update2(i,lo,hi,u,v:longint) ;
var
        mid :longint;
begin
        if (u > hi) or (v < lo) then exit ;
        if (u <= lo) and (hi <= v) then
          begin
                doicho(t[i].xmin,t[i].xmax) ;
                t[i].y := 1 - t[i].y ;
                exit ;
          end;
         if t[i].y = 1 then dondl(i) ;
         mid := (lo + hi) shr 1;
         Update2(i*2,lo,mid,u,v) ;
         Update2(i*2+1,mid+1,hi,u,v) ;
         t[i].xmin := min(t[i*2].xmin,t[i*2+1].xmin);
         t[i].xmax := max(t[i*2].xmax,t[i*2+1].xmax);
end;
function qr(i,lo,hi,u,v :longint) :longint ;
var
        mid :longint;
begin
        if (u > hi) or (v < lo) then exit(-vc) ;
        if (u <= lo) and (hi <= v) then exit(t[i].xmax);
        mid := (lo + hi) shr 1;
        if t[i].y = 1 then dondl(i) ;
        qr := max(qr(i*2,lo,mid,u,v),qr(i*2+1,mid+1,hi,u,v)) ;
end;
procedure Init;
var
        i,j,k: longint;
begin
        count := 0;
        count2 := 0;
        f[1,0] := 1 ;
        DFS(1) ;
        dem := 1;
        top := 0;
        DFS2(1) ;
        for i := 1 to n do if lab[st[i]] <> lab[st[i-1]] then
         dau[i] := i else dau[i] := dau[i-1] ;
        cuoi[n] := n;
        for i := n-1 downto 1 do if lab[st[i]] <> lab[st[i+1]] then
          cuoi[i] := i else cuoi[i] := cuoi[i+1] ;
        for i := 1 to n do pos[st[i]] := i ;
        c[1] := -vc ;
        inn(1,1,n) ;
end;
function Get(x,y :longint) :longint;
var
        u :longint;
begin
        if lab[x] = lab[y] then exit(qr(1,1,n,pos[x],pos[y])) ;
        u := dau[pos[y]];
        get := qr(1,1,n,u,pos[y]) ;
        Get := max(get,get(x,f[st[u],0])) ;
end;
procedure Get2(x,y :longint) ;
var
         u : longint;
begin
        if lab[x] = lab[y] then
         begin
          Update2(1,1,n,pos[x],pos[y]) ;
                exit ;
         end;
        u := dau[pos[y]] ;
        Update2(1,1,n,u,pos[y]) ;
        Get2(x,f[st[u],0]) ;
end;
procedure change(i,x :longint) ;
var
        u,v :longint;
begin
        u := a[i] ;
        v := a[-i] ;
        if f[u,0] = v then v := u ;
        Update(1,1,n,pos[v],x) ;
end;
procedure Query(x,y :longint) ;
var
        x2,y2,u,k :longint;
begin
        if  x = y then begin writeln(fo,0);exit;end;
        u := lca(x,y) ;
        if u <> x then x2 := find(x,u) ;
        if u <> y then y2 := find(y,u) ;
        k := -vc ;
        if u <> x then k := Get(x2,x) ;
        if u <> y then k := max(k,get(y2,y)) ;
        writeln(fo,k);
end ;
procedure Negate(x,y :longint);
var
        x2,y2,u :longint;
begin
        if x= y then exit ;
        u := lca(x,y) ;
        if u <> x then x2 := find(x,u) ;
        if u <> y then y2 := find(y,u) ;
        if u <> x then Get2(x2,x) ;
        if u <> y then get2(y2,y) ;
end;
procedure xuly;
var
        i,x,y: longint;
        s1:string[5] ;
        s2:string[6];
        cc:char ;
begin
          repeat
                read(fi,cc) ;
                if cc = 'D' then exit ;
                case cc of
                        'Q' :
                         begin
                                readln(fi,s1,x,y) ;
                                Query(x,y) ;
                         end;
                         'N' :
                          begin
                                readln(fi,s2,x,y) ;
                                negate(x,y) ;
                          end;
                        'C' :
                         begin
                                readln(fi,s2,x,y) ;
                                change(x,y) ;
                         end;
                end;
          until false ;
end;
procedure process ;
var
        i,k  :longint;
begin
        readln(fi,k);
        for i := 1 to k do
         begin
                readln(fi) ;
                nhap;
                init;
                xuly;
         end;
end;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                process ;
        close(fo);
        close(fi);
end.





