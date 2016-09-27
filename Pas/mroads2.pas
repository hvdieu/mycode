uses math ;
{========================================}
const
        tfi     =       'mroads.inp';
        tfo     =       'mroads.ou1';
        Nmax    =       100001;
type
        arr1    =       array[0..Nmax] of longint ;
        arr2    =       array[-Nmax..Nmax] of longint ;
var
        fi,fo   :       text;
        n,m,ki,q,dem,res     :       longint;
        xa,xb,next,a:   arr2;
        head,f,parent    :       arr1;
        kt      :       boolean ;
{========================================}
procedure Nhap;
var
        i,j,k,x,y,p,q:longint;
begin
        Read(fi,n,ki);
        for i := 1 to n - 1 do
          begin
                Read(fi,x,y,p,q);
                a[i] := y;
                next[i] := head[x];
                head[x] := i;
                a[-i] := x;
                next[-i] := head[y];
                head[y] := -i;
                xa[i] := p;
                xb[i] := q;
                xa[-i] := p;
                xb[-i] := q;
          end;
end;
{========================================}
procedure Visit(i:longint);
var
        j,k:longint;
begin
        f[i] := 0;
        j := head[i];
        while j <> 0 do
          begin
                k := a[j] ;
                if k <> parent[i] then
                 begin
                        parent[k] := i;
                        Visit(k);
                        F[i] := max(F[i],F[k] + xa[j]);
                 end;
                j := next[j];
          end;
end;
{========================================}
procedure DFS(i,x:longint);
var
        j,k,x2,t2:longint;
begin
        if kt = false then exit ;
        if (x > q) or (dem > ki) then
          begin
           kt := false ;
           exit;
          end;
        if x + f[i] <= q then exit;
        j := head[i];
        while j <> 0 do
          begin
                k := a[j];
                if parent[k] = i then
                  begin
                        if f[k] + x + xa[j] > q then
                          begin
                               t2 := min(f[k]+x+xa[j]-q,xa[j]-xb[j]);
                               dem := dem + t2;
                               DFS(k,x+xa[j]-t2);
                          end;
                  end;
                j := next[j];
          end;
end;
{========================================}
function Check(x:longint):boolean;
var
        i,j,k:longint;
begin
        kt := true;
        dem := 0;
        q := x;
        DFS(1,0);
        check := (kt and (dem<=ki));
end;
{========================================}
procedure xuly;
var
        i,j,k,l,r,mid:longint;
begin
        visit(1);
        l := 0;
        r := 1000000000 ;
        while l <= r do
          begin
                mid := (l+r) shr 1;
                if check(mid) then
                  begin
                     res := mid ;
                     r := mid - 1;
                  end else l := mid + 1;
          end;
end;
{========================================}
procedure inkq;
var
        i,j,k:longint;
begin
        write(fo,res);
end;
{========================================}
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
        Nhap;
        xuly;
        inkq;
        close(fi);
        close(fo);
end.
{========================================}


