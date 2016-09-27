Const   inp = 'trgtree.inp';
        out = 'trgtree.out';
        maxn = 50001;

Type    canh = record
        x,y : longint;
        end;

Var     fi,fo   :       text;
        head,num,thoat,d    :       array [1..maxn] of longint;
        prime   :       array [1..maxn] of byte;
        f       :       array [1..maxn,0..20] of longint;
        adj     :       array [1..2*maxn] of longint;
        e       :       array [1..maxn] of canh;
        n,dem1,dem2,dem,res,vmax       :       longint;

procedure input;
var i : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n);
             for i := 1 to n-1 do
              with e[i] do
               begin
                    readln(fi,x,y);
                    inc(head[x]); inc(head[y]);
               end;
             for i := 2 to n do head[i] := head[i] + head[i-1];
             head[n+1] := 2*(n-1);
             for i := 1 to n-1 do
              with e[i] do
               begin
                    adj[head[x]] := y; dec(head[x]);
                    adj[head[y]] := x; dec(head[y]);
               end;
        end;

procedure dfs(u : longint);
var i,v : longint;
        begin
              inc(dem1); num[u] := dem1;
              for i := 1 to vmax do
               f[u,i] := f[f[u,i-1],i-1];
              for i := head[u]+1 to head[u+1] do
                begin
                     v := adj[i];
                     if num[v] = 0 then
                      begin
                           inc(dem);
                           d[v] := dem;
                           f[v,0] := u;
                           dfs(v);
                           dec(dem);
                      end;
                end;
              inc(dem2); thoat[u] := dem2;
        end;

function check(u,v : longint) : boolean;
        begin
              if (num[u] <= num[v]) and (thoat[u] >= thoat[v]) then exit(true)
                else exit(false);
        end;

function lca(u,v : longint) : longint;
var i  : longint;
        begin
             if check(u,v) then exit(u);
             if check(v,u) then exit(v);
             for i := vmax downto 0 do
              if check(f[u,i],v) = false then u := f[u,i];
             exit(f[u,0]);
        end;

procedure sangnt;
var i,j : longint;
        begin
             fillchar(prime,sizeof(prime),0);
             prime[1] := 1;
             for i := 2 to trunc(sqrt(n)) do
              if prime[i] = 0 then
               begin
                    j := i*i;
                    while j <= n do
                     begin
                          prime[j] := 1;
                          j := j + i;
                     end;
               end;
        end;

procedure main;
var i,j,r,t : longint;
        begin
             vmax := round(ln(n) / ln(2)) + 1;
             f[1,0] := 1;
             dem1 := 0; dem2 := 0; dem := 0;
             dfs(1);
             sangnt;
             for i := 2 to n do
               for j := 1 to i-1 do
                begin
                    r := lca(i,j);
                    t := d[i] + d[j] - 2*d[r];
                    if prime[t] = 0 then inc(res);
                end;
             writeln(fo,res);
             close(fi); close(fo);
        end;

begin
     input;
     main;
end.







