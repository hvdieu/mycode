Const   inp = 'JOBSET.INP';
        out = 'JOBSET.OUT';
        maxn = 501;
        maxm = 10001;

Var     n,m,res     :       longint;
        p,head,x       :       array [1..maxn] of longint;
        ke,next      :       array [1..maxm] of longint;
        free    :    array [1..maxn] of boolean;

{***************************************************************************}
procedure nhap;
var i,j,u,v : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n do read(p[i]);
            readln(m);
            for i := 1 to m do
             begin
                 readln(u,v);
                 ke[i] := v; next[i] := head[u]; head[u] := i;
             end;
        end;
{***************************************************************************}
procedure dfs(u : longint);
var j,v : longint;
        begin
            free[u] := false; j := head[u];
            while j <> 0 do
             begin
                 v := ke[j];
                 if free[v] then dfs(v);
                 j := next[j];
             end;
        end;
{***************************************************************************}
procedure xuly;
var i,j,s : longint;
        begin
            fillchar(Free,sizeof(free),true);
            for i := 1 to n do
             if (x[i]=1) and free[i] then dfs(i);
            s := 0;
            for i := 1 to n do if free[i]=false then inc(s,p[i]);
            if s > res then res := s;
        end;
{***************************************************************************}
procedure ql(i : longint);
var j : longint;
        begin
            if i > n then
             begin
                 xuly;
                 exit;
             end;
            for j := 0 to 1 do
             begin
                 x[i] := j;
                 ql(i+1);
             end;
        end;
{***************************************************************************}
procedure sub1;
var i,j : longint;
        begin
            res := -maxlongint;
            ql(1);
            writeln(res);
        end;
{***************************************************************************}
begin
     nhap;
     sub1;
end.