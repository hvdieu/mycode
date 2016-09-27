Uses math;

Const   inp = 'ACM.INP';
        out = 'ACM.OUT';
        maxn = 1001;
        maxn2 = 400001;
        maxw = 999999999;

Var     n,res       :       longint;
        a,b,c     :       array [1..2*maxn2] of longint;
        f       :       array [1..2*maxn,0..maxn] of longint;

{**************************************************************************}
procedure sub1;
var i,j : longint;
        begin
             for i := 1 to 2*n do
              for j := 0 to n do f[i,j] := maxw;
             f[1,0] := b[1]; f[1,1] := a[1];
             for i := 2 to 2*n do
              for j := 0 to n do
               begin
                   if j > 0 then f[i,j] := min(f[i-1,j] + b[i],f[i-1,j-1] + a[i])
                    else f[i,j] := f[i-1,j] + b[i];
               end;
             writeln(f[2*n,n]);
        end;
{***************************************************************************}
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
            i := l; j := h; k := c[l+random(h-l+1)];
            repeat
               while c[i] < k do inc(i);
               while c[j] > k do dec(j);
               if i <= j then
                 begin
                     if i < j then swap(c[i],c[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{**************************************************************************}
procedure sub2;
var i,j : longint;
        begin
             res := 0;
             for i := 1 to 2*n do
               begin
                 c[i] := a[i]-b[i];
                 inc(res,a[i]);
               end;
             sort(1,2*n);
             for i := n+1 to 2*n do dec(res,c[i]);
             writeln(res);
        end;
{**************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to 2*n do read(a[i],b[i]);
            if n <= 1000 then sub1
             else
            sub2;
        end;
{**************************************************************************}
procedure make;
var i,j : longint;
        begin
            randomize;
            n := 5;
            assign(output,inp); rewrite(output);
            writeln(n);
            for i := 1 to 2*n do
             writeln(random(101),' ',random(101));
        end;
{****************************************************************************}
begin
   // make;
    nhap;
end.
