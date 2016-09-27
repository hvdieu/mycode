Const   inp = 'BRIDGES.INP';
        out = 'BRIDGES.OUT';
        maxn = 10001;
Type    canh = record
        x,y,l,pos  : int64;
        gt      :  double;
        end;
Var     fi,fo   :       text;
        n,vp,vc,k,dem,dem2   :   longint;
        head,num,thoat    :   array [1..maxn] of longint;
        f       :       array [1..maxn] of int64;
        adj     :   array [1..2*maxn] of longint;
        e       :   array [1..maxn] of canh;

procedure input;
var i : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n,k,vp,vc);
             for i := 1 to n-1 do
              with e[i] do
               begin
                   read(fi,x,y,l);
                   inc(head[x]); inc(head[y]);
               end;
             for i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := 2*(n-1);
             for i := 1 to n-1 do
              with e[i] do
               begin
                   adj[head[x]] := y;
                   adj[head[y]] := x;
                   dec(head[x]); dec(head[y]);
               end;
        end;

procedure dfs(u : longint);
var i,v : longint;
        begin
             f[u] := 1; inc(dem);
             num[u] := dem;
             for i := head[u]+1 to head[u+1] do
              begin
                   v := adj[i];
                   if num[v] = 0 then
                     begin
                         dfs(v);
                         f[u] := f[u] + f[v];
                     end;
              end;
             inc(dem2); thoat[u] := dem2;
        end;

function check(u,v : longint) : boolean;
        begin
             if (num[u] <= num[v]) and (thoat[u] >= thoat[v]) then exit(true)
              else exit(false);
        end;

procedure swap(var xx,yy : canh);
var temp : canh;
        begin
             temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j : longint;
    key : double;
        begin
             if l >= h then exit;
             i := l; j := h; key := e[(l+h) div 2].gt;
             repeat
                  while e[i].gt > key do inc(i);
                  while e[j].gt < key do dec(j);
                  if i <= j then
                    begin
                         swap(e[i],e[j]);
                         inc(i); dec(j);
                    end;
             until i > j;
             sort(l,j); sort(i,h);
        end;

procedure main;
var i : longint;
        begin
             dfs(1);
             for i := 1 to n-1 do
              with e[i] do
               begin
                    pos := i;
                    if check(x,y) then
                    gt := (l*f[y]*(n-f[y]))/vp - (l*f[y]*(n-f[y]))/vc
                    else gt := (l*f[x]*(n-f[x]))/vp - (l*f[x]*(n-f[x]))/vc;
               end;
             sort(1,n-1);
             for i := 1 to k do write(fo,e[i].pos,' ');
             close(fi); close(fo);
        end;

begin
     input;
     main;
end.
