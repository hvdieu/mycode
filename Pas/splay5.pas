{$INLINE ON}
uses math ;
const
        tfi     =       'shufflek.inp';
        tfo     =       'shufflek.ou1';
        Nmax    =       310001;
type
        nod     =       record
                l,r,con,pa,x,val :longint
                end;
var
        fi,fo   :       text ;
        n,m,root,dem,res      :       longint;
        t       :       array[0..Nmax] of nod ;
        a,b,vt,pos,tree     :       array[0..Nmax] of longint ;
procedure Update(i: longint); inline ;
begin
         t[i].con := t[t[i].l].con + t[t[i].r].con + t[i].val ;
end;
procedure cnt(i,j,ok :longint); inline ;
begin
        t[j].pa := i ;
        if ok = 1 then t[i].l := j else t[i].r := j ;
end;
procedure Uptree(i :longint) ;  inline ;
var
        p,pp:longint;
begin
        p := t[i].pa ;
        pp := t[p].pa ;
        if t[p].l = i then
         begin
                cnt(p,t[i].r,1) ;
                cnt(i,p,2) ;
         end else
          begin
                cnt(p,t[i].l,2) ;
                cnt(i,p,1);
          end;
         Update(p) ;
         UPdate(i) ;
         if pp <> 0 then
          begin
                 if t[pp].l = p then cnt(pp,i,1) else cnt(pp,i,2);
          end else t[i].pa := 0;
end;
procedure splay(i: longint);
var
        p,pp : longint;
begin
        while t[i].pa <> 0 do
         begin
                p := t[i].pa ;
                pp := t[p].pa ;
                if pp <> 0 then
                 begin
                        if (t[p].l = i) = (t[pp].l = p) then
                           Uptree(p) else Uptree(i);
                 end;
               Uptree(i) ;
         end;
end;

function Find(i,x: longint) :longint;
begin
        repeat
                if t[t[i].l].con >= x then i := t[i].l else
                 begin
                    x := x - t[t[i].l].con;
                    if x <= t[i].val then
                       begin
                             if x = 1 then exit(i) ;
                             inc(dem) ;
                             t[dem].val := t[i].val - x + 1 ;
                             t[i].val := x - 1  ;
                             t[dem].x := t[i].x + t[i].val ;
                             cnt(dem,t[i].r,2) ;
                             cnt(i,dem,2) ;
                             Update(dem) ;
                             Update(i) ;
                             exit(dem);
                       end;
                     x := x - t[i].val ;
                     if t[i].r = 0 then exit(i) ;
                     i := t[i].r ;
                 end;
        until false;
end;
procedure Ups(i: longint);
var
        j :longint;
begin
        j := i;
        while j <> 0 do
         begin
                Update(j);
                j := t[j].pa ;
         end;
      splay(i) ;
end;
procedure Cut(i,u :longint;var t1,t2:longint);
begin
        i := find(i,u) ;
        splay(i) ;
        t1 := t[i].l ;
        t2 := i ;
        t[i].l := 0 ;
        t[t1].pa := 0 ;
        Update(i) ;
end;
function Union(t1,t2: longint) :longint;
begin
        while t[t1].r <> 0 do t1 := t[t1].r ;
        cnt(t1,t2,2) ;
        Ups(t1) ;
        Union := t1 ;
end;
procedure Union_l(t1,t2: longint);
begin
        while t[t1].l <> 0 do t1 := t[t1].l ;
        cnt(t1,t2,1) ;
        Ups(t1) ;
        root := t1;
end;
procedure Union_r(t1,t2: longint);
begin
        while t[t1].r <> 0 do t1 := t[t1].r ;
        cnt(t1,t2,2) ;
        Ups(t1) ;
        root := t1;
end;
procedure Insert(u,v,k:longint);
var
        t1,t2,t3:longint;
begin
        Cut(root,u,t1,t2) ;
        Cut(t2,v-u+2,t2,t3) ;
        root := Union(t1,t3) ;
        if k < 0 then Union_r(root,t2)
         else Union_l(root,t2) ;
end ;
procedure xuly;
var
        i,u,v,k: longint;
begin
        dem := 1;
        read(fi,n,m) ;
        root := 1;
        t[1].x := 1;
        t[1].val := 2 * n ;
        t[1].con := 2 * n;
        for i := 1 to m do
         begin
               read(fi,k) ;
               u := n - abs(k) + 1;
               v := n + abs(k) ;
               if abs(k) <> n then
                  Insert(u,v,k) ;
         end;
end;
procedure Inn2(i: longint);
begin
        if i = 0 then exit ;
        inn2(t[i].l);
        inc(dem);
        a[dem] := t[i].x ;
        b[dem] := t[i].val ;
        vt[dem] := dem ;
        inn2(t[i].r);
end;
procedure doicho(var x,y :longint);
var
        tg: longint;
begin
        tg := x;
        x := y;
        y := tg;
end;
procedure sort(l,r: longint);
var
        i,j,k: longint ;
begin
        i := l;
        j := r;
        k := a[l + random(r - l + 1)];
        while i <= j do
         begin
                while a[i] < k do inc(i) ;
                while a[j] > k do dec(j) ;
                if i <= j then
                 begin
                        doicho(a[i],a[j]) ;
                        doicho(b[i],b[j]) ;
                        doicho(vt[i],vt[j]) ;
                        inc(i) ;
                        dec(j) ;
                 end;
         end;
         if i < r then sort(i,r) ;
         if j > l then sort(l,j) ;
end;
function qr(i: longint):longint;
begin
        qr := 0;
        while i > 0 do
         begin
                qr := max(qr,tree[i]) ;
                i := i - i and (-i ) ;
         end;
end;
procedure UPd(i,j :longint);
begin
        while i <= dem do
         begin
                tree[i] := max(tree[i],j) ;
                i := i + i and (-i ) ;
         end ;
end;
procedure xuly2;
var
        i,j,k:longint;
begin
        dem := 0 ;
        inn2(root) ;
        sort(1,dem) ;
        for i := 1 to dem do pos[vt[i]] := i ;
        for i := 1 to dem do
         begin
                k := qr(pos[i]) + b[pos[i]] ;
                res := max(res,k) ;
                upd(pos[i],k) ;
         end;
         write(fo,2*n - res) ;
end ;
procedure make;
var
        i,j :longint;
begin
        assign(fi,tfi);rewrite(fi) ;
                n := 1000000000 ;
                m := 100000 ;
                writeln(fi,n,' ',m) ;
                for i := 1 to m do
                 begin
                        j := random(2) ;
                        if j = 1 then write(fi,'-') ;
                        writeln(fi,random(n - 1) + 1) ;
                 end;
        close(fi);
end;
begin
      //  make ;
        assign(fi,tfi);reset(fi) ;
        assign(fo,tfo);rewrite(fo) ;
                   xuly ;
                   xuly2 ;
        close(fi);
        close(fo);
end .














