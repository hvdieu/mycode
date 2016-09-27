Uses math;
Const   maxn = 100001;
Var     x,y,pos :       array [1..3*maxn] of longint;
        head    :       array [1..maxn] of longint;
        g       :       array [1..3,1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        h,a,cha   :       array [1..maxn] of longint;
        adj     :       array [1..2*maxn] of longint;
        n,top,dem,res       :       longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure push(u,v,i : longint);
        begin
             inc(top); pos[top] := i;
             if u < v then
                begin
                   x[top] := u; y[top] := v;
                end
             else
                begin
                    x[top] := v; y[top] := u;
                end;
        end;

procedure nhap;
var i,i1,i2,i3 : longint;
        begin
            assign(input,'wie.in'); reset(input);
            assign(output,'wie.out'); rewrite(output);
            readln(n);
            for i := 1 to n-2 do
              begin
                   read(i1,i2,i3);
                   push(i1,i2,i);
                   push(i2,i3,i);
                   push(i1,i3,i);
              end;
        end;

procedure sort(l,h : longint);
var i,j,k,k1,k2 : longint;
        begin
             if l >= h then exit;
             i := l; j := h; k := l + random(h-l+1);
             k1 := x[k]; k2 := y[k];
             repeat
                 while (x[i] < k1) or ((x[i] = k1) and (y[i] < k2)) do inc(i);
                 while (x[j] > k1) or ((x[j] = k1) and (y[j] > k2)) do dec(j);
                 if i <= j then
                   begin
                      if i < j then
                        begin
                            swap(x[i],x[j]); swap(y[i],y[j]); swap(pos[i],pos[j]);
                        end;
                      inc(i); dec(j);
                   end;
             until i > j;
             sort(l,j); sort(i,h);
        end;

procedure init;
var i,j,u,v : longint;
        begin
            sort(1,top);
            for i := 1 to top-1 do
              begin
                  if (x[i]=x[i+1]) and (y[i]=y[i+1]) then
                    begin
                        inc(head[pos[i]]); inc(head[pos[i+1]]);
                    end;
              end;
            n := n-2;
            for i := 2 to n do head[i] := head[i-1] + head[i];
            head[n+1] := head[n];
            for i := 1 to top-1 do
              begin
                  if (x[i]=x[i+1]) and (y[i]=y[i+1]) then
                    begin
                        u := pos[i]; v := pos[i+1];
                        adj[head[u]] := v; dec(head[u]);
                        adj[head[v]] := u; dec(head[v]);
                    end;
              end;
        end;

procedure dfs(u : longint);
var i,v : longint;
        begin
            free[u] := false; g[1,u] := 1;
            for i := head[u]+1 to head[u+1] do
              begin
                  v := adj[i];
                  if free[v] then
                    begin
                        cha[v] := u;
                        dfs(v);
                        a[u] := max(a[u],a[v]+1);
                        if a[v] + 1 > g[1,u] then
                          begin
                              swap(g[2,u],g[3,u]);
                              swap(g[1,u],g[2,u]);
                              g[1,u] := a[v]+1;
                          end
                        else if (a[v] + 1 <= g[1,u]) and (a[v]+1 > g[2,u]) then
                           begin
                              swap(g[2,u],g[3,u]);
                              g[2,u] := a[v]+1;
                           end
                        else if (a[v]+1 <= g[2,u]) and (a[v]+1 > g[3,u]) then
                          g[3,u] := a[v]+1;
                    end;
              end;
        end;

procedure loang(u : longint);
var i,v,u1 : longint;
        begin
            free[u] := false;
            if cha[u] <> 0 then
              begin
                  u1 := cha[u];
                  h[u] := max(h[u],h[u1]+1);
                  if a[u]+1 = g[1,u1] then h[u] := max(h[u],g[2,u1]+1)
                   else h[u] := max(h[u],g[1,u1]+1);
              end;
            for i := head[u]+1 to head[u+1] do
             if free[adj[i]] then loang(adj[i]);

        end;


procedure main;
var i,j : longint;
        begin
             init;
             fillchar(free,sizeof(free),true);
             for i := 1 to n do
               begin
                 a[i] := 1; h[i] := 1;
               end;
             dfs(1);
             fillchar(free,sizeof(free),true);
             loang(1);
             for i := 1 to n do
              begin
                 if (h[i] <> 0) and (g[1,i] <> 0) then
                 begin
                   if (g[2,i] <> 0) then
                     res := max(res,h[i]+g[1,i]+g[2,i]-2)
                   else res := max(res,h[i]+g[1,i]-1);
                 end;
                 if (g[1,i] <> 0) and (g[2,i] <> 0)then
                   begin
                   if (g[3,i] <> 0) then
                      res := max(res,g[1,i]+g[2,i]+g[3,i]-2)
                   else res := max(res,g[1,i]+g[2,i]-1);
                   end;
              end;
             write(res);
        end;

begin
     nhap;
     main;
end.
