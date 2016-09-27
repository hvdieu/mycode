Const   inp = '';
        out = '';
        maxn = 100001;

Var     n,vmax,d1,d2       :       longint;
        head,d,cha,num,thoat,a    :       array [1..maxn] of longint;
        ke,next :       array [-maxn..maxn] of longint;
        f       :       array [1..maxn,0..20] of longint;

{***************************************************************************}
procedure nhap;
var i,u,v : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n-1 do
             begin
                readln(u,v);
                ke[i] := v; next[i] := head[u]; head[u] := i;
                ke[-i] := u; next[-i] := head[v]; head[v] := -i;
             end;
        end;
{***************************************************************************}
procedure khoitao;
var i : longint;
        begin
            cha[1] := 1; vmax := round(ln(n)/ln(2))+1;
            f[1,0] := 1;
        end;
{****************************************************************************}
procedure dfs(u : longint);
var j,v,i : longint;
        begin
            inc(d1); num[u] := d1;
            for j := 1 to vmax do
             f[u,j] := f[f[u,j-1],j-1];
            j := head[u];
            while j <> 0 do
             begin
                 v := ke[j];
                 if cha[v] = 0 then
                  begin
                      cha[v] := u; f[v,0] := u;
                      d[v] := d[u]+1;
                      dfs(v);
                  end;
                 j := next[j];
             end;
            inc(d2); thoat[u] := d2;
        end;
{****************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{****************************************************************************}
procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := num[a[l+random(h-l+1)]];
            repeat
               while num[a[i]]<k do inc(i);
               while num[a[j]]>k do dec(j);
               if i <= j then
                begin
                    if i < j then swap(a[i],a[j]);
                    inc(i); dec(j);
                end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
function check(u,v : longint) : boolean;
        begin
            if (num[u]<=num[v]) and (thoat[u]>=thoat[v]) then exit(true)
             else exit(false);
        end;
{***************************************************************************}
function lca(u,v : longint) : longint;
var j,x : longint;
        begin
            if check(u,v) then exit(d[v]-d[u]);
            if check(v,u) then exit(d[u]-d[v]);
            x := d[u]+d[v];
            for j := vmax downto 0 do
             if check(f[u,j],v)=false then u := f[u,j];
            exit(x-2*d[cha[u]]);
        end;
{****************************************************************************}
procedure main;
var i,j,m : longint;
    res : int64;
        begin
            dfs(1);
            for i := 1 to n do
             begin
                 j := i; m := 0;
                 while j <= n do
                   begin
                      inc(m); a[m] := j;
                      j := j+i;
                   end;
                 sort(1,m);
                 res := d[a[1]];
                 for j := 1 to m-1 do
                   res := res + lca(a[j],a[j+1]);
                 res := res + d[a[m]];
                 writeln(res);
             end;
        end;
{****************************************************************************}
begin
     nhap;
     khoitao;
     main;
end.