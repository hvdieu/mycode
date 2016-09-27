Const   inp = '';
        out = '';
        maxn = 100001;
        oo = 1000000007;
Var     fi,fo   :       text;
        head,cha,x,y,c,ncon    :  array [1..maxn] of longint;
        a,b     :       array [1..maxn] of int64;
        free    :       array [1..maxn] of boolean;
        adj,w   :   array [1..maxn*2] of longint;
        n       :   longint;
        res     :   int64;


procedure input;
var i,u,v,l : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n);
             for i := 1 to n-1 do
               begin
                   readln(fi,x[i],y[i],c[i]);
                   inc(head[x[i]]); inc(head[y[i]]);
               end;
             for i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := 2*(n-1);
             for i := 1 to n-1 do
               begin
                    adj[head[x[i]]] := y[i]; w[head[x[i]]] := c[i];
                    adj[head[y[i]]] := x[i]; w[head[y[i]]] := c[i];
                    dec(head[x[i]]); dec(head[y[i]]);
               end;
        end;

procedure init;
var i : longint;
        begin
             fillchar(free,sizeof(free),true);
        end;

procedure dfs(u : longint);
var i,v : longint;
        begin
             for i := head[u]+1 to head[u+1] do
               begin
                    v := adj[i];
                    if free[v] then
                      begin
                          inc(ncon[u]);
                          free[v] := false;
                          cha[v] := u;
                          dfs(v);
                          b[u] := (b[u] + (((a[v]+1)*w[i]) mod oo * a[u]) mod oo) mod oo;
                          a[u] := (a[u] + (a[v]+1)*w[i]) mod oo;
                      end;
               end;
        end;

procedure main;
var i,u : longint;
        begin
             init;
             free[1] := false;
             dfs(1);
             for i := 1 to n do
               res := (int64(res + b[i])) mod oo;
             for i := 1 to n do
               res := (int64(res+a[i])) mod oo;
             writeln(fo,res);
             close(fi); close(fo);
        end;

begin
     input;
     main;
end.