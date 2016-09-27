Const   inp = 'NETWORK.INP';
        out = 'NETWORK.OUT';
        maxn = 100001;

Type    arr = array [1..maxn] of longint;

Var     m,n,dem,dem2,vmax     :       longint;
        head,cha    :       array [1..maxn] of longint;
        ke,next :       array [-maxn..maxn] of longint;
        x,y,w,id,pos,l,first,last,thoat   :       array [1..maxn] of longint;
        f       :       array [1..maxn,0..32] of longint;
        a,b,c,kind :       array [1..maxn] of longint;
        t1,t2,kq,vt   :       array [1..maxn] of longint;

{**************************************************************************}
procedure nhap;
var i,j,u,v,l : longint;
        begin
         //   assign(input,inp); reset(input);
         //   assign(output,out); rewrite(output);
            readln(n,m);
            for i := 1 to n-1 do
             begin
              readln(x[i],y[i],w[i]);
              id[i] := i;
             end;
        end;
{**************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{**************************************************************************}
procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := w[l+random(h-l+1)];
            repeat
               while w[i] < k do inc(i);
               while w[j] > k do dec(j);
               if i <= j then
                begin
                    if i < j then
                      begin
                          swap(x[i],x[j]);
                          swap(y[i],y[j]);
                          swap(w[i],w[j]);
                          swap(id[i],id[j]);
                      end;
                    inc(i); dec(j);
                end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{**************************************************************************}
procedure sort2(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := c[l+random(h-l+1)];
            repeat
               while c[i] < k do inc(i);
               while c[j] > k do dec(j);
               if i <= j then
                begin
                    if i < j then
                      begin
                          swap(a[i],a[j]);
                          swap(b[i],b[j]);
                          swap(c[i],c[j]);
                          swap(kind[i],kind[j]);
                          swap(vt[i],vt[j]);
                      end;
                    inc(i); dec(j);
                end;
            until i > j;
            sort2(l,j); sort2(i,h);
        end;
{**************************************************************************}
procedure dfs(u : longint);
var j,v : longint;
        begin
             inc(dem); l[dem] := u;
             first[u] := dem;
             for j := 1 to vmax do
               f[u,j] := f[f[u,j-1],j-1];
             j := head[u];
             while j <> 0 do
               begin
                   v := ke[j];
                   if cha[v] = 0 then
                     begin
                       cha[v] := u;
                       f[v,0] := u;
                       dfs(v);
                     end;
                   j := next[j];
               end;
             last[u] := dem;
             inc(dem2); thoat[u] := dem2;
        end;
{**************************************************************************}
procedure khoitao;
var i,j,u,v : longint;
    ch : char;
        begin
            sort(1,n-1);
            for i := 1 to n-1 do
              pos[id[i]] := i;
            for i := 1 to n-1 do
              begin
                  u := x[i]; v := y[i];
                  ke[i] := v; next[i] := head[u]; head[u] := i;
                  ke[-i] := u; next[-i] := head[v]; head[v] := -i;
              end;
            f[1,0] := 1; cha[1] := 1;
            vmax := round(ln(n)/ln(2));
            dfs(1);
            for i := 1 to m do
              begin
                  vt[i] := i;
                  read(ch);
                  if ch = 'P' then
                    begin
                        kind[i] := 1;
                        readln(a[i],b[i],c[i]);
                    end
                  else begin
                           kind[i] := 2;
                           readln(a[i],c[i]);
                       end;
              end;
            sort2(1,m);
        end;

{**************************************************************************}
procedure update(i,val : longint;var t : arr);
        begin
            while i <= n do
              begin
                  inc(t[i],val);
                  inc(i,i and (-i));
              end;
        end;
{**************************************************************************}
function get(i : longint;var t : arr) : longint;
var s : longint;
        begin
            s := 0;
            while i > 0 do
              begin
                  inc(s,t[i]);
                  dec(i,i and (-i));
              end;
            exit(s);
        end;
{***************************************************************************}
function check(u,v : longint) : boolean;
        begin
            if (first[u] <= first[v]) and (thoat[u] >= thoat[v]) then exit(true)
             else exit(false);
        end;
{****************************************************************************}
function lca(u,v : longint) : longint;
var i,j : longint;
        begin
            if check(u,v) then exit(u);
            if check(v,u) then exit(v);
            for j := vmax downto 0 do
              if check(f[u,j],v) = false then u := f[u,j];
            exit(f[u,0]);
        end;
{****************************************************************************}
function truyvan1(u,v : longint) : longint;
var i,j,p,res : longint;
        begin
            p := lca(u,v);
            res := get(first[u],t1) + get(first[v],t1) - 2*get(first[p],t1);
            exit(res);
        end;
{****************************************************************************}
function truyvan2(u,v,ts,gt : longint) : longint;
var i,j,res,x : longint;
        begin
             x := get(last[v],t2) - get(first[v]-1,t2);
             if cha[v] = u then res := x
              else
               begin
                   res := get(n,t2) - x;
                   if ts <= gt then dec(res);
               end;
              exit(res);
        end;
{***************************************************************************}
procedure main;
var i,j,u,v : longint;
    ch : char;
        begin
             j := 1;
             for i := 1 to m do
              begin
                  while (j<=n-1) and (w[j] <= c[i]) do
                    begin
                        u := x[j]; v := y[j];
                        if v=cha[u] then swap(u,v);
                        update(first[v],1,t1); update(last[v]+1,-1,t1);
                        update(first[u],1,t2);
                        inc(j);
                    end;
                  if kind[i] = 1 then kq[vt[i]] := truyvan1(a[i],b[i])
                   else kq[vt[i]] := truyvan2(x[pos[a[i]]],y[pos[a[i]]],w[pos[a[i]]],c[i]);
              end;
             for i := 1 to m do writeln(kq[i]);
        end;
{**************************************************************************}
begin
    nhap;
    khoitao;
    main;
end.