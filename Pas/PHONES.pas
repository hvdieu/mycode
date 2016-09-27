Const   maxn = 100010;

Var     n,k,i,u,v,res,r   :       longint;
        head,deg,cha,f    :       array [1..maxn] of longint;
        ke,next :       array [-maxn..maxn] of longint;

{***************************************************************************}
procedure dfs(u : longint);
var j,v : longint;
    ok : boolean;
        begin
             j := head[u]; ok := false;
             while j <> 0 do
               begin
                   v := ke[j];
                   if cha[v] = 0 then
                     begin
                         cha[v] := u;
                         ok := true;
                         dfs(v);
                         f[u] := f[u] + f[v];
                     end;
                   j := next[j];
               end;
             if ok then
               begin
                   dec(f[u]);
                   if f[u] <> 0 then
                     begin
                         if f[u] mod 2 = 0 then
                          begin
                             if f[u] div 2 < k then
                               begin
                                  inc(res,f[u] div 2);
                                  f[u] := 0;
                               end
                             else begin
                                      inc(res,k);
                                      f[u] := 0;
                                  end;
                          end
                         else begin
                                  if f[u] div 2 < k then
                                    begin
                                        inc(res,f[u] div 2);
                                        f[u] := 1;
                                    end
                                  else begin
                                           inc(res,k);
                                           f[u] := 0;
                                       end;
                              end;
                     end;
               end;
        end;
{***************************************************************************}
procedure main;
var i,j : longint;
        begin
             for i := 1 to n do
              if deg[i] > 1 then
                begin
                    r := i;
                    break;
                end;
             cha[r] := r;
             for i := 1 to n do f[i] := 1;
             dfs(r);
             writeln(res);
        end;
{***************************************************************************}
begin
     assign(input,'PHONES.INP'); reset(input);
     assign(output,'PHONES.OUT'); rewrite(output);
     readln(n,k);
     for i := 1 to n-1 do
       begin
           read(u,v);
           ke[i] := v; next[i] := head[u]; head[u] := i;
           ke[-i] := u; next[-i] := head[v]; head[v] := -i;
           inc(deg[u]); inc(deg[v]);
       end;
     main;
end.
