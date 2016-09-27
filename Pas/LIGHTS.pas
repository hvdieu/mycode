Const   maxn = 35;
        maxf = 524288;
Var     a,b       :       array [1..maxn] of int64;
        st     :       array [1..maxf] of int64;
        dem    :       array [1..maxf] of longint;
        n,m,u,v,j,top,t,res,i :       longint;

{*****************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{****************************************************************************}
procedure dc(var xx,yy : int64);
var temp : int64;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{*****************************************************************************}
procedure sort(l,h : longint);
var i,j,k,k2 : longint;
    k1 : int64;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := st[k]; k2 := dem[k];
            repeat
                while (st[i] < k1) or ((st[i] = k1) and (dem[i] < k2)) do inc(i);
                while (st[j] > k1) or ((st[j] = k1) and (dem[j] > k2)) do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            dc(st[i],st[j]);
                            swap(dem[i],dem[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

{****************************************************************************}
function bat(x : int64;i : longint) : int64;
        begin
             bat := x or (int64(1) shl i);
        end;
{***************************************************************************}
function find(key : int64) : longint;
var d,c,mid,ans : longint;
        begin
            d := 1; c := top; ans := 0;
            while d <= c do
              begin
                  mid := (d+c) shr 1;
                  if (st[mid] = key) then
                    begin
                        ans := mid; c := mid-1;
                    end
                  else if st[mid] > key then c := mid-1
                   else d := mid+1;
              end;
            exit(ans);
        end;

{****************************************************************************}
procedure main;
var i,j,sl : longint;
    sum : int64;
        begin
             for i := 0 to 1 shl m-1 do
               begin
                   sum := 0; sl := 0;
                   for j := 0 to m-1 do
                    if (i shr j) and 1 = 1 then
                     begin
                       sum := sum xor a[j+1];
                       inc(sl);
                     end;
                   inc(top); st[top] := sum; dem[top] := sl;
               end;
             sort(1,top);
             res := maxlongint;
             for i := 0 to 1 shl n-1 do
               begin
                    sum := 0; sl := 0;
                    for j := 0 to n-1 do
                     if (i shr j) and 1 = 1 then
                       begin
                           sum := sum xor b[j+1];
                           inc(sl);
                       end;
                    u := find((int64(1) shl t-1) xor sum);
                    if u <> 0 then
                      begin
                          if sl + dem[u] < res then res := sl + dem[u];
                      end;
               end;
             writeln(Res);
        end;
{****************************************************************************}
begin
     assign(input,'LIGHTS.INP'); reset(input);
     assign(output,'LIGHTS.OUT'); rewrite(output);
     readln(n,m);
     for i := 1 to m do
       begin
            readln(u,v);
            a[u] := bat(a[u],v-1);
            a[v] := bat(a[v],u-1);
       end;
     j := 0;
     t := n;
     for i := 1 to n do a[i] := bat(a[i],i-1);
     for i := n div 2 + 1 to n do
       begin
            inc(j); b[j] := a[i];
       end;
     m := n div 2; n := n-m;
     main;
end.
