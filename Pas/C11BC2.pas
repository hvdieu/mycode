Const   inp = '';
        out = '';
        maxn = 10001;
Var     fi,fo   :       text;
        n,dem,m       :       longint;
        head,lab,x,y    :       array [1..maxn] of longint;
        free    :   array [1..maxn] of boolean;
        adj     :       array [1..2*maxn] of longint;

procedure input;
var i,j,k : longint;
        begin
             assign(fi,inp); reset(fi);
             readln(fi,n,m);
             for i := 2 to n do
               begin
                    readln(fi,j,k);
                    if (k = 1) and (i<>j) then
                      begin
                           inc(head[i]);
                           inc(head[j]); inc(dem);
                           x[dem] := i; y[dem] := j;
                      end;
               end;
             for i := 2 to n do head[i] := head[i-1] + head[i];
             for i := 1 to dem do
               begin
                    adj[head[x[i]]] := y[i]; dec(head[x[i]]);
                    adj[head[y[i]]] := x[i]; dec(head[y[i]]);
               end;
             head[n+1] := 2*dem;
        end;

procedure dfs(u : longint);
var i,v : longint;
        begin
             lab[u] := dem;
             for i := head[u] +1 to head[u+1] do
               begin
                   v := adj[i];
                   if free[v] then
                     begin
                         free[v] := false;
                         dfs(v);
                     end;
               end;
        end;

procedure main;
var i,u,v : longint;
        begin
             dem := 0;
             fillchar(free,sizeof(free),true);
             for i := 1 to n do
               if free[i] then
                 begin
                      inc(dem);
                      free[i] := false;
                      dfs(i);
                 end;
             assign(fo,out); rewrite(fo);
             for i := 1 to m do
               begin
                    readln(fi,u,v);
                    if lab[u] <> lab[v] then writeln(fo,'YES')
                      else writeln(fo,'NO');
               end;
             close(fi); close(fo);
        end;

begin
     input;
     main;
end.