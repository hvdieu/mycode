Uses math;
Const   maxt = 11;
        maxn = 10001;
        maxw = 999999999;

Var     a       :       array [1..maxn] of longint;
        c       :       array [1..maxt,1..maxt] of longint;
        dem,st     :       array [1..maxt] of longint;
        f       :       array [0..2048] of longint;
        t,n,i     :       longint;

function bat(x,i : longint) : longint;
        begin
            exit(x or (1 shl i));
        end;

function lay(x,i : longint) : longint;
        begin
            exit((x shr i) and 1);
        end;

procedure khoitao;
var i,j : longint;
        begin
             for i := 1 to 1 shl t - 1 do f[i] := maxw;
             f[0] := 0;
             for i := 1 to n do
               begin
                   inc(dem[a[i]]);
                   for j := 1 to t do
                     if a[i] <> j then
                      c[a[i],j] := c[a[i],j] + dem[j];
               end;
        end;

procedure bfs;
var tt,i,j,top,sum,u,v,x : longint;
        begin
             for tt := 0 to 1 shl t - 1 do
               begin
                   top := 0;
                   for i := 1 to t do
                    if lay(tt,i-1) = 0 then
                     begin
                         inc(top);
                         st[top] := i;
                     end;
                   for i := 1 to top do
                     begin
                         sum := 0;
                         u := st[i];
                         for j := 1 to top do
                           begin
                               v := st[j];
                               sum := sum + c[u,v];
                           end;
                         x := bat(tt,u-1);
                         f[x] := min(f[x],f[tt] + sum);
                     end;
               end;
             write(f[1 shl t -1]);
        end;

begin
     assign(input,'caramele.inp'); reset(input);
     assign(output,'caramele.out'); rewrite(output);
     read(n,t);
     for i := 1 to n do read(a[i]);
     khoitao;
     bfs;
end.