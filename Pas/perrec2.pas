const
        tfi     =       'perrec.inp';
        tfo     =       'perrec.ou1';
        Nmax    =       2001;
type
        arr1    =       array[0..Nmax,0..Nmax] of longint ;
var
        fi,fo   :       text;
        n,m,nho     :       longint;
        a,h,next,dd       :       arr1 ;
        l,r       :       array[0..Nmax] of longint ;
        res       :       int64 ;
procedure Nhap;
var
        i,j,xo,aa,bb,yo,cc,dd :longint;
begin
        read(fi,n,m,xo,aa,bb,yo,cc,dd) ;
        for i := 1 to n do
         for j :=1 to n do a[i,j] := 1 ;
        xo := xo mod n ;
        yo := yo mod n ;
        for i := 1 to m do
         begin
              a[xo+1,yo+1] := 0 ;
              xo := (xo * aa + bb) mod n ;
              yo := (yo * cc + dd) mod n ;
         end;
        {read(fi,n ) ;
        for i := 1 to n do
         for j := 1 to n do read(fi,a[i,j]) ;
        for i := 1 to n do
         for j := 1 to n do
          begin
          write(a[i,j]) ;
          if j = n then writeln;
          end;}
end;
procedure init;
var
         i,j,k: longint;
begin
        for i := 1 to n do
         for j := 1 to n do if a[i,j] = 1 then h[i,j] := h[i-1,j] + 1
          else h[i,j] := 0 ;
        for i := 1 to n + 1 do
         begin
                next[i,n+1] := n+1;
                for j := n downto 1 do if a[i,j] = 0 then next[i,j] :=j
                 else next[i,j] := next[i,j+1] ;
         end;
end;
procedure xuly;
var
        i,j,k,u,v: longint;
begin
        for i := 1 to n do
         begin
                l[1] := 0 ;
                for j := 2 to n do
                 begin
                        k := j-1 ;
                        while (k > 0) and (h[i,k] >= h[i,j]) do k := l[k] ;
                        l[j] := k ;
                 end;
                r[n] := n + 1;
                for j := n - 1 downto 1 do
                 begin
                        k := j + 1;
                        while (k<=n) and (h[i,k] >= h[i,j]) do k := r[k] ;
                        r[j] := k;
                 end;
                 inc(nho);
                for j := 1 to n do if a[i,j] = 1 then
                 begin
                        u := l[j] + 1;
                        v := r[j] - 1;
                        if next[i+1,u] <= v then
                         begin
                                res := res + ord(dd[u,v] < nho) ;
                                dd[u,v] := nho ;
                         end;
                 end;
         end;
end ;
procedure inkq;
    var i,j : longint;
begin
            for i := 1 to n do
                begin
                    for j := 1 to n do write(fo,a[i][j]); writeln(fo);
                end;
            write(fo,res);
end;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                   Nhap;
                   init;
                   xuly;
                   inkq;
        close(fi);
        close(fo) ;
end.
















