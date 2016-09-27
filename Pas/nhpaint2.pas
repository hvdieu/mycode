{$Q-,R-,S-,I-}
uses math ;
const
        tfi     =       'nhpaint.inp';
        tfo     =       'asd.out';
        Nmax    =       10001;
        vc      =       1000000000 ;
type
        arr1    =       array[0..Nmax,0..17] of integer  ;
        arr2    =       array[0..17,0..17] of longint ;
var
        fi,fo   :       text;
        n,m,res     :       longint ;
        a       :       arr1 ;
        f       :       arr2 ;
        d       :       array[0..17] of longint ;
        g       :       array[0..66000,0..16] of longint ;
procedure Nhap;
var
        i,j :longint;
        c:char ;
begin
        readln(fi,m,n) ;
        for i := 1 to m do
         begin
          for j := 1 to n do
           begin
                read(fi,c) ;
                a[i,j] := ord(c) - 48 ;
                inc(d[j],a[i,j]) ;
           end;
          readln(fi) ;
          end;
end;
procedure Init;
var
        i,j,k: longint;
begin
        for i := 1 to n do
         for j := i + 1 to n do
          begin
                f[i,j] := 0 ;
                for k := 1 to m do if a[k,i] <> a[k,j] then inc(f[i,j]) ;
                f[j,i] := f[i,j] ;
             //   writeln(i,' ',j,' ',f[i,j]) ;
             //   readln;
          end;
        for i := 1 to 1 shl n - 1 do
         for j := 1 to n do
           g[i,j] := vc ;
       for j := 1 to n do
        begin
                i := 1 shl (j - 1) ;
                g[i,j] := d[j] ;
        end;
end;
procedure xuly;
var
        i,j,k,i2: longint;
begin
        for i := 1 to 1 shl n - 1 do
         for j := 1 to n do if g[i,j] < vc then
          begin
                for k := j - 1 to j + 1 do if (k<> j)
                  and (k > 0) and (k <= n) and ((i shr (k-1)) and 1 = 0) then
                    begin
                        i2 := i + 1 shl (k - 1) ;
                        g[i2,k] := min(g[i2,k] , g[i,j] + d[k]) ;
                    end;
                for k := 1 to n do if (i shr (k - 1)) and 1 = 0 then
                  begin
                        i2 := i + 1 shl (k - 1) ;
                        g[i2,k] := min(g[i2,k], g[i,j] + f[j,k]) ;
                  end;
              //  writeln(i,' ',j,' ',g[i,j]) ;
              //  readln;
          end;
end;
procedure inkq;
var
        i: longint;
begin
        res := vc;
        for i := 1 to n do res := min(res,g[1 shl n - 1,i]) ;
        writeln(fo,res);
end;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                  Nhap;
                  init;
                  xuly;
                  inkq;
        close(fo);
        close(fi);
end.







