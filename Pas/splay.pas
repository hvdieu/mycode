{$INLINE ON}
const
        tfi     =       '';
        tfo     =       '';
        nmax    =       100001 ;
type
        nod     =       record
                l,r,con,pa : longint ;
                end;
var
        fi,fo   :       text;
        n,m,root     :       longint;
        t       :       array[0..Nmax] of nod ;
procedure Update(i: longint);     inline ;
begin
        t[i].con := t[t[i].l].con + t[t[i].r].con + 1;
end ;
procedure Cnt(i,j,ok :longint);   inline ;
begin
        t[j].pa := i ;
        if ok = 1 then t[i].l := j else t[i].r := j ;
end;
function Inn(l,r :longint) : longint;
var
        mid :longint;
begin
        if l > r then exit(0);
        mid := (l + r) shr 1;
        cnt(mid,inn(l,mid-1),1) ;
        cnt(mid,inn(mid+1,r),2);
        Update(mid) ;
        inn := mid ;
end;
procedure Uptree(i :longint) ;  inline ;
var
        p,pp :longint;
begin
        p := t[i].pa;
        pp := t[p].pa;
        if t[p].l = i then
         begin
                cnt(p,t[i].r,1) ;
                cnt(i,p,2) ;
         end else
          begin
                cnt(p,t[i].l,2) ;
                cnt(i,p,1) ;
          end ;
         Update(p);
         UPdate(i);
         if pp <> 0 then
          begin
                if t[pp].l = p then cnt(pp,i,1) else cnt(pp,i,2) ;
          end else t[i].pa := 0;
end;
procedure splay(i: longint) ;
var
        p,pp :longint ;
begin
        while t[i].pa <> 0 do
         begin
                p := t[i].pa;
                pp := t[p].pa ;
                if pp <> 0 then
                 begin
                        if (t[p].l = i) = (t[pp].l = p) then
                          Uptree(p) else Uptree(i);
                 end;
                Uptree(i);
         end;
end;
procedure Ups(i:longint) ;
var
        j :longint;
begin
        j := i;
        while i <> 0 do
         begin
              Update(i);
              i := t[i].pa ;
         end;
       splay(j) ;
end;
function find(i,x:longint) :longint;
begin
        repeat
                if t[t[i].l].con + 1  = x then exit(i);
                if t[t[i].l].con >= x then i := t[i].l else
                 begin
                        if t[i].r = 0 then exit(i);
                        x := x - 1 - t[t[i].l].con ;
                        i := t[i].r ;
                 end;
        until false;
end ;
procedure Cut(i,u :longint;var t1,t2:longint);
begin
        if u = 1 then
         begin
                t1 := 0;
                t2 := i;
                exit ;
         end;
        if u = t[i].con + 1 then
         begin
                t1 := i;
                t2 := 0;
                exit;
         end;
         i := find(i,u) ;
         splay(i) ;
         t1 := t[i].l ;
         t2 := i ;
         t[i].l := 0;
         Update(i) ;
         t[t1].pa := 0;
end;
function Union(t1,t2: longint) :longint;
begin
        if t1 = 0 then exit(t2);
        while t[t1].r <> 0 do t1 := t[t1].r ;
        cnt(t1,t2,2) ;
        Ups(t1) ;
        Union := t1 ;
end;
procedure Insert(u,k,v :longint) ;
var
        t1,t2,t3: longint;
begin
        Cut(root,u,t1,t2) ;
        Cut(t2,k+1,t2,t3) ;
        T1 := Union(t1,t3) ;
        Cut(t1,v,t1,t3) ;
        root := Union(t1,t2) ;
        root := Union(root,t3) ;
end ;
procedure Inn2(i: longint);
begin
        if i = 0 then exit ;
        inn2(t[i].l) ;
        write(fo,i,' ') ;
        inn2(t[i].r) ;
end;
procedure process;
var
        i,u,v,k: longint ;
begin
        read(fi,n,m) ;
        root := inn(1,n) ;
        for i := 1 to m do
         begin
                read(fi,u,k,v ) ;
                Insert(u,k,v) ;
         end ;
        INn2(root) ;
end;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                process;
        close(fo);
        close(fi) ;
end.








