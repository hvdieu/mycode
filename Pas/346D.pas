Const   maxn = 1000001;
        maxw = 999999999;
Type    canh = record
        x,y     :       longint;
        end;
Var     n,m,s,t,nheap     :       longint;
        e       :       array [1..maxn] of canh;
        free    :       array [1..maxn] of boolean;
        head,adj,d,bac,pos,heap      :       array [1..maxn] of longint;

procedure nhap;
var i,j : longint;
        begin
            assign(input,'asd.inp'); reset(input);
            assign(output,'asd.out'); rewrite(output);
            readln(n,m);
            for i := 1 to m do with e[i] do
              begin
                  readln(x,y);
                  inc(head[x]); inc(bac[x]);
              end;
            for i := 2 to n do head[i] := head[i-1] + head[i];
            head[n+1] := head[n];
            for i := 1 to m do with e[i] do
              begin
                  adj[head[x]] := y; dec(head[x]);
              end;
            read(s,t);
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure upheap(i : longint);
var cha,con : longint;
        begin
            con := pos[i];
            if con = 0 then
             begin
                 inc(nheap); heap[nheap] := i;
                 pos[i] := nheap; con := nheap;
             end;

            repeat
                 cha := con div 2;
                 if (cha = 0) or (d[heap[cha]] <= d[heap[con]]) then break;
                 swap(heap[cha],heap[con]);
                 pos[heap[cha]] := cha; pos[heap[con]] := con;
                 con := cha;
            until false;
        end;

procedure downheap(var i : longint);
var cha,con : longint;
        begin
            cha := pos[i];
            repeat
                 con := cha*2;
                 if (con < nheap) and (d[heap[con]] > d[heap[con+1]]) then inc(con);
                 if (con > nheap) or (d[heap[cha]] <= d[heap[con]]) then break;
                 swap(heap[cha],heap[con]);
                 pos[heap[cha]] := cha; pos[heap[con]] := con;
                 cha := con;
            until false;
        end;

function pop : longint;
        begin
            pop := heap[1];
            heap[1] := heap[nheap]; pos[heap[1]] := 1;
            dec(nheap); downheap(heap[1]);
        end;

procedure main;
var u,v,i : longint;
        begin
             fillchar(free,sizeof(free),true);
             for i := 1 to n do d[i] := maxw;
             d[s] := 0;
             upheap(s);
             repeat
                  if nheap = 0 then break;
                  u := pop;
                  if u = t then break;
                  free[u] := false;
                  for i := head[u]+1 to head[u+1] do
                    begin
                        v := adj[i];
                        if free[v] then
                         begin
                            if (bac[u] = 1) and (d[v] > d[u]) then
                             begin
                                 d[v] := d[u];
                                 upheap(v);
                             end;
                            if (bac[u] > 1) and (d[v] > d[u]+1) then
                             begin
                                 d[v] := d[u]+1;
                                 upheap(v);
                             end;
                         end;
                    end;
             until false;
             if d[t] = maxw then write(-1)
              else write(d[t]);
        end;

begin
     nhap;
     main;
end.
