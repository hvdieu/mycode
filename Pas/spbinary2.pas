//{$Q-,R-,S-,I-}
{$INLINE OFF}
{$h+}
uses math ;
const
        tfi     =       'spbinary.inp';
        tfo     =       'spbinary.ou1';
        vc      =       1000000000 ;
type
       arr0    =      array[1..40] of longint ;
        node    =       record
                x : arr0 ;
                len : longint ;
               end ;
        arr1    =       array[0..1,0..610] of node ;
        arr2    =       array[0..190] of longint ;
var

        fi,fo   :       text;
        F       :       arr1;
        n,m     :       longint;
procedure nhap;
begin
        assign(fi,tfi);reset(fi);
               read(fi,n,m);
        close(fi);
end;
procedure Init;
var
        i,j,k:longint;
begin
        f[1,1].len := 1;
        f[1,1].x[1] := 2;
end;
procedure Add(var x:node; y: node ) ;
var
        i,j: longint ;
        nho : longint  ;
begin
        nho := 0;
        For i := 1 to max(x.len,y.len) do
          begin
               if x.len >= i then nho := nho + x.x[i] ;
               if y.len >= i then nho := nho + y.x[i] ;
               x.x[i] := nho mod vc ;
               nho := nho div vc ;
          end;
       x.len := max(x.len,y.len) ;
       if nho <> 0 then
        begin
                inc(x.len);
                x.x[x.len] := nho ;
        end;
end;
procedure xuly;
var
        i,j,k,i1,i2:longint;
begin
        init;
        for i := 1 to n do
         begin
               i1 := i mod 2 ;
               i2 := 1 - i1 ;
               for j := 1 to m do f[i2,j].len := 0 ;
               for j := 1 to m do
                 begin
                        if j < m then add(f[i2,j+1],f[i1,j]) ;
                        add(f[i2,1],f[i1,j]) ;
                 end ;
         end;
end ;
procedure inkq;
var
        i:longint;
        ss :string ;
        s: node ;
begin
        assign(fo,tfo);rewrite(fo);
            s.len := 0;
            n := n mod 2 ;
            for i := 1 to m do add(s,f[n,i]) ;
            write(fo,s.x[s.len]) ;
            for i := s.len - 1 downto 1 do
             begin
                str(s.x[i],ss) ;
                while length(ss) < 9 do ss := '0' + ss;
                write(fo,ss);
             end;
        close(fo);
end;
begin
        nhap;
        xuly;
        inkq;
end.










