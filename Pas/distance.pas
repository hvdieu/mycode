Const   maxn = 100001;
        maxw = 999999999;

Type    canh = record
        x,y,l : longint;
        end;
Var     n,m,k,i,nheap,res :       longint;
        head,p,d,pos,heap    :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        adj,w     :       array [1..2*maxn] of longint;
        e       :       array [1..maxn] of canh;

procedure swap(Var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure nhap;
var i,j : longint;
        begin
            assign(input,'distance.inp'); reset(input);
            assign(output,'distance.out'); rewrite(output);
            readln(k,n,m);
            for i := 1 to k do read(p[i]);
            for i := 1 to m do with e[i] do
              begin
                  readln(x,y,l);
                  inc(head[x]); inc(head[y]);
              end;
            for i := 2 to n do head[i] := head[i-1] + head[i];
            head[n+1] := head[n];
            for i := 1 to m do with e[i] do
              begin
                  adj[head[x]] := y; w[head[x]] := l; dec(head[x]);
                  adj[head[y]] := x; w[head[y]] := l; dec(head[y]);
              end;
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
                 if (cha=0) or (d[heap[cha]] <= d[heap[con]]) then break;
                 swap(heap[cha],heap[con]);
                 pos[heap[cha]] := cha; pos[heap[con]] := con;
                 con := cha;
            until false;
        end;

procedure downheap(i : longint);
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

procedure main;
var i,j,u,v : longint;
        begin
            fillchar(free,sizeof(free),true);
            res := maxw;
            for i := 1 to n do d[i] := maxw;
            for i := 1 to k do
             if pos[p[i]] = 0 then
              begin
               upheap(p[i]);
               d[p[i]] := 0;
              end
              else
               begin
                 res := 0;
                 exit;
               end;

            repeat
                 if nheap = 0 then break;
                 u := heap[1]; heap[1] := heap[nheap]; pos[heap[1]] := 1;
                 dec(nheap); downheap(heap[1]);
                 free[u] := false;
                 for i := head[u]+1 to head[u+1] do
                   begin
                       v := adj[i];
                       if free[v] and (d[v] > d[u] + w[i]) then
                         begin
                             d[v] := d[u] + w[i];
                             upheap(v);
                         end
                       else if free[v] = false then
                         begin
                             if (d[u]+d[v]+w[i])*3 < res then res := (d[u]+d[v]+w[i])*3;
                         end;
                   end;
            until false;
        end;

begin
     nhap;
     main;
     write(res);
end.