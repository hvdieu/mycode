Const   maxn = 2001001;
        maxm = 501;
        maxw = 999999999;

Var     n,m,l,sc,top,res,nheap     :       longint;
        c       :       array [1..4] of longint;
        head,d,pos,heap    :       array [1..maxn] of longint;
        ke,next :       array [-2001..2001] of longint;
        free    :       array [1..maxn] of boolean;
        st      :       array [1..1001] of longint;
        k       :       array [1..501,1..1001] of longint;
        sl      :       array [1..501] of longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := st[l+random(h-l+1)];
            repeat
                while st[i] < k do inc(i);
                while st[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then swap(st[i],st[j]);
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

procedure upheap(i : longint);
var cha,con : longint;
        begin
             con := pos[i];
             if con = 0 then
               begin
                    inc(nheap); heap[nheap] := i; con := nheap;
                    pos[i] := nheap;
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
               if (con < nheap) and (d[heap[con]] > d[heap[con+1]]) then inc(con);
               if (con > nheap) or (d[heap[cha]] <= d[heap[con]]) then break;
               swap(heap[cha],heap[con]);
               pos[heap[cha]] := cha; pos[heap[con]] := con;
               cha := con;
             until false;
        end;

function find(key : longint) : longint;
var d,c,mid,ans : longint;
        begin
             d := 1; c := top;
             while d <= c do
               begin
                   mid := (d+c) div 2;
                   if st[mid] = key then
                     begin
                         ans := mid;
                         c := mid-1;
                     end
                   else if st[mid] > key then c := mid-1
                    else d := mid+1;
               end;
             exit(ans);
        end;

procedure nhap;
var i,j,t : longint;
        begin
             assign(input,'LIFT.INP'); reset(input);
             assign(output,'LIFT.OUT'); rewrite(output);
             read(n);
             for i := 1 to 4 do read(c[i]);
             read(l);
             for i := 1 to l do
               begin
                   read(sl[i]);
                   for j := 1 to sl[i] do
                     begin
                         read(k[i,j]);
                         if k[i,j] > 2*n then
                           begin
                               inc(top); st[top] := k[i,j];
                           end;
                     end;
               end;
        end;

procedure khoitao;
var i,j,t,u,v : longint;
        begin
             sort(1,top);
             for i := 1 to l do
               for j := 1 to sl[i] do
                 if k[i,j] > 2*n then k[i,j] := 2*n+find(k[i,j]);

             for i := 1 to l do
               begin
                    for j := 1 to sl[i] do
                      for t := 1 to j-1 do
                       begin
                         u := k[i,j]; v := k[i,t];
                         inc(m); ke[m] := v; next[m] := head[u]; head[u] := m;
                         ke[-m] := u; next[-m] := head[v]; head[v] := -m;
                       end;
               end;
             for i := 2 to 2*n+1000 do d[i] := maxw;
             fillchar(free,sizeof(free),true);
             d[1] := 0; upheap(1);
        end;

procedure main;
var i,j,u,v : longint;
        begin
             repeat
                 u := pop;
                 free[u] := false;
                 if u = n then
                   begin
                       res := d[u];
                       break;
                   end;
                 j := head[u];
                 while j <> 0 do
                   begin
                      v := ke[j];
                      if free[v] and (d[v] > d[u] + c[3] + c[4]) then
                        begin
                            d[v] := d[u] + c[3] + c[4];
                            upheap(v);
                        end;
                      j := next[j];
                   end;
                 if (u < 2*n) and free[u+1] and (d[u+1] > d[u] + c[1]) then
                   begin
                     d[u+1] := d[u] + c[1];
                     upheap(u+1);
                   end;
                 if (u > 1) and free[u-1] and (d[u-1] > d[u] + c[2]) then
                   begin
                     d[u-1] := d[u] + c[2];
                     upheap(u-1);
                   end;
             until false;
             writeln(res);
        end;

begin
      nhap;
      khoitao;
      main;
end.