Const   maxn = 10001;

Type    arr     =       array [1..maxn] of qword;

Var     n,d     :       longint;
        a       :       array [1..maxn] of qword;
        time     :       qword;

{**************************************************************************}
procedure nhap;
var i,j : longint;
        begin
             assign(input,'C11PINES.INP'); reset(input);
             assign(output,'C11PINES.OUT'); rewrite(output);
             readln(n,d);
             for i := 1 to n do read(a[i]);
        end;
{**************************************************************************}
procedure swap(var xx,yy : qword);
var temp : qword;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{**************************************************************************}
procedure sort(l,h : longint; var k : arr);
var i,j : longint;
    key : qword;
        begin
            if l >= h then exit;
            i := l; j := h; key := k[l+random(h-l+1)];
            repeat
               while k[i] < key do inc(i);
               while k[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then swap(k[i],k[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j,k); sort(i,h,k);
        end;
{***************************************************************************}
procedure main;
var i,j : longint;
        begin
            sort(1,n,a);
            for i := 2 to n do
              begin
                  a[i] := a[i] + d*time;
                  if (a[i] - a[i-1]) mod d <> 0 then
                    begin
                       write(-1);
                       exit;
                    end
                  else time := time + (a[i] - a[i-1]) div d;
              end;
            writeln(time);
        end;
{***************************************************************************}
begin
     nhap;
     main;
end.
