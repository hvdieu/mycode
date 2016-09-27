Const   maxn = 1010;

Var     n       :       longint;
        k       :       int64;
        f       :       array [1..maxn,96..122] of int64;
        a,res       :       array [0..maxn] of longint;
        ok      :   boolean;

{**************************************************************************}
procedure nhap;
var i,j : longint;
        begin
             assign(input,'C11SSTR.INP'); reset(input);
             assign(output,'C11SSTR.OUT'); rewrite(output);
             readln(n,k);
             for i := 1 to n do read(a[i]);
             a[0] := 0;
        end;
{**************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            for i := 1 to n+1 do
             for j := 96 to 122 do f[i,j] := -1;
        end;
{**************************************************************************}
function tinh(i,kt : longint) : int64;
var res : int64;
    j,d : longint;
        begin
             if f[i,kt] <> -1 then exit(f[i,kt]);
             if ok then exit(0);
             if i > n then
             begin
                f[i,kt] := 1;
                exit(1);
             end;
             res := 0;
             if a[i] < a[i-1] then d := kt
              else d := kt+1;
             for j := d to 122 do
              begin
                res := res + tinh(i+1,j);
                if res > k then
                  begin
                     f[i,kt] := res;
                     ok := true;
                     exit(res);
                  end;
              end;
             f[i,kt] := res;
             exit(res);
        end;
{**************************************************************************}
procedure truyvet(i,kt : longint);
var j,d : longint;
        begin
            if a[i] < a[i-1] then d := kt
             else d := kt+1;
            for j := d to 122 do
              if k > tinh(i+1,j) then k := k - tinh(i+1,j)
                else
                  begin
                      res[a[i]] := j;
                      truyvet(i+1,j);
                      exit;
                  end;
        end;
{**************************************************************************}
procedure main;
Var i : longint;
        begin
            tinh(1,96);
            if k > f[1,96] then write(-1) else
            truyvet(1,96);
            for i := 1 to n do write(chr(res[i]));
        end;
{**************************************************************************}
procedure make;
var i,j : longint;
        begin
            n := 1000; k := 3;
            assign(output,'c11sstr.inp'); rewrite(output);
            writeln(n,' ',k);
            for i := n downto 1 do write(i,' ');
        end;
{**************************************************************************}
begin
  //   make;
     nhap;
     khoitao;
     main;
end.
