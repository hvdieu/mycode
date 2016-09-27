Uses math;
Const   maxn = 10001;
        maxm = 1000001;
Type    canh = record
        x,y     :       longint;
        end;
Var     e,st       :       array [1..maxm] of canh;
        n,m,top,dem,count,p,q,res,kq     :       longint;
        khop    :       array [1..maxn] of boolean;
        head,low,num,cha,ncon    :       array [1..maxn] of longint;
        adj     :       array [1..2*maxm] of longint;

procedure nhap;
var i,j : longint;
        begin
            assign(input,'globalnet.inp'); reset(input);
            assign(output,'globalnet.out'); rewrite(output);
            readln(n,m);
            for i := 1 to m do with e[i] do
              begin
                  readln(x,y);
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

procedure push(u,v : longint);
        begin
            inc(top);
            with st[top] do
              begin
                   x := u; y := v;
              end;
        end;

procedure pop(var p,q : longint);
        begin
             p := st[top].x; q := st[top].y;
             dec(top);
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
                        push(u,v);
                        dfs(v);
                        low[u] := min(low[u],low[v]);
                        if low[v] >= num[u] then
                          begin
                             count := 0;
                             repeat
                                pop(p,q);
                                inc(count);
                             until p = u;
                             inc(count);
                             if count > res then res := count;
                          end;
                    end
                  else if (cha[u] <> v) and (cha[v] <> u) then
                   low[u] := min(low[u],num[v]);
              end;
        end;

procedure main;
var i,j,u,v,pre : longint;
        begin
             for u := 1 to n do if cha[u] = 0 then
               begin
                   pre := dem;
                   cha[u] := -1;
                   dfs(u);
                   if pre+1 = dem then if 1 > res then res := 1;
               end;
             for v := 1 to n do
                     begin
                         u := cha[v];
                         if ((u = -1) and (ncon[v] >= 2)) then khop[v] := true
                          else if (u <> -1) and (cha[u] <> -1) and (low[v] >= num[u]) then khop[u] := true;
                     end;
                   for u := 1 to n do if khop[u] then inc(kq);
                   writeln(kq,' ',res);
                   for u := 1 to n do if khop[u] then writeln(u);
        end;

begin
     nhap;
     main;
end.

