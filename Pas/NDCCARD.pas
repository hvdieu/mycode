Uses math;
Const   inp = '';
        out = '';
        maxn = 10001;

Var     a,sl,b    :       array [1..maxn] of longint;
        n,m,res     :       longint;

{**************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            read(n,m);
            for i := 1 to n do read(a[i]);
        end;
{**************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{*************************************************************************}
procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := a[l+random(h-l+1)];
            repeat
               while a[i]<k do inc(i);
               while a[j]>k do dec(j);
               if i <= j then
                 begin
                     if i < j then swap(a[i],a[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{****************************************************************************}
procedure main;
var i,j,x : longint;
        begin
            sort(1,n);
            if a[n]+a[n-1]+a[n-2] <= m then
              begin
                  res := a[n]+a[n-1]+a[n-2];
                  exit;
              end;
            for i := 1 to n do inc(sl[a[i]]);
            for i := 1 to 10000 do if sl[i]<>0 then b[i] := i
             else b[i] := b[i-1];
            for i := 1 to n-1 do
             for j := 1 to n-1 do
              if (m-a[i]-a[j] <= 10000) and (m-a[i]-a[j]>=1) then
              begin
                  dec(sl[a[i]]); dec(sl[a[j]]);
                  x := m-a[i]-a[j];
                  if (b[x]<>0) and (sl[b[x]]>0) then res := max(res,a[i]+a[j]+b[x]);
                  inc(sl[a[i]]); inc(sl[a[j]]);
              end;
        end;
{****************************************************************************}
begin
     nhap;
     main;
     write(res);
end.