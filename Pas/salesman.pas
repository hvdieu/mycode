Const   inp = 'salesman.inp';
        out = 'salesman.out';
        maxn = 30001;

Var     fi,fo   :       text;
        head,num,thoat,cha,d    :       array [1..maxn] of longint;
        f       :       array [1..maxn,0..18] of longint;
        adj     :       array [1..2*maxn] of longint;
        n,m,dem1,dem2,vmax,dem     :       longint;
        res     :       int64;

procedure input;
var i,u,v : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n);
             for i := 1 to n-1 do
               begin
                   readln(fi,u,v);
                   inc(head[u]); inc(head[v]);
               end;
             close(fi);
             assign(fi,inp); reset(fi);
             readln(fi,n);
             for i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := 2*(n-1);
             for i := 1 to n-1 do
               begin
                    readln(fi,u,v);
                    adj[head[u]] := v; dec(head[u]);
                    adj[head[v]] := u; dec(head[v]);
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
                        cha[v] := u;
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
var i,j : longint;
        begin
             if check(u,v) then exit(u);
             if check(v,u) then exit(v);
             for i := vmax downto 0 do
              if check(f[u,i],v) = false then u := f[u,i];
             exit(cha[u]);
        end;

procedure main;
var i,j,u,v,r : longint;
        begin
             vmax := round(ln(n)/ln(2)) + 1;
             cha[1] := 1; f[1,0] := 1;
             dem1 := 0; dem2 := 0;
             dfs(1);
             readln(fi,m);
             readln(fi,u);
             for i := 2 to m do
               begin
                   readln(fi,v);
                   r := lca(u,v);
                   res := res + d[u] + d[v] - 2*d[r];
                   u := v;
               end;
             writeln(fo,res);
             close(fi); close(fo);
        end;

begin
     input;
     main;
end.
