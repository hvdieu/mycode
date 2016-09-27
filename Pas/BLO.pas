Uses math;
Const   maxn = 100001;
        maxm = 500001;

Type    canh = record
        x,y : longint;
        end;

Var     n,m,dem,top     :       longint;
        head,low,num,ncon,cha    :       array [1..maxn] of longint;
        st,f    :       array [1..maxn] of int64;
        e       :       array [1..maxm] of canh;
        khop    :       array [1..maxn] of boolean;
        adj     :       array [1..2*maxm] of longint;

procedure nhap;
var i : longint;
        begin
             assign(input,'BLO.INP'); reset(input);
             assign(output,'BLO.OUT'); rewrite(output);
             readln(n,m);
             for i := 1 to m do with e[i] do
               begin
                   read(x,y);
                   inc(head[x]); inc(head[y]);
               end;
             for i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := head[n];
             for i := 1 to m do with e[i] do
               begin
                   adj[head[x]] := y; dec(head[x]);
                   adj[head[y]] := x; dec(head[y]);
               end;
        end;

procedure dfs(u : longint);
var i,v : longint;
        begin
            inc(dem); num[u] := dem; low[u] := num[u];
            for i := head[u]+1 to head[u+1] do
              begin
                  v := adj[i];
                  if cha[v] = 0 then
                    begin
                        cha[v] := u;
                        inc(ncon[u]);
                        dfs(v);
                        low[u] := min(low[u],low[v]);
                        f[u] := f[u] + f[v];
                    end
                  else if (cha[u] <> v) and (cha[v] <> u) then
                    low[u] := min(low[u],num[v]);
              end;
        end;

procedure main;
var u,v,i : longint;
    res,sum : int64;
        begin
            for u := 1 to n do f[u] := 1;
            cha[1] := -1;
            dfs(1);
            for v := 1 to n do
              begin
                  u := cha[v];
                  if (u = -1) and (ncon[v] >= 2) then khop[v] := true
                   else if (u <> -1) and (low[v] >= num[u]) then khop[u] := true;
              end;
            for u := 1 to n do
              begin
                  res := 2*(n-1);
                  if khop[u] = false then writeln(res)
                   else
                     begin
                       top := 0; sum := 0;
                       for i := head[u]+1 to head[u+1] do
                         if (cha[adj[i]] = u) and (low[adj[i]] >= num[u]) then
                           begin
                                inc(top); st[top] := f[adj[i]];
                                sum := sum + st[top];
                           end;
                         inc(top); st[top] := n - sum - 1;
                         for i := 1 to top do res := res + st[i]*(n-st[i]-1);
                         writeln(res);
                     end;
              end;
        end;

begin
    nhap;
    main;
end.
