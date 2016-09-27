uses math ;
const
        tfi     =       'krtica.in.6';
        tfo     =       'tree.out';
        Nmax    =       300001;
type
        arr1    =       array[0..Nmax] of longint ;
var
        fi,fo   :       text;
        n,m,nho,res,u1,u2,v,cc     :       longint;
        head,f1,f2,f3,g,g1,g2,d,dd,trc,t      :       arr1 ;
        next,a:array[-Nmax..Nmax] of longint;
procedure Nhap;
var
        i,x,y :longint;
begin
        read(fi,n) ;
        for i := 1 to n - 1 do
        begin
             read(fi,x,y) ;
             a[i] := y;next[i] :=head[x];head[x] := i;
             a[-i] := x;next[-i] := head[y];head[y] := -i;
        end ;
        res := maxlongint;
end;
procedure visit(u,i:longint) ;
var
        j,k,x: longint;
begin
        j :=head[i];
        while j <> 0 do
        begin
                k := a[j];
                if k <> u then
                 begin
                        visit(i,k) ;
                        x := max(g1[k],f1[k] + f2[k]) ;
                        if x > g2[i] then
                         begin
                                if x > g1[i] then
                                 begin
                                        g2[i] := g1[i];
                                        g1[i] := x;
                                 end else g2[i] := x ;
                         end;
                        x := f1[k] + 1;
                        if x > f3[i] then
                         begin
                         if x > f1[i] then
                          begin
                                f3[i] := f2[i] ;f2[i] := f1[i] ;f1[i] := x;
                          end else
                           begin
                                if x > f2[i] then
                                 begin
                                        f3[i] := f2[i];f2[i] := x;
                                 end else f3[i] := x;
                           end ;
                         end;
                 end;
                j := next[j];
        end;
end;
function Up(u,v:longint) :boolean ;
var
x:longint;
begin
         x := max(max(u,v),(u+1) div 2+ (v + 1) div 2+1) ;
         if x < res then
          begin
                res := x;
                exit(true) ;
          end ;
         exit(false) ;
end;
procedure visit2(u,i: longint) ;
var
        j,k,x,y: longint ;
begin
        if g[i] > f3[i] then
         begin
              if g[i] > f1[i] then
               begin
                  f3[i] := f2[i];f2[i] := f1[i];f1[i] := g[i] ;
               end else
               begin
                 if g[i] > f2[i] then begin
                   f3[i] := f2[i];f2[i] := g[i];
                 end else f3[i] := g[i] ;
               end ;
         end ;
        j := head[i];
        while j <> 0 do
         begin
                k := a[j];
                if k <> u then
                 begin
                      g[k] := g[i] + 1 ;
                      if f1[k] + 1 = f1[i] then g[k] := max(g[k],f2[i] + 1)
                       else g[k] := max(g[k],f1[i] + 1) ;
                     x := t[i] ;
                     if g1[i] = max(g1[k],f1[k] + f2[k]) then x := max(x,g2[i])
                      else x := max(x,g1[i]) ;
                     if f1[i] = f1[k] + 1 then x := max(x,f2[i] + f3[i])
                      else begin
                         if f2[i] = f1[k] + 1 then x := max(x,f1[i]+f3[i])
                          else x := max(x,f1[i] + f2[i]) ;
                      end;
                     t[k] := x ;
                     y := max(g1[k],f1[k] + f2[k]) ;
                     if Up(x,y) then
                      begin
                       cc := abs(j) ;u1 := i;u2 := k ;
                      end;
                     visit2(i,k) ;
                 end ;
                j := next[j];
         end;
end;
procedure DFS(i:longint);
var
        j,k: longint;
begin
        dd[i] := nho ;
        if d[i] > res then
        begin
                res := d[i];
                v := i ;
        end;
       j := head[i];
       while j <> 0 do
       begin
        k := a[j];
        if (dd[k] < nho) and (cc <> abs(j)) then
         begin
                d[k] := d[i] + 1;
                trc[k] := i ;
                DFS(k) ;
         end;
        j := next[j];
       end;
end;
procedure inn(i: longint) ;
var
        k: longint ;
begin
        inc(nho);
        res := -1 ;
        v := 0 ;
        DFS(i) ;
        d[v] := 0 ;
        res := 0 ;
        inc(nho) ;
        trc[v] := 0 ;
        DFS(v) ;
        k := (d[v]+1) div 2 ;
        repeat
            if d[v] = k then
             begin
                write(fo,v);
                exit ;
             end;
            v := trc[v] ;
        until false;
end;
procedure xuly;
var
        i,j,k: longint;
begin
        visit(0,1) ;
        visit2(0,1) ;
        writeln(fo,res) ;
        writeln(fo,u1,' ',u2) ;
        Inn(u1) ;write(fo,' ') ;
        Inn(u2);
end ;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                   Nhap;
                   xuly;
        close(fi);
        close(fo) ;
end.







