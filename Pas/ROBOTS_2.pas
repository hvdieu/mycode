Uses math;
Const   maxn = 100005;
        maxw = 99999999;

Type    canh = record
        x,y,l : longint;
        end;

Var     n,m,nheap,s,t,dem,res     :       longint;
        head,heap,pos,low,num,cha    :       array [1..maxn] of longint;
        e       :       array [1..maxn] of canh;
        free    :       array [1..maxn] of boolean;
        adj,w     :       array [1..2*maxn] of longint;
        d       :       array [1..2,1..maxn] of longint;

procedure nhap;
var i,j : longint;
        begin
             assign(input,'ROBOTS.INP'); reset(input);
             assign(output,'ROBOTS.OUT'); rewrite(output);
             readln(n,m);
             For i := 1 to m do with e[i] do
               begin
                   readln(x,y,l);
                   inc(head[x]); inc(head[y]);
               end;
             For i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := head[n];
             For i := 1 to m do with e[i] do
               begin
                   adj[head[x]] := y; w[head[x]] := l;
                   adj[head[y]] := x; w[head[y]] := l;
                   dec(head[x]); dec(head[y]);
               end;
             readln(s,t);
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure upheap(i,j : longint);
var cha,con : longint;
        begin
            con := pos[j];
            if con = 0 then
              begin
                  inc(nheap); heap[nheap] := j;
                  pos[j] := nheap; con := nheap;
              end;

            repeat
                cha := con div 2;
                if (cha=0) or (d[i,heap[cha]] <= d[i,heap[con]]) then break;
                swap(heap[cha],heap[con]);
                pos[heap[cha]] := cha; pos[heap[con]] := con;
                con := cha;
            until false;
        end;

procedure downheap(i,j : longint);
var cha,con : longint;
        begin
            cha := pos[j];
            repeat
               con := cha*2;
               if (con < nheap) and (d[i,heap[con]] > d[i,heap[con+1]]) then inc(con);
               if (con > nheap) or (d[i,heap[cha]] <= d[i,heap[con]]) then break;
               swap(heap[cha],heap[con]);
               pos[heap[cha]] := cha; pos[heap[con]] := con;
               cha := con;
            until false;
        end;

function pop(k : longint) : longint;
        begin
            pop := heap[1]; heap[1] := heap[nheap]; pos[heap[1]] := 1;
            dec(nheap); downheap(k,heap[1]);
        end;

procedure Dij(k,s : longint);
var i,j,u,v : longint;
        begin
            fillchar(free,sizeof(free),true);
            fillchar(pos,sizeof(pos),0); nheap := 0;
            for i := 1 to n do d[k,i] := maxw;
            d[k,s] := 0;
            upheap(k,s);
            repeat
                if nheap = 0 then break;
                u := pop(k);
                free[u] := false;
                for i := head[u]+1 to head[u+1] do
                  begin
                      v := adj[i];
                      if free[v] and (d[k,v] > d[k,u] + w[i]) then
                       begin
                           d[k,v] := d[k,u] + w[i];
                           upheap(k,v);
                       end;
                  end;
            until false;
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
                        dfs(v);
                        low[u] := min(low[u],low[v]);
                    end
                  else if (cha[v] <> u) and (cha[u] <> v) then
                   low[u] := min(low[u],num[v]);
              end;
        end;

procedure main;
var i,j,u,v : longint;
        begin
             Dij(1,s);
             Dij(2,t);
             cha[1] := -1;
             dem := 0;
             dfs(1);
             res := maxw;
             for v := 1 to n do
               begin
                   u := cha[v];
                   if (u <> -1) and (low[v] >= num[v]) then
                     begin
                          res := min(res,max(d[1,u],d[2,v]));
                          res := min(res,max(d[1,v],d[2,u]));
                     end;
               end;
             write(res);
        end;

begin
     nhap;
     main;
end.
