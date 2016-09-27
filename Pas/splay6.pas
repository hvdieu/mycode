{$INLINE ON}
uses math ;
type
    nodeit = record
           ssin ,scos :extended;
           end;
    node  = record
            pa,l,r,nho,con,nho2 :longint;
            si,co,ssi,sco:array[1..11] of extended ;
            x:extended ;
          end ;
var
 xx:extended;
 n,m,root,p:longint ;
 xi,goc:array[0..50100] of extended;
 t:array[0..50100] of node ;
{===================================================================}
procedure doicho2(var x,y: longint);
var tg: longint;
 begin
        tg := x;x := y;y := tg;
 end;
procedure Cnt(x,y,ok :longint); inline ;
begin
     t[y].pa := x;
     if ok = 1 then t[x].l := y else t[x].r := y ;
end;
procedure cc(i:longint) ; inline ;
var j: longint ;
begin
     t[i].con := t[t[i].l].con + t[t[i].r].con + 1;
    { t[i].si := t[t[i].l].si + t[t[i].r].si + sin(t[i].go) ;
     t[i].co := t[t[i].l].co + t[t[i].r].co + cos(t[i].go) ;}
     For j := 1 to p do
         begin
             t[i].si[j] := t[t[i].l].si[j] + t[t[i].r].si[j] + t[i].ssi[j] ;
             t[i].co[j] := t[t[i].l].co[j] + t[t[i].r].co[j] + t[i].sco[j] ;
         end ;
end;
procedure Ups(i:longint) ; inline ;
begin
     while i <> 0 do
      begin
          cc(i) ;
          i := t[i].pa;
      end;
end;
procedure UPtree(i:longint);inline ;
var p,pp  : longint;
 begin
      p := t[i].pa;
      pp := t[p].pa ;
      if (t[p].l = i) then
              begin
                    cnt(p,t[i].r,1) ;
                    cnt(i,p,2) ;
              end else
              begin
                    cnt(p,t[i].l,2) ;
                    cnt(i,p,1) ;
              end;
        cc(p) ;
        cc(i) ;
        if pp <> 0 then
                 begin
                      if t[pp].l = p then cnt(pp,i,1) else cnt(pp,i,2) ;
                 end else t[i].pa := 0 ;
 end;
procedure splay(i:longint);
var p,pp : longint;
 begin
      while t[i].pa <> 0 do
       begin
            p := t[i].pa;
            pp := t[p].pa ;
            if pp <> 0 then
                      begin
                           if (t[pp].l = p) = (t[p].l = i) then
                           uptree(p) else uptree(i) ;
                      end;
            uptree(i) ;
       end;
 end;
procedure dondl(i: longint) ; inline ;
begin
     doicho2(t[i].l,t[i].r) ;
     t[t[i].l].nho := 1-t[t[i].l].nho ;
     t[t[i].r].nho := 1-t[t[i].r].nho ;
     t[i].nho := 0 ;
end;
procedure CN(i: longint;x:extended); inline ;
var j: longint;
 xx:extended ;
begin
     if i = 0 then exit;
     xx := x ;
     if t[i].nho2 = 0 then t[i].x := 1;
     t[i].nho2 := 1 ;
     t[i].x := t[i].x * x;
     t[i].si[1] := t[i].si[1] * x;
     t[i].ssi[1] := t[i].ssi[1] * x;
     for j := 2 to p do
         begin
                xx := xx * x ;
                t[i].si[j] := t[i].si[j] * xx * x ;
                t[i].co[j] := t[i].co[j] * xx ;
                t[i].ssi[j] := t[i].ssi[j] * xx * x ;
                t[i].sco[j] := t[i].sco[j] * xx ;
                xx := xx * x ;
         end;
end;
procedure Dondlx(i :longint);
begin
       t[i].nho2 := 0;
       CN(t[i].l,t[i].x) ;
       CN(t[i].r,t[i].x) ;
end;
function Find(i,x:longint) :longint ;
begin
     repeat
           if t[i].nho = 1 then dondl(i) ;
           if t[i].nho2 = 1 then dondlx(i) ;
           if t[t[i].l].con + 1 = x then
             exit(i) ;
           if t[t[i].l].con >= x then
               i := t[i].l else
                begin
                  x := x - 1 - t[t[i].l].con ;
                  i := t[i].r ;
                end;
     until false;
end;
procedure Modify(i:longint;x:extended);
var j:longint ;
begin
        i := find(root,i) ;
       // t[u].go := x ;
        t[i].ssi[1] := x ;
        t[i].sco[1] := 1;
        for j := 2 to p do
             begin
                  t[i].ssi[j] := t[i].ssi[j-1] * x*x/((2*j-2)*(2*j-1)) ;
                  t[i].sco[j] := t[i].sco[j-1] * x*x/((2*j-3)*(2*j-2)) ;
             end ;
        Ups(i) ;
        splay(i) ;
        root := i ;
end;
procedure Cuttree(root,u:longint;var  t1,t2 :longint);
begin
    if u = t[root].con + 1 then
         begin
              t1 := root;
              t2 := 0;
              exit ;
         end ;
    t2 := find(root,u) ;
    splay(t2) ;
    t1 := t[t2].l ;
    t[t1].pa := 0;t[t2].l := 0 ;
    cc(t2) ;
end;
procedure Union(t1,t2:longint;var root:longint );
begin
     if t2 = 0 then
          begin
               root := t1 ;
               exit ;
          end  ;
     repeat
           if t[t2].nho = 1 then dondl(t2) ;
           if t[t2].nho2 = 1 then dondlx(t2) ;
           if t[t2].l = 0 then break ;
           t2 := t[t2].l ;
     until false;
      cnt(t2,t1,1) ;
      UPS(t2) ;
      Splay(t2) ;
      root := t2 ;
end ;
function Get(u,v,ok:longint):nodeit ;
var t1,t2,t3,j,k: longint;
  c:nodeit ;
 begin
        Cuttree(root,u,t1,t2) ;
        Cuttree(t2,v-u+2,t2,t3) ;
        c.ssin := 0;
        c.scos := 0;
        for j := 1 to p do
        begin
          if j mod 2 = 1 then k := 1 else k := -1;
          c.ssin := c.ssin + T[t2].si[j]*k ;
          c.scos := c.scos + T[t2].co[j]*k ;
        end ;
        if ok = 1 then
                 t[t2].nho := 1 - t[t2].nho ;
        if ok = 2 then
                     CN(t2,xx) ;
        Union(t2,t3,root) ;
        Union(t1,root,root) ;
        exit(c) ;
 end;
function Inn2(l,r:longint):longint ;
var mid,x1,x2,j:longint;
begin
     if l > r then exit(0) ;
     x1  := 0 ;x2 := 0;
     mid := (l + r) shr 1;
     if l < r then
     begin
        x1 := Inn2(l,mid-1) ;
        x2 := Inn2(mid+1,r) ;
     end;
     t[mid].ssi[1] := goc[mid] ;
     t[mid].sco[1] := 1;
     for j := 2 to p do
       begin
            t[mid].ssi[j] := t[mid].ssi[j-1] * goc[mid]*goc[mid]/((2*j-2)*(2*j-1)) ;
            t[mid].sco[j] := t[mid].sco[j-1] * goc[mid]*goc[mid]/((2*j-3)*(2*j-2)) ;
       end ;
     CNt(mid,x1,1) ;
     CNt(mid,x2,2) ;
     CC(mid) ;
     exit(mid) ;
end;
{===================================================================}
procedure process;
var
   i,u,v:longint;
   x,sum:extended ;
   s:string;
   ch:char;
   c:nodeit ;
begin
     readln(n) ;
     for i := 1 to n do read(goc[i]) ;
     readln ;
     readln(m);
     p := 10;
     root := Inn2(1,n) ;
     for i := 1 to m do
      begin
           s := '';
           read(ch) ;
           while ch <> ' ' do
            begin
                   s := s + ch;
                   read(ch) ;
            end;
            case s[1] of
                  'M' : begin
                        if s[2] = 'o' then
                            begin
                                 read(u,x) ;
                                 Modify(u,x) ;
                            end else
                             begin
                                  read(u,v,x) ;
                                  xx := x ;
                                  c := get(u,v,2) ;
                             end;
                  end;
                  'S': begin
                       read(u,v,x) ;
                       c :=Get(u,v,0) ;
                       sum := c.ssin * cos(x) - c.scos * sin(x) ;
                       writeln(sum:0:9) ;
                   end;
                  'C' : begin
                       read(u,v,x) ;
                       c := Get(u,v,0) ;
                       sum := c.scos * cos(x) + c.ssin * sin(x) ;
                       writeln(sum:0:9) ;
                  end;
                  'R' : begin
                       read(u,v) ;
                       c := get(u,v,1) ;
                  end;
             end;
            readln ;
      end;
end ;
begin
  assign(input,'vmsincos.inp') ; reset(input);
  assign(output,'vmsincos.ou1') ;rewrite(output) ; {spoj.out}
  process ;
end.





























































