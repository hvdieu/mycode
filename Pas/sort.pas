Const   maxn = 20001;
        maxw = 999999999;

Var     n,k     :       longint;
        a       :       array [1..maxn] of longint;
        g       :       array [1..10,1..10] of longint;
        f       :       array [0..40000] of longint;
        sl      :       array [1..10] of longint;

{***************************************************************************}
procedure nhap;
var i,j : longint;
        begin
             assign(input,'SORT.INP'); reset(input);
             assign(output,'SORT.OUT'); rewrite(output);
             readln(n,k);
             for i := 1 to n do read(a[i]);
        end;
{***************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            for i := 1 to n do
              begin
                  inc(sl[a[i]]);
                  for j := 1 to k do
                   if j <> a[i] then inc(g[a[i],j],sl[j]);
              end;
            for i := 1 to 1 shl k-1 do f[i] := maxw;
        end;
{***************************************************************************}
function lay(x,i : longint) : longint;
        begin
            lay := (x shr i) and 1;
        end;
{***************************************************************************}
function bat(x,i : longint) : longint;
        begin
            bat := x or (1 shl i);
        end;
{***************************************************************************}
procedure main;
var i,j,tt,cp,x : longint;
        begin
            for tt := 0 to 1 shl k-1 do
              begin
                  for i := 1 to k do
                   if lay(tt,i-1) = 0 then
                     begin
                         x := bat(tt,i-1);
                         cp := 0;
                         for j := 1 to k do
                         if (j <> i) and (lay(tt,j-1) = 0) then
                           inc(cp,g[i,j]);
                         if f[x] > f[tt] + cp then f[x] := f[tt] + cp;
                     end;
              end;
            write(f[1 shl k-1]);
        end;
{***************************************************************************}
begin
     nhap;
     khoitao;
     main;
end.
