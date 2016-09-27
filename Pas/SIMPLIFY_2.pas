Const   maxn = 40010;
        maxm = 100010;
        maxw = 999999999;

Var     n,m,i,nheap,dem   :       longint;
        head,pos,d,heap    :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        f       :       array [1..maxn] of int64;
        ke,next,w :       array [-maxm..maxm] of longint;
        res,kq  : int64;

procedure nhap;
var i,u,v,l : longint;
        begin
             assign(input,'SIMPLIFY.INP'); reset(input);
             assign(output,'SIMPLIFY.OUT'); rewrite(output);
             readln(n,m);
             for i := 1 to m do
               begin
                  readln(u,v,l);
                  ke[i] := v; next[i] := head[u]; w[i] := l; head[u] := i;
                  ke[-i] := u; next[-i] := head[v]; w[-i] := l; head[v] := -i;
               end;
        end;

procedure khoitao;
var i : longint;
        begin
            d[1] := 0; f[1] := 1;
            for i := 2 to n do d[i] := maxw;
            fillchar(free,sizeof(free),true);
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
                  cha := con;
             until false;
        end;

procedure main;
var u,v,j,i : longint;
        begin
             upheap(1);
             repeat
                  inc(dem);
                  u := pop;
                  res := res + d[u];
                  if dem = n then
                    begin
                        kq := f[u];
                        break;
                    end;
                  free[u] := false;
                  j := head[u];
                  while j <> 0 do
                    begin
                         v := ke[j];
                         if free[v] and (d[v] > w[j]) then
                           begin
                               d[v] := w[j];
                               f[v] := f[u];
                               upheap(v);
                           end
                         else if free[v] and (d[v] = w[j]) then f[v] := f[v] + f[u];
                         j := next[j];
                    end;
             until false;
             writeln(res,' ',kq);
        end;

begin
      nhap;
      khoitao;
      main;
end.