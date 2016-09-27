uses math ;
const
        tfi     =       'ORGAN1.INP';
        tfo     =       'ORGAN1.OUT';
        Nmax    =       201;
        p       =       1000000000 ;
type
        arr0    =       array[0..42] of longint ;
        arr1    =       array[0..Nmax] of longint ;
var
        fi,fo   :       text;
        n,m,s,w,bmin,bmax     :       longint;
        a      :       arr1 ;
        f,g :array[0..Nmax,0..Nmax] of arr0 ;
function Add(a,b:arr0) :arr0 ;
var
        i,tmp :longint ;
        c:arr0 ;
begin
        c[0] := max(a[0],b[0]) ;
        tmp := 0;
        for i := 1 to c[0] do
         begin
           if i <= a[0] then tmp := tmp + a[i];
           if i <= b[0] then tmp := tmp + b[i];
           c[i] := tmp mod p;
           tmp := tmp div p ;
         end;
        if tmp > 0 then
        begin
                inc(c[0]) ;
                c[c[0]] := tmp ;
        end;
        exit(c) ;
end;
function mul(a:arr0;b:longint) :arr0;
var
        i :longint;
        tmp :int64 ;
begin
        tmp := 0;
        for i := 1 to a[0] do
         begin
            tmp := tmp +int64(a[i])*b ;
            a[i] := tmp mod p;
            tmp := tmp div p ;
         end;
          if tmp > 0 then
          begin
                inc(a[0]);
                a[a[0]] := tmp ;
          end;
         exit(a) ;
end;
procedure init;
var
        i,j,k: longint;
begin
        for i := 1 to 200 do
         for j := 0 to 200 do g[i,j][0] := 0 ;
        g[1][0][0] := 1;
        g[1][0][1] := 1;
        for i := 1 to 200 do
         for j := 0 to i - 1 do if g[i,j][0] > 0 then
          begin
                g[i+1,j] := add(g[i+1,j],mul(g[i,j],j+1)) ;
                g[i+1,j+1] := add(g[i+1,j+1],mul(g[i,j],i-j)) ;
          end;
       for i := 1 to 200 do
        for j := 1 to 200  do
         g[i,j] := add(g[i,j],g[i,j-1]) ;
end;
function maxx(a,b:arr0) :arr0;
var
        i:longint;
begin
        if a[0] < b[0] then exit(b) ;
        if a[0] > b[0] then exit(a) ;
        for i := a[0] downto 1 do
         begin
                if a[i] > b[i] then exit(a) ;
                if a[i] < b[i] then exit(b) ;
         end;
         exit(a) ;
end ;
Procedure ghi(c:arr0);
      Var
        i       :longint;
        s,ds    :string;
      Begin
        if (c[0]=1) and (c[1] = -1) then
          begin
              writeln(0);
              exit;
          end;
        ds:='';
        for i:=1 to c[0] do
          begin
            str(c[i],s);
            while length(s)<9 do s:='0'+s;
            ds:=s+ds;
          end;
        while ds[1]='0' do delete(ds,1,1);
        writeln(fo,ds);
      End;
procedure xuly;
var
        i,j,k: longint;
        c:arr0 ;
        ss:string ;
begin
        read(fi,n,s,w,m,bmin,bmax) ;
        for i := 1 to n do
         begin
                read(fi,a[i]) ;
                a[i] := a[i-1] + a[i];
         end;
        for i := 1 to n do
         for j := 1 to min(i,s) do f[i,j][0] := 0 ;
        f[0,0][0] := 1;
        f[0,0][1] := 0;
        for i := 0 to n - 1 do
         for j := 0 to min(i,s) do if f[i,j][0] > 0 then
          begin
               for k := i + 1 to n do if (int64(a[k]-a[i])*m>=bmin)
                and (int64(a[k]-a[i])*m<=bmax) then
                   f[k,j+1] := maxx(f[k,j+1],add(f[i,j],g[k-i,w])) ;
          end;
       // for i := 1 to n do ghi(g[i,w]);
       c:=f[n,s];
       write(fo,c[c[0]]) ;
       for i := c[0] - 1 downto 1 do
       begin
        str(c[i],ss) ;
        while length(ss) < 9 do ss := '0' + ss;
        write(fo,ss) ;
       end;
       writeln(fo) ;
end ;
procedure process;
var
        i,k:longint ;
begin
        init ;
        read(fi,k);
        for i := 1 to k do xuly;
end;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                process;
        close(fi);
        close(fo) ;
end.



