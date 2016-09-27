Uses math;
Const   inp = 'test.inp';
        out = 'asd.out';
        maxn = 1001;

Var     n       :       longint;
        a       :       array [1..maxn,1..maxn] of longint;
        f       :       array [1..maxn] of int64;
        s,res       :       int64;

{***************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n do
             for j := 1 to n do read(a[i,j]);
        end;
{***************************************************************************}
procedure main;
var i,j : longint;
        begin
            for i := 1 to n do s := s + a[i,i];
            f[1] := 0; res := s;
            for i := 2 to n do f[i] := -int64(1) shl 60;
            for i := 2 to n do
             for j := 1 to i-1 do
              begin
                f[i] := max(f[i],f[j]-a[j,1]+a[j,i]+a[i,1]-a[i,i]);
                if f[i]+s>res then res := f[i]+s;
              end;
             writeln(res);
        end;
{***************************************************************************}
begin
     nhap;
     main;
end.
