Uses math;
Const   inp = '';
        out = '';
        maxm = 3001;
        maxn = 201;

Var     m,n     :       longint;
        f       :       array [1-maxn..maxm-1,1-maxn..maxm-1,'a'..'z'] of integer;
        a       :       array [1..maxm,1..maxn] of char;
        res     :       int64;

{**************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(m,n);
            for i := 1 to m do
             begin
                for j := 1 to n do read(a[i,j]);
                readln;
             end;
        end;
{***************************************************************************}
procedure main;
var i,j,k : longint;
        begin
            for i := 1 to m do
             for j := 1 to n do
              if a[i,j] <> '.' then
               begin
                   for k := 1 to min(m,n) do
                    if (i-k<=0) or (j+k>n) then break
                     else if a[i-k,j+k]=a[i,j] then
                     begin
                       res := res + f[i-j,i-k-(j+k),a[i,j]];
                       inc(f[i-j,i-k-(j+k),a[i,j]]);
                     end;
               end;
             writeln(res);
        end;
{***************************************************************************}
begin
     nhap;
     main;
end.