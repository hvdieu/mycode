Const   inp = '';
        out = '';
        maxn = 201;
        maxm = 20001;

Var     head,w    :       array [1..maxn] of longint;
        ke,next,dd      :       array [-maxm..maxm] of longint;
        n,m,top,count       :       longint;

{***************************************************************************}
procedure nhap;
var i,u,v : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n,m);
            for i := 1 to n do read(w[i]);
            for i := 1 to m do
             begin
                 readln(u,v);
                 ke[i] := v; next[i] := head[u]; head[u] := i;
                 ke[-i] := u; next[-i] := head[v]; head[v] := -i;
             end;
        end;
{***************************************************************************}
procedure dfs(u : longint);
var j,v : longint;
        begin
            j := head[u];
            while j <> 0 do
             begin
                 if dd[j]=0 then
                  begin
                      dd[j] := 1; dd[-j] := 1;
                      dfs(ke[j]);
                  end;
                 j := next[j];
             end;
            write(u,' ');
        end;
{***************************************************************************}
procedure main;
var i,j,u,v : longint;
        begin
            writeln(m);
            dfs(1);
        end;
{***************************************************************************}
begin
     nhap;
     main;
end.