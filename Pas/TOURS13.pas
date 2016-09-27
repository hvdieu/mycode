{$INLINE ON}
Const   inp = '';
        out = '';
        maxn = 1001;
        maxm = 100001;
        maxw = 999999999;
Type    canh = record
        x,y,l   :       longint;
        end;
Var     fi,fo   :       text;
        head,pos,heap    :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        adj,w     :       array [1..maxm] of longint;
        e       :       array [1..maxm] of canh;
        d       :       array [1..maxn,1..maxn] of longint;
        n,m,t,nheap   :       longint;

procedure init;
var i,j : longint;
        begin
             for i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := m;
             for i := 1 to m do
               with e[i] do
                begin
                     adj[head[x]] := y; w[head[x]] := l;
                     dec(head[x]);
                end;
             for i := 1 to n do
               for j := 1 to n do
                 if i = j then d[i,j] := 0
                  else d[i,j] := maxw;

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
                  if (cha = 0) or (d[i,heap[cha]] <= d[i,heap[con]]) then break;
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
                   con := cha * 2;
                   if (con < nheap) and (d[i,heap[con]] > d[i,heap[con+1]]) then inc(con);
                   if (con > nheap) or (d[i,heap[cha]] <= d[i,heap[con]]) then break;
                   swap(heap[cha],heap[con]);
                   pos[heap[cha]] := cha; pos[heap[con]] := con;
                   cha := con;
             until false;
        end;

function pop(i : longint) : longint;
        begin
             pop := heap[1];
             heap[1] := heap[nheap];
             pos[heap[1]] := 1;
             dec(nheap);
             downheap(i,heap[1]);
        end;

procedure Dij(i : longint);
var j,u,v,x : longint;
        begin
             nheap := 1; heap[1] := i; pos[i] := 1;
             for j := 1 to n do
               begin
                   free[j] := true;
                   pos[j] := 0;
               end;
             repeat
                  if nheap = 0 then break;
                  u := pop(i);
                  free[u] := false;
                  for j := head[u]+1 to head[u+1] do
                   begin
                       v := adj[j];
                       x := d[i,u] + w[j];
                       if free[v] and (d[i,v] > x) then
                         begin
                              d[i,v] := x;
                              upheap(i,v);
                         end;
                   end;
             until false;
        end;

procedure main;
var i,j,temp,res : longint;
        begin
             for i := 1 to n do dij(i);
             for i := 1 to n do
              begin
                   res := maxw;
                   for j := 1 to n do
                    if i <> j then
                     begin
                         temp := d[i,j] + d[j,i];
                         if temp < res then res := temp;
                     end;
                   if res < maxw then writeln(fo,res)
                    else writeln(fo,-1);
              end;
        end;

procedure input;
var i   : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,t);
             while t > 0 do
               begin
                   dec(t);
                   readln(fi,n,m);
                   for i := 1 to n do head[i] := 0;
                   for i := 1 to m do
                     with e[i] do
                      begin
                           readln(fi,x,y,l);
                           inc(head[x]);
                      end;
                   init;
                   main;
               end;
             close(fi); close(fo);
        end;


begin
     input;
end.

