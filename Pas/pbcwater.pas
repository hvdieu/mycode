uses math;
Const   inp = '';
        out = '';
        maxn = 101;
        h : array [1..4] of integer = (-1,0,1,0);
        c : array [1..4] of integer = (0,1,0,-1);

Var     fi,fo   :       text;
        a,b,d       :       array [1..maxn,1..maxn] of longint;
        thoat     :       array [1..maxn*maxn] of boolean;
        free    :       array [0..maxn,0..maxn] of boolean;
        m,n,minh,maxh,dem,res    :       longint;

procedure input;
var i,j : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,m,n);
             minh := maxlongint; maxh := 0;
             for i := 1 to m do
               for j := 1 to n do
                begin
                  read(fi,a[i,j]);
                  minh := min(minh,a[i,j]);
                  maxh := max(maxh,a[i,j]);
                end;
        end;

procedure dfs(i,j : longint);
var k : longint;
        begin
             d[i,j] := dem;
             if (i = 1) or (i=m) or (j=1) or (j=n) then thoat[dem] := true;
             free[i,j] := false;
             for k := 1 to 4 do
              if (b[i+h[k],j+c[k]] = 0) and free[i+h[k],j+c[k]] then
                  dfs(i+h[k],j+c[k]);
        end;

procedure loang;
var i,j : longint;
        begin
            dem := 0;
            for i := 1 to m do
             for j := 1 to n do
              if free[i,j] and (b[i,j] = 0) then
               begin
                 inc(dem);
                 dfs(i,j);
               end;

            for i := 1 to m do
             for j := 1 to n do
              if (d[i,j] > 0) and (thoat[d[i,j]] = false) then
               begin
                 inc(res);
                 inc(a[i,j]);
               end;
        end;

procedure khoitao(cao : longint);
var i,j,k : longint;
        begin
             fillchar(free,sizeof(free),false);
             fillchar(thoat,sizeof(thoat),false);
             for i := 1 to m do
              for j := 1 to n do free[i,j] := true;
             fillchar(b,sizeof(b),0);
             for i := 1 to m do
              for j := 1 to n do
                if a[i,j] > cao then b[i,j] := 1;
        end;

procedure main;
var i,j,cao : longint;
        begin
             for cao := minh to maxh-1 do
               begin
                    khoitao(cao);
                    loang;
               end;
             writeln(fo,res);
             close(fo); close(fi);
        end;

begin
     input;
     main;
end.




