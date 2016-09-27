Const   maxn = 501;
        maxm = 10001;
        maxs = 16;
        maxw = 999999999;

Var     n,m,s,t,st,res,kq,nheap      :       longint;
        head    :       array [0..maxn] of longint;
        ke,next,w       :       array [1..maxm] of longint;
        f       :       array [0..maxs,0..131078] of longint;
        free    :       array [0..maxn] of boolean;
        d       :       array [0..maxn,0..maxn] of longint;
        pos,heap     :       array [0..maxn] of longint;
        shop    :       array [0..20] of longint;

{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
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
{****************************************************************************}
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
{****************************************************************************}
function pop(i : longint) : longint;
        begin
             pop := heap[1];
             heap[1] := heap[nheap];
             pos[heap[1]] := 1;
             dec(nheap);
             downheap(i,heap[1]);
        end;
{***************************************************************************}
procedure Dij(i : longint);
var j,u,v,x : longint;
        begin
             nheap := 1; heap[1] := i; pos[i] := 1;
             for j := 0 to n-1 do
               begin
                   free[j] := true;
                   pos[j] := 0;
               end;
             repeat
                  if nheap = 0 then break;
                  u := pop(i);
                  free[u] := false;
                  j := head[u];
                  while j <> 0 do
                    begin
                        v := ke[j];
                        if free[v] and (d[i,v] > d[i,u] + w[j]) then
                          begin
                              d[i,v] := d[i,u] + w[j];
                              upheap(i,v);
                          end;
                        j := next[j];
                    end;
             until false;
        end;
{**************************************************************************}
function bat(x,i : longint) : longint;
        begin
            bat := x or (1 shl i);
        end;
{***************************************************************************}
function lay(x,i : longint) : longint;
        begin
            lay := (x shr i) and 1;
        end;
{***************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
             for i := 1 to s do
              for j := 1 to 1 shl s-1 do f[i,j] := maxw;
             for i := 1 to s do
              f[i,1 shl (i-1)] := d[0,shop[i]];
        end;
{**************************************************************************}
procedure Dp;
var i,j,u,v,tt,x,dem : longint;
        begin
            for tt := 1 to 1 shl s - 1 do
             for u := 1 to s do
              if f[u,tt] < maxw then
               for v := 1 to s do
                if (u <> v) and (lay(tt,v-1) = 0) then
                  begin
                      x := bat(tt,v-1);
                      if f[v,x] > f[u,tt] + d[shop[u],shop[v]] then
                        f[v,x] := f[u,tt] + d[shop[u],shop[v]];
                  end;
             res := -1; kq := maxw;
             for u := 1 to s do
              for tt := 1 to 1 shl s-1 do
               if f[u,tt] + d[shop[u],n-1] < maxw then
                 begin
                     dem := 0;
                     for i := 0 to s-1 do if lay(tt,i) = 1 then inc(dem);
                     if dem > res then
                       begin
                           res := dem;
                           kq := f[u,tt] + d[shop[u],n-1];
                       end
                     else if (dem = res) and (f[u,tt] + d[shop[u],n-1] < kq) then
                      kq := f[u,tt] + d[shop[u],n-1];
                 end;
             if res = -1 then writeln('Impossible')
              else writeln(res,' ',kq);
        end;
{**************************************************************************}
procedure main;
var i,j : longint;
        begin
             for i := 0 to n-1 do
              for j := 0 to n-1 do
              if i = j then d[i,j] := 0 else d[i,j] := maxw;
             Dij(0);
             for i := 1 to s do dij(shop[i]);
             khoitao;
             Dp;
        end;
{***************************************************************************}
procedure nhap;
var i,u,v,l,j : longint;
        begin
            // assign(input,'asd.inp'); reset(input);
           //  assign(output,'asd.out'); rewrite(output);
             readln(t);
             for st := 1 to t do
               begin
                   write('Case ',st,': ');
                   readln(n,m,s);
                   for i := 1 to s do read(shop[i]);
                   fillchar(head,sizeof(head),0);
                   for i := 1 to m do
                     begin
                         readln(u,v,l);
                         ke[i] := v; w[i] := l; next[i] := head[u]; head[u] := i;
                     end;
                   main;
               end;

        end;
{***************************************************************************}
begin
     nhap;
end.