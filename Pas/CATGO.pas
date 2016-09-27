Uses math;
Const   inp = '';
        out = '';
        maxn = 51;

Var     a,b,s       :       array [0..maxn] of longint;
        f     :       array [0..maxn,0..maxn] of longint;
        g     :       array [1..maxn,0..2450] of longint;
        n,m,res     :       longint;

{**************************************************************************}
procedure nhap;
var i,j,x : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n do read(a[i]);
            readln(m);
            for i := 1 to m do
             begin
                 readln(x,j);
                 b[x] := j;
             end;
        end;
{**************************************************************************}
procedure main;
var i,j,k : longint;
        begin
             for i := 0 to 50 do f[i,0] := b[i];
             for i := 2 to 50 do
              for j := 1 to i-1 do
               for k := i downto j do
                f[i,j] := max(f[i,j],f[k-1,j-1]+b[i-k+1]);
             s[1] := a[1];
             for i := 2 to n do s[i] := s[i-1]+a[i];
             for j := 0 to a[1]-1 do g[1,j] := f[a[1],j];
             for i := 2 to n do
              for j := 0 to s[i]-i do
               for k := 0 to j do
                g[i,j] := max(g[i-1,j-k]+f[a[i],k],g[i,j]);
             for j := 0 to s[n]-n do
               res := max(res, g[n,j]-((j+1)*j) div 2 );
             writeln(res);
        end;
{**************************************************************************}
begin
     nhap;
     main;
end.