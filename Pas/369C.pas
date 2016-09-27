Const   maxn = 100001;
Var     n,i,u,v,l,res     :       longint;
        head,f,mau    :       array [1..maxn] of longint;
        ke,next,w       :       array [-maxn..maxn] of longint;
        free    :       array [1..maxn] of boolean;

{************************************************************************}
procedure dfs(u,col : longint);
var j,v : longint;
        begin
            free[u] := false;
            j := head[u];
            while j <> 0 do
              begin
                  v := ke[j];
                  if free[v] then
                    begin
                        if w[j] = 1 then dfs(v,0)
                         else dfs(v,1);
                        f[u] := f[u] + f[v];
                    end;
                  j := next[j];
              end;
            if col = 1 then
              begin
                  if f[u] = 0 then
                    begin
                        f[u] := 1;
                        mau[u] := 1;
                    end;
              end;
        end;
{************************************************************************}
begin
   //  assign(input,'asd.inp'); reset(input);
   //  assign(output,'asd.out'); rewrite(output);
     readln(n);
     for i := 1 to n-1 do
       begin
           readln(u,v,l);
           ke[i] := v; next[i] := head[u]; w[i] := l; head[u] := i;
           ke[-i] := u; next[-i] := head[v]; w[-i] := l; head[v] := -i;
       end;
     fillchar(free,sizeof(free),true);
     dfs(1,0);
     for i := 1 to n do if mau[i] = 1 then inc(res);
     writeln(res);
     for i := 1 to n do if mau[i] = 1 then write(i,' ');

end.
