{$inline on}
Uses math;
Const   maxn = 24;
        maxf = 60000;
        maxr = 1048580;

Var     a1,a2   :       array [1..maxn] of longint;
        m,n,i,n1,n2,kq   :       longint;
        a,b     :       array [0..maxf] of longint;
        f,g     :       array [0..maxf] of int64;
        res         :       array [0..maxr] of boolean;
        dd          :       array [0..1050,0..maxf] of longint;

{***************************************************************************}
function bat(x,i : longint) : longint;
        begin
            bat := x or (1 shl i);
        end;
{***************************************************************************}
procedure sinh1(i : longint;sumA,sumC : int64; tt : longint);
var j : longint;
        begin
             if i > m then
               begin
                   //if tt <> 0 then
                     begin
                         inc(n1); f[n1] := abs(sumA-sumC);
                         a[n1] := tt;
                     end;
                   exit;
               end;
             sinh1(i+1,sumA,sumC,tt);
             sinh1(i+1,sumA+a1[i],sumC,bat(tt,i-1));
             sinh1(i+1,sumA,sumC+a1[i],bat(tt,i-1));
        end;
{***************************************************************************}
procedure swap(var xx,yy : longint); inline;
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure dc(var xx,yy : int64); inline;
var temp : int64;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := g[l+random(h-l+1)];
            repeat
                while g[i] < k do inc(i);
                while g[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then
                       begin
                         dc(g[i],g[j]);
                         swap(b[i],b[j]);
                       end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
procedure sinh2(i : longint;sumB,sumD : int64;tt : longint);
var j,u,v,t,key : longint;
        begin
            if i > n then
              begin
                 // if tt <> 0 then
                    begin
                         inc(n2); g[n2] := abs(sumB-sumD);
                         b[n2] := tt;
                    end;
                  exit;
              end;
            sinh2(i+1,sumB,sumD,tt);
            sinh2(i+1,sumB+a2[i],sumD,bat(tt,m+i-1));
            sinh2(i+1,sumB,sumD+a2[i],bat(tt,m+i-1));
        end;
{***************************************************************************}
function find(key : int64;tt : longint) : longint;
var d,c,mid,ans : longint;
        begin
             d := 1; c := n2; ans := 0;
             while (d <= c) do
               begin
                   mid := (d+c) shr 1;
                   if g[mid] = key then
                     begin
                         ans := mid;
                         if tt = 0 then c := mid-1
                          else d := mid+1;
                     end
                   else if g[mid] > key then c := mid-1
                    else d := mid+1;
               end;
             exit(ans);
        end;
{**************************************************************************}
procedure main;
var i,j,temp,u,v : longint;
        begin
            sort(1,n2);
            for i := 1 to n1 do
              begin
                  u := find(f[i],0); v := find(f[i],1);
                  if (u <> 0) and (v <> 0) then
                   begin
                       inc(dd[a[i],u]); dec(dd[a[i],v+1]);
                   end;
              end;
            for i := 0 to 1 shl m-1 do
              begin
                   for j := 1 to n2 do
                     begin
                         dd[i,j] := dd[i,j-1] + dd[i,j];
                         if dd[i,j] > 0 then
                          res[i or b[j]] := true;
                     end;
              end;
            for i := 1 to 1 shl (n+m)-1 do
             if res[i] then inc(kq);
            writeln(kq);
        end;
{***************************************************************************}
begin
     assign(input,'subsets.inp'); reset(input);
     assign(output,'subsets.out'); rewrite(output);
     readln(n);
     m := n div 2; n := n-m;
     for i := 1 to m do read(a1[i]);
     for i := 1 to n do read(a2[i]);
     sinh1(1,0,0,0);
     sinh2(1,0,0,0);
     main;
end.
