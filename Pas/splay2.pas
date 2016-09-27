const
        tfi     =       'passet.inp';
        tfo     =       'passet.ou1';
        Nmax    =       300001;
type
        node    =       record
                l,r,x,pa: longint;
                end;
        arr1    =       array[0..Nmax] of node;
var
        fi,fo   :text;
        n,m,root       :longint;
        t       :      arr1 ;
procedure Cnt(i,j,ok : longint);
begin
        if ok = 1 then t[i].l := j else t[i].r := j ;
        t[j].pa := i ;
end;
procedure Uptree(i :longint) ;
var
        p,pp :longint;
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
                cnt(i,p,1) ;
          end;
        if pp <> 0 then
         begin
                if t[pp].l = p then cnt(pp,i,1)
                 else cnt(pp,i,2) ;
         end else t[i].pa := 0;
end;
procedure Splay(i: longint) ;
var
        p,pp :longint;
begin
        while t[i].pa <> 0  do
         begin
                p := t[i].pa ;
                pp := t[p].pa ;
                if pp <> 0 then
                 begin
                        if (t[pp].l = p) = (t[p].l = i) then
                          UPtree(p) else Uptree(i) ;
                 end ;
                Uptree(i) ;
         end;
end ;
function find0(i,x:longint) : longint;
begin
        while i <> 0 do
         begin
                if t[i].x >= x then
                 begin
                        find0 := i ;
                        i := t[i].l ;
                 end else begin
                        if t[i].r = 0 then exit(i) ;
                        i := t[i].r ;
                 end;
         end;
end;
function find(i,x:longint) :longint;
begin
	find := 0 ;
        while i <> 0 do
         begin
                if t[i].x = x then exit(i) ;
                if t[i].x < x then i := t[i].r else
                 i := t[i].l  ;
         end;
end;
function find5(i,x: longint) :longint;
begin
        find5 := 0;
        while i <> 0 do
         begin
                if t[i].x > x then
                 begin
                        find5 := i;
                        i := t[i].l ;
                 end else
                  i := t[i].r ;
        end;
end;
function find6(i,x:longint) :longint;
begin
        find6 := 0;
        while i <> 0 do
         begin
                if t[i].x >= x then
                 begin
                        find6 := i;
                        i := t[i].l ;
                 end else i := t[i].r ;
         end ;
end;
function find7(i,x:longint) :longint;
begin
        find7 := 0;
        while i<> 0 do
         begin
                if t[i].x < x then
                 begin
                        find7 := i ;
                        i := t[i].r ;
                 end else i := t[i].l ;
         end;
end ;
function find8(i,x:longint) :longint;
begin
        find8 := 0;
        while i<> 0 do
         begin
                if t[i].x <= x then
                 begin
                        find8 := i ;
                        i := t[i].r ;
                 end else i := t[i].l ;
         end;
end ;
procedure Delete(x :longint) ;
var
        i,y,z :longint;
begin
        i := find(root,x) ;
        if i = 0 then exit ;
        while (t[i].l <> 0 ) and (t[i].r <> 0) do
           Splay(t[i].r) ;
        if t[i].l <> 0 then y := t[i].l else y := t[i].r ;
        z := t[i].pa;
        if z = 0 then
         begin
                root := y;
                exit ;
         end;
       if t[z].l = i then cnt(z,y,1) else cnt(z,y,2) ;
       splay(z) ;
       root := z;
end;
procedure process;
var
        i,j,k,x,ok: longint ;
begin
        n := 0;
          repeat
                read(fi,ok);
                if ok = 0 then exit ;
                if (ok > 4) or (ok < 3) then read(fi,x) ;
                if (ok > 2) and (root = 0) then writeln(fo,'empty') else
                 begin
                        case ok of
                                1 : begin
                                        if root = 0 then
                                         begin
                                              inc(n) ;
                                              t[n].x := x ;
                                              root := n ;
                                         end else
                                          begin
                                            i := find0(root,x) ;
                                            if t[i].x <> x then
                                              begin
                                                inc(n ) ;
                                                t[n].x := x;
                                                if t[i].x < x then cnt(i,n,2)
                                                 else begin
                                                        if t[i].l = 0 then cnt(i,n,1) else
                                                         begin
                                                                i := t[i].l ;
                                                                while t[i].r <> 0 do i := t[i].r ;
                                                                cnt(i,n,2) ;
                                                         end;
                                                 end ;
                                              end;
                                          end;

                                end;
                                2 : begin
                                        Delete(x) ;
                                end;
                                3 : begin
                                        i := root;
                                        while t[i].l <> 0 do i := t[i].l;
                                        writeln(fo,t[i].x) ;
                                end;
                                4 : begin
                                        i := root ;
                                        while t[i].r <> 0 do i := t[i].r;
                                        writeln(fo,t[i].x) ;
                                end;
                                 5:       i := find5(root,x) ;
                                 6:       i := find6(root,x) ;
                                 7:       i := find7(root,x) ;
                                 8:       i := find8(root,x) ;
                        end;
                      if ok >= 5 then
                       begin
                        if i = 0 then writeln(fo,'no') else
                         writeln(fo,t[i].x);
                       end;
                 end;
              until false;
end;
begin
        assign(fi,tfi) ;reset(fi);
        assign(fo,tfo) ;rewrite(fo);
                   process ;
        close(fo) ;
        close(fi) ;
end .



