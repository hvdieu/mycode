Uses math;
Const   maxn = 1001;
        maxm = maxn*maxn;

Type    canh = record
        x,y : longint;
        end;

Var     n,m,res     :       longint;
        head,deg,st    :       array [1..maxn] of longint;
        e       :       array [1..maxm] of canh;
        free    :   array [1..maxn] of boolean;
        adj     :       array [1..maxm] of longint;

procedure nhap;
var i,j : longint;
        begin
            assign(input,'COMPANY.INP'); reset(input);
            assign(output,'COMPANY.OUT'); rewrite(output);
            readln(n,m);
            for i := 1 to m do with e[i] do
              begin
                  readln(x,y);
                  inc(head[y]); inc(deg[x]);
              end;
            for i := 2 to n do head[i] := head[i-1] + head[i];
            head[n+1] := head[n];
            for i := 1 to m do with e[i] do
              begin
                  adj[head[y]] := x; dec(head[y]);
              end;
        end;

procedure main;
var i,j,dem,top,u,temp,s : longint;
    ok : boolean;
        begin
            fillchar(free,sizeof(free),true);
            dem := 0;
            for i := 1 to n do if deg[i]=0 then inc(res);
            repeat
                ok := false;
                temp := 0;
                s := 0;
                for i := 1 to n do
                 if free[i] and (deg[i]=0) then inc(s);
                for i := 1 to n do
                 if free[i] and (deg[i]=0) then
                   begin
                       dem := 0;
                       for j := head[i]+1 to head[i+1] do
                          if deg[adj[j]] - 1 = 0 then inc(dem);
                       if dem >= temp then
                         begin
                             temp := dem; u := i; ok := true;
                         end;
                   end;
                if ok = false then break;
                res := max(res,s-1+temp);
                for i := head[u]+1 to head[u+1] do dec(deg[adj[i]]);
                free[u] := false;
            until false;
            write(res);
        end;

begin
     nhap;
     main;
end.

