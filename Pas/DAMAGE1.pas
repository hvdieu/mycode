Const   maxn = 3001;
        maxm = 20001;

Var     n,m,p,res   :       longint;
        free,visited  :       array [1..maxn] of boolean;
        head,cha    :       array [1..maxn] of longint;
        ke,next :       array [-maxm..maxm] of longint;

{**************************************************************************}
procedure nhap;
var i,j ,u,v : longint;
        begin
            assign(input,'DAMAGE1.INP'); reset(input);
            assign(output,'DAMAGE1.OUT'); rewrite(output);
            readln(n,m,p);
            for i := 1 to m do
              begin
                  readln(u,v);
                  ke[i] := v; next[i] := head[u]; head[u] := i;
                  ke[-i] := u; next[-i] := head[v]; head[v] := -i;
              end;
            fillchar(free,sizeof(free),true);
            for i := 1 to p do
             begin
                 read(u);
                 free[u] := false;
                 j := head[u];
                 while j <> 0 do
                   begin
                      v := ke[j];
                      free[v] := false;
                      j := next[j];
                   end;
             end;
        end;

{**************************************************************************}
procedure dfs(u : longint);
var j,v : longint;
        begin
            visited[u] := false;
            inc(res);
            j := head[u];
            while j <> 0 do
              begin
                  v := ke[j];
                  if free[v] and visited[v] then dfs(v);
                  j := next[j];
              end;
        end;
{**************************************************************************}
procedure main;
var i,j : longint;
        begin
             fillchar(visited,sizeof(visited),true);
             dfs(1);
             writeln(n-res);
        end;
{**************************************************************************}
begin
     nhap;
     main;
end.