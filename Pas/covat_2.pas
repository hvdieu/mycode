Const   maxn = 101;
        maxw = 99999999;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);
Var     m,n,i,j,top,res,left,right,nheap,dem     :       longint;
        a       :       array [1..maxn,1..maxn] of char;
        w,vt       :       array [1..maxn,1..maxn] of longint;
        qx,qy,kc,pos,heap   :       array [1..maxn*maxn] of longint;
        free    :       array [0..maxn,0..maxn] of boolean;
        dd      :       array [1..maxn] of boolean;
        x,y,d     :       array [1..maxn] of longint;

procedure bfs(u : longint);
var i,j,k : longint;
        begin
             left := 0; right := 1;
             qx[1] := x[u]; qy[1] := y[u];
             fillchar(free,sizeof(free),false);
             for i := 1 to m do
              for j := 1 to n do
               free[i,j] := true;
             free[x[u],y[u]] := false;
             kc[1] := 0;
             while left < right do
               begin
                   inc(left); i := qx[left]; j := qy[left];
                   for k := 1 to 4 do
                    if free[i+h[k],j+c[k]] and (a[i+h[k],j+c[k]] <> '#') then
                      begin
                           free[i+h[k],j+c[k]] := false;
                           inc(right);
                           qx[right] := i+h[k]; qy[right] := j+c[k];
                           kc[right] := kc[left]+1;
                           if (a[i+h[k],j+c[k]] = 'C') or (a[i+h[k],j+c[k]] = 'S') then
                             w[u,vt[i+h[k],j+c[k]]] := kc[right];
                      end;
               end;
        end;

procedure khoitao;
var i : longint;
        begin
            d[1] := 0;
            for i := 2 to n do d[i] := maxw;
            fillchar(dd,sizeof(dd),true);
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
var i,j,u,v : longint;
        begin
             for i := 1 to top do
              for j := 1 to top do
                begin
                  w[i,j] := maxw;
                  if i = j then w[i,j] := 0;
                end;
             for i := 1 to top do bfs(i);
             n := top;
             khoitao;
             upheap(1);
             repeat
                  inc(dem);
                  u := pop;
                  res := res + d[u];
                  if dem = n then break;
                  dd[u] := false;
                  for v := 1 to n do
                    if dd[v] and (d[v] > w[u,v]) then
                      begin
                        d[v] := w[u,v];
                        upheap(v);
                      end;
             until false;
             writeln(res);
        end;

begin
      assign(input,'COVAT.INP'); reset(input);
      assign(output,'COVAT.OUT'); rewrite(output);
      readln(m,n); top := 1;
      for i := 1 to m do
        begin
            for j := 1 to n do
             begin
               read(a[i,j]);
               if a[i,j] = 'S' then
                 begin
                     vt[i,j] := 1;
                     x[1] := i; y[1] := j;
                 end;
               if a[i,j] = 'C' then
                 begin
                     inc(top); x[top] := i; y[top] := j;
                     vt[i,j] := top;
                 end;
             end;
            readln;
        end;
      main;
end.
