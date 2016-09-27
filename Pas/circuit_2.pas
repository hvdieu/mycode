Uses math;
Const   maxn = 101;
        maxw = 99999999;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);
Var     m,n,dem,res,st,nheap     :       longint;
        lab       :       array [1..maxn,1..maxn] of longint;
        ke,next,w   :       array [-maxn*maxn*4..maxn*maxn*4] of longint;
        head    : array [1..maxn*maxn] of longint;
        dir     :       array [1..maxn,1..maxn,1..4] of boolean;
        d,pos,heap       :       array [1..maxn*maxn] of longint;
        free    :       array [1..maxn*maxn] of boolean;
        cx      :       array [0..maxn,0..maxn] of boolean;

procedure nhap;
var i,j,x : longint;
        begin
            assign(input,'CIRCUIT.INP'); reset(input);
            assign(output,'CIRCUIT.OUT'); rewrite(output);
            readln(m,n);
            for i := 1 to m do
             for j := 1 to n do
              begin
                  read(x);
                  if x = 1 then
                    begin
                        dir[i,j,3] := true;
                        dir[i+1,j,1] := true;
                    end;
                  if x = 2 then
                    begin
                        dir[i,j,2] := true;
                        dir[i,j+1,4] := true;
                    end;
                  if x = 3 then
                    begin
                        dir[i,j,3] := true;
                        dir[i+1,j,1] := true;
                        dir[i,j,2] := true;
                        dir[i,j+1,4] := true;
                    end;
              end;
        end;

procedure dfs(i,j : longint);
var k : longint;
        begin
            lab[i,j] := dem;
            cx[i,j] := false;
            for k := 1 to 4 do
             if dir[i,j,k] and cx[i+h[k],j+c[k]] then dfs(i+h[k],j+c[k]);
        end;

procedure khoitao;
var i,j,u,v : longint;
        begin
             for i := 1 to m do
              for j := 1 to n do cx[i,j] := true;

             for i := 1 to m do
              for j := 1 to n do
               if cx[i,j] then
                begin
                    inc(dem);
                    dfs(i,j);
                end;
             for i := 1 to m do
              for j := 1 to n do
               begin
                    u := lab[i,j];
                    if i < m then
                    begin
                       v := lab[i+1,j];
                       if u <> v then
                         begin
                           inc(st); ke[st] := v; w[st] := 1;
                           next[st] := head[u]; head[u] := st;
                           ke[-st] := u; w[-st] := 1;
                           next[-st] := head[v]; head[v] := -st;
                         end;
                    end;
                    if j < n then
                    begin
                       v := lab[i,j+1];
                       if u <> v then
                          begin
                            inc(st); ke[st] := v; next[st] := head[u];
                            w[st] := 2; head[u] := st;
                            ke[-st] := u; next[-st] := head[v];
                            w[-st] := 2; head[v] := -st;
                          end;
                    end;
               end;
            fillchar(free,sizeof(free),true);
            d[1] := 0;
            for i := 2 to dem do d[i] := maxw;
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
                  inc(nheap); heap[nheap] := i; pos[i] := nheap;
                  con := nheap;
              end;
            repeat
                  cha := con div 2;
                  if (cha=0) or (d[heap[cha]] <= d[heap[con]]) then break;
                  swap(heap[cha],heap[con]);
                  pos[heap[cha]] := cha; pos[heap[con]] := con;
                  con := cha;
            until false;
        end;

function pop : longint;
var cha,con : longint;
        begin
             pop := heap[1];
             heap[1] := heap[nheap]; pos[heap[1]] := 1; dec(nheap);
             cha := 1;
             repeat
                  con := cha*2;
                  if (con<nheap) and (d[heap[con]] > d[heap[con+1]]) then inc(con);
                  if (con>nheap) or (d[heap[cha]] <= d[heap[con]]) then break;
                  swap(heap[cha],heap[con]);
                  pos[heap[cha]] := cha; pos[heap[con]] := con;
                  cha := con;
             until false;
        end;

procedure main;
var i,j,u,v,temp,t : longint;
        begin
             upheap(1);
             repeat
                  if nheap = 0 then break;
                  u := pop;
                  res := res + d[u];
                  free[u] := false;
                  j := head[u];
                  while j <> 0 do
                    begin
                        v := ke[j];
                        if free[v] and (d[v] > w[j]) then
                          begin
                              d[v] := w[j];
                              upheap(v);
                          end;
                        j := next[j];
                    end;
             until false;
            writeln(dem-1,' ',res);
        end;


begin
     nhap;
     khoitao;
     main;
end.
