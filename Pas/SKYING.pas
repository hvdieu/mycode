Const   maxn = 5001;
Var     n,i,j,x,c,res,k     :       longint;
        ke,next :       array [1..1000000] of longint;
        free    :       array [1..maxn] of boolean;
        head,d    :       array [1..maxn] of longint;
        ok :    boolean;

procedure dfs(u : longint);
var j,v : longint;
        begin
            free[u] := false;
            j := head[u];
            while j <> 0 do
              begin
                  if u = 1 then ok := false;
                  v := ke[j];
                  if v = n then
                   begin
                     inc(res);
                     ok := true;
                   end
                   else if free[v] and not ok then dfs(v);
                  j := next[j];
              end;
        end;


begin
      assign(input,'SKYING.INP'); reset(input);
      assign(output,'SKYING.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n-1 do
       begin
           read(k);
           for j := 1 to k do
            begin
                read(x); inc(d[x]);
            end;
           for j := i+1 to n do if d[j] = 1 then
             begin
                 dec(d[j]); inc(c); ke[c] := j;
                 next[c] := head[i]; head[i] := c;
             end;
       end;
      fillchar(free,sizeof(free),true);
      dfs(1);
      writeln(res);
end.