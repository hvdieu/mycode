Uses math;
Const   maxn = 500001;

Type    canh = record
        x,y : longint;
        end;

Var     n,m,s,p,top,dem,count,c,id    :       longint;
        res     :       int64;
        ke,next,head,low,num,lab,st,a,q  :       array [1..maxn] of longint;
        f,g     :       array [1..maxn] of int64;
        free,game,dd    :       array [1..maxn] of boolean;
        e       :       array [1..maxn] of canh;

{***************************************************************************}
procedure nhap;
var i,u,v  :  longint;
        begin
           assign(input,'atm.inp'); reset(input);
           assign(output,'atm.out'); rewrite(output);
           readln(n,m);
           for i := 1 to m do
            begin
                read(u,v);
                e[i].x := u; e[i].y := v;
                ke[i] := v; next[i] := head[u]; head[u] := i;
            end;
           for i := 1 to n do read(a[i]);
           read(s,p);
        end;
{***************************************************************************}
procedure dfs(u : longint);
var j,v : longint;
        begin
            inc(dem); num[u] := dem; low[u] := num[u]; j := head[u];
            inc(top); st[top] := u;
            while j <> 0 do
              begin
                  v := ke[j];
                  if free[v] then
                    begin
                        if num[v] = 0 then
                          begin
                             dfs(v);
                             low[u] := min(low[u],low[v]);
                          end
                        else low[u] := min(low[u],num[v]);
                    end;
                  j := next[j];
              end;
            if low[u] = num[u] then
              begin
                  inc(count); lab[u] := count;
                  repeat
                      v := st[top]; lab[v] := count;
                      free[v] := false; dec(top);
                  until u = v;
              end;
        end;
{***************************************************************************}
procedure xaydothi;
var i,u,v : longint;
        begin
            fillchar(head,sizeof(head),0);
            for i := 1 to n do
              begin
                  u := lab[i];
                  inc(f[u],a[i]);
              end;
            for i := 1 to p do
              begin
                  read(u);
                  game[lab[u]] := true;
              end;
            n := count;
            for i := 1 to m do with e[i] do
              begin
                  u := lab[x]; v := lab[y];
                  if u <> v then
                    begin
                       inc(c);
                       ke[c] := v; next[c] := head[u]; head[u] := c;
                    end;
              end;
        end;
{***************************************************************************}
procedure loang(u : longint);
var j,v : longint;
        begin
            free[u] := false;
            j := head[u];
            while j <> 0 do
              begin
                 v := ke[j];
                 if free[v] then loang(v);
                 j := next[j];
              end;
            num[u] := id; q[id] := u; dec(id);
        end;
{***************************************************************************}
procedure sorttopo;
var u : longint;
        begin
            fillchar(free,sizeof(free),true);
            id := n;
            for u := 1 to n do if free[u] then loang(u);
        end;
{***************************************************************************}
procedure Dp;
var i,vt,u,j,v : longint;
        begin
            for i := 1 to n do
             if lab[s] = q[i] then
               begin
                   vt := i;
                   break;
               end;
            g[lab[s]] := f[lab[s]];
            dd[lab[s]] := true;
            for i := vt to n do
              begin
                  u := q[i];
                  if dd[u] then
                  begin
                    j := head[u];
                    while j <> 0 do
                      begin
                        v := ke[j];
                        dd[v] := true;
                        g[v] := max(g[v],g[u] + f[v]);
                        j := next[j];
                      end;
                  end;
              end;
            for i := vt to n do
             if game[q[i]] and dd[q[i]] and (g[q[i]] > res) then res := g[q[i]];

        end;
{***************************************************************************}
procedure main;
var i,j,u,v,vt : longint;
        begin
            fillchar(free,sizeof(free),true);
            for u := 1 to n do
             if num[u] = 0 then
             begin
                top := 0;
                dfs(u);
             end;
            xaydothi;
            sorttopo;
            Dp;
            writeln(res);
        end;
{***************************************************************************}
begin
     nhap;
     main;
end.
