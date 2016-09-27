Const   maxn = 100015;
Type    canh = record
        x,y     :       longint;
        end;
Var     n,q,dem       :       longint;
        a,head,con,num,pos,adj         :       array [0..maxn] of longint;
        free    :       array [0..maxn] of boolean;
        e       :      array [1..maxn] of canh;

procedure nhap;
var i,j,v : longint;
        begin
             assign(input,'cook.inp'); reset(input);
             assign(output,'cook1.out'); rewrite(output);
             readln(n);
             for i := 1 to n do
               begin
                   read(a[i],v);
                   with e[i] do
                    begin
                        x := v; y := i;
                        inc(head[x]);
                    end;
               end;
             for i := 1 to n do head[i] := head[i-1] + head[i];
             head[n+1] := n;
             for i := 1 to n do
               with e[i] do
                begin
                    adj[head[x]] := y; dec(head[x]);
                end;
        end;

procedure dfs(u : longint);
var i,v : longint;
        begin
            inc(dem);
            num[u] := dem;
            pos[num[u]] := u;
            for i := head[u]+1 to head[u+1] do
              begin
                  v := adj[i];
                  if free[v] then
                    begin
                        free[v] := false;
                        dfs(v);
                        con[u] := con[u] + con[v];
                    end;
              end;
        end;

procedure main;
var i,s,kind,x,dem,st,u : longint;
        begin
             fillchar(free,sizeof(free),true);
             free[0] := false;
             for i := 0 to n do con[i] := 1;
             dfs(0);
             readln(q);
             for st := 1 to q do
               begin
                   read(kind);
                   if kind = 1 then
                     begin
                        read(u,x);
                        for i := num[u]+1 to num[u]+con[u]-1 do
                          dec(a[pos[i]],x);
                     end
                   else
                     begin
                         read(u);
                         dem := 0;
                         for i := num[u]+1 to num[u]+con[u]-1 do
                           if a[pos[i]] > 0 then inc(dem);
                         writeln(dem);
                     end;
               end;
        end;

begin
     nhap;
     main;
end.
