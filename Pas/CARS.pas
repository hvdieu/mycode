Const   maxn = 50001;
Var     m,n,d,l,res,i :       longint;
        a,b       :       array [1..maxn] of longint;

{*************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{**************************************************************************}
procedure sort(l,h : longint);
var k,i,j : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := a[l+random(h-l+1)];
            repeat
                while a[i] < k do inc(i);
                while a[j] > k do dec(j);
                if i <= j then
                 begin
                     if i < j then swap(a[i],a[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{**************************************************************************}
procedure main;
var i,j : longint;
        begin
            sort(1,n);
            j := 1;
            for i := 1 to n do
              if a[i] - b[j]*d >= l then
               begin
                   inc(b[j]);
                   inc(j);
                   if j > m then j := 1;
               end;
            for i := 1 to m do res := res + b[i];
            writeln(res);
        end;
{**************************************************************************}
begin
     assign(input,'CARS.INP'); reset(input);
     assign(output,'CARS.OUT'); rewrite(output);
     readln(n,m,d,l);
     for i := 1 to n do read(a[i]);
     main;
end.
