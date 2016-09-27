uses math ;
const
        tfi     =       'qmax4.inp';
        tfo     =       'qmax4.ou1';
        Nmax    =       100001;
        vc      =       1000000001 ;
type
        node    =       record
                  l,r,pa,x,con,y : longint;
                end;
        nod     =       record
                x,y: longint;
                end ;
        arr1    =       array[0..Nmax] of node ;
var
        fi,fo   :       text;
        n,m,root       :       longint;
        t       :       arr1 ;
procedure New(x :longint) ;
begin
        inc(n);
        t[n].y := x ;
        t[n].x := x ;
        t[n].con := 1;
end;
procedure Cnt(x,y,ok: longint) ;
begin
        t[y].pa := x ;
        if ok = 1 then t[x].l := y else t[x].r := y ;
end ;
procedure CC(i: longint);inline ;
begin
        T[i].x := max(max(t[t[i].l].x,t[t[i].r].x),t[i].y) ;
        T[i].con := t[t[i].l].con + t[t[i].r].con + 1 ;
end;
procedure Uptree(i :longint) ;
var
        p,pp : longint;
begin
        p := t[i].pa ;
        pp := t[p].pa ;
        if t[p].l = i then
         begin
                Cnt(p,t[i].r,1) ;
                Cnt(i,p,2) ;
         end else
          begin
                Cnt(p,t[i].l,2);
                cnt(i,p,1) ;
          end;
          cc(p) ;
          cc(i) ;
        if pp <> 0 then
         begin
                if t[pp].l = p then cnt(pp,i,1) else
                  cnt(pp,i,2) ;
         end else t[i].pa := 0;
end ;
procedure Splay(i :longint);
var
        p,pp :longint;
begin
        while (t[i].pa <> 0) do
         begin
                p := t[i].pa ;
                pp := t[p].pa ;
                if pp <> 0 then
                  begin
                        if (t[p].l = i) = (t[pp].l = p) then
                                Uptree(p) else
                                Uptree(i) ;
                  end;
                 Uptree(i) ;
         end;
       root := i ;
end;
function find(i,x : longint) : longint  ;
begin
        repeat
           if t[t[i].l].con + 1 = x then exit(i);
            if t[t[i].l].con >= x then i := t[i].l else
             begin
                 if t[i].r = 0 then exit(i) ;
                 x := x - t[t[i].l].con - 1 ;
                 i := t[i].r ;
             end;
        until false;
end;
procedure Ups(i :longint) ;
var
        j :longint;
begin
        j := i ;
        while i <> 0 do
         begin
                cc(i) ;
                i := t[i].pa ;
         end;
         splay(j) ;
end;
procedure xulyi;
var
        x,y,i,j : longint;
begin
        read(fi,x,y) ;
        new(x) ;
        if root = 0 then begin
                root := n ; exit ;
               end ;
        i := find(root,y) ;
        if y = t[root].con + 1 then Cnt(i,n,2) else
          begin
                if t[i].l = 0 then cnt(i,n,1) else
                 begin
                        i := t[i].l ;
                        while t[i].r <> 0 do i := t[i].r ;
                        Cnt(i,n,2) ;
                 end;
          end ;
          Ups(i) ;
end;
procedure xulys;
var
        x,y,u,v,x1,x2 :longint;
begin
        read(fi,x,y) ;
        if x = y then exit;
        u := find(root,x) ;x1 := t[u].y;
        v := find(root,y) ;x2 := t[v].y;
        t[u].y := x2 ; Ups(u) ;
        t[v].y := x1 ; Ups(v) ;
end;
procedure xulyd;
var
         x,i,y,z,ok: longint;
begin
        read(fi,x);
        i := find(root,x) ;
        while (t[i].l <> 0) and (t[i].r <> 0) do
          Uptree(t[i].r) ;
        if t[i].l = 0 then y := t[i].r else y := t[i].l ;
        z := t[i].pa ;
        if z = 0 then
         begin
                root := y ;
                t[y].pa := 0 ;
                exit ;
         end;
       if t[z].l = i then Cnt(z,y,1) else cnt(z,y,2) ;
       Ups(z) ;
end;
function Cut(i ,u :longint) :nod ;
var
        j:longint ;
begin
        if u = 1 then
         begin
              cut.x := 0 ;
              cut.y := i ;
              exit(cut) ;
         end ;
        if u = t[i].con + 1 then
         begin
                cut.x := i ;
                cut.y := 0 ;
                exit(cut) ;
         end;
         i := find(i,u) ;
         splay(i) ;
         cut.x := t[i].l ;
         cut.y := i ;
         t[t[i].l].pa := 0 ;
         t[i].l := 0 ;
         cc(i) ;
end;
function Union(x,y :longint) :longint;
begin
         if x = 0 then exit(y) ;
         while t[x].r <> 0 do x := t[x].r ;
         splay(x) ;
         cnt(x,y,2) ;
         cc(x) ;Union := x;
end;
procedure xulyq;
var
        x,y,u,v : longint;
        a,b : nod ;
begin
        read(fi,u,v) ;
        a := cut(root,u) ;
        b := cut(a.y,v-u+2) ;
        writeln(fo,t[b.x].x) ;
        root := Union(b.x,b.y) ;
        root := Union(a.x,root) ;
end;
procedure xuly;
var
        i: longint;
         ch:char ;
begin
        t[0].x := -vc ;
        readln(fi,m) ;
        for i := 1 to m do
         begin
                read(fi,ch) ;
                case ch of
                        'I' : xulyi ;
                        'S' : xulys ;
                        'D' : xulyd ;
                        'Q' : xulyq ;
                 end;
                readln(fi) ;
         end ;
end ;
procedure make;
var
        i,j,k,sl,n,x  :longint;
begin
        assign(fi,tfi);rewrite(fi);
        randomize ;
                  n := 100; x := 100;
                  sl := 0;
                  writeln(fi,n) ;
                  for i := 1 to n do
                   begin
                        if sl > 0 then
                         begin
                                k := random(4) ;
                                case k of
                                        0 :
                                         begin
                                          writeln(fi,'I ',random(x) - random(x),' ',random(sl+1)+1) ;
                                          inc(sl) ;
                                         end;
                                        1 : writeln(fi,'S ',random(sl) + 1,' ',random(sl) + 1) ;
                                        2 :
                                         begin
                                          writeln(fi,'D ',random(sl)+ 1) ;
                                          dec(sl);
                                         end;
                                        3 :
                                         begin
                                                j := random(sl) + 1;
                                                k := j + random(sl - j + 1);
                                                writeln(fi,'Q ',j,' ',k) ;
                                         end ;
                                end;
                         end else
                          begin
                                writeln(fi,'I ',random(x) - random(x),' ',random(sl)+1) ;
                                inc(sl ) ;
                          end;
                   end ;
        close(fi) ;
end ;
begin
        //make ;
       assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                xuly ;
        close(fi);
        close(fo) ;
end.


