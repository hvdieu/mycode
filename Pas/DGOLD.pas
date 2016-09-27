{$inline on}
Uses math;
Const   maxn = 24;
        maxf = 531442;

Type    node = record
        x,y     :       longint;
        end;

        arr = array [0..maxf] of longint;

Var     a1,a2   :       array [1..maxn] of longint;
        m,n,i,n1,n2,res   :       longint;
        f,g,a,b     :       array [0..maxf] of longint;

{***************************************************************************}
procedure sinh1(i,sumA,sumC : longint);
var j : longint;
        begin
             if i > m then
               begin
                   if (sumA <> 0) or (sumC <> 0) then
                     begin
                         inc(n1); f[n1] := abs(sumA-sumC);
                         a[n1] := max(sumA,sumC);
                     end;
                   exit;
               end;
             sinh1(i+1,sumA,sumC);
             sinh1(i+1,sumA+a1[i],sumC);
             sinh1(i+1,sumA,sumC+a1[i]);
        end;
{***************************************************************************}
procedure swap(var xx,yy : longint); inline;
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure sort(l,h : longint;var f,a : arr);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := f[l+random(h-l+1)];
            repeat
                while f[i] < k do inc(i);
                while f[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then
                       begin
                         swap(f[i],f[j]);
                         swap(a[i],a[j]);
                       end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j,f,a); sort(i,h,f,a);
        end;
{***************************************************************************}
procedure sinh2(i,sumB,sumD : longint);
var j,u,v,t,key : longint;
        begin
            if i > n then
              begin
                  if (sumB <> 0) or (sumD <> 0) then
                    begin
                         inc(n2); g[n2] := abs(sumB-sumD);
                         b[n2] := max(sumB,sumD);
                    end;
                  exit;
              end;
            sinh2(i+1,sumB,sumD);
            sinh2(i+1,sumB+a2[i],sumD);
            sinh2(i+1,sumB,sumD+a2[i]);
        end;
{***************************************************************************}
procedure main;
var i,j,temp,d,c : longint;
        begin
            sort(1,n1,f,a); sort(1,n2,g,b);
            d := 1;
            g[0] := -1;
            for i := 1 to n2 do
              begin
                  if (g[i] = g[i-1]) and (temp <> -1) then
                  begin
                    if res < b[i]+temp-g[i] then res := b[i]+temp-g[i];
                  end
                   else
                     begin
                         temp := -1;
                         while (i <= n1) and (f[d] < g[i]) do inc(d);
                         begin
                           if (d <= n1) and (f[d] = g[i]) then
                             begin
                                 c := d;
                                 while (c <= n1) and (f[c] = g[i]) do
                                   begin
                                       if temp < a[c] then temp := a[c];
                                       inc(c);
                                   end;
                                 if res < b[i]+temp-g[i] then res := b[i]+temp-g[i];
                                 d := c;
                             end;
                         end;
                     end;
              end;
              writeln(res);
        end;
{***************************************************************************}
begin
  //   assign(input,'dgold.inp'); reset(input);
  //   assign(output,'dgold.out'); rewrite(output);
     readln(n);
     m := n div 2; n := n-m;
     for i := 1 to m do read(a1[i]);
     for i := 1 to n do read(a2[i]);
     sinh1(1,0,0);
     sinh2(1,0,0);
     main;
end.