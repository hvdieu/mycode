Const   inp = '';
        out = '';
        maxn = 101;
        oo = 1000000007;

Var     w,b,r,m,k : longint;
        f       : array [-1..maxn,-1..maxn,-1..2*maxn,0..1] of longint;

{***************************************************************************}
procedure main;
var i,j,t,m1 : longint;
        begin
            for j := 1 to r do
             begin
               f[1,j,1,1] := 1;
               f[1,j,1,0] := 1;
               f[1,j,2,1] := j-1;
             end;
            for i := 1 to b do
             begin
                 f[i,1,1,1] := 1;
                 f[i,1,1,0] := 1;
                 f[i,1,2,0] := i-1;
             end;
            for i := 2 to b do
             for j := 2 to r do
              for m1 := 0 to m do
               begin
                   f[i,j,m1,0] := (f[i-1,j,m1,0]+f[i-1,j,m1-1,1]) mod oo;
                   f[i,j,m1,1] := (f[i,j-1,m1,1]+f[i,j-1,m1-1,0]) mod oo;
               end;
            writeln((f[b,r,m,0]+f[b,r,m,1]) mod oo);
        end;
{***************************************************************************}
begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(w,b,r,k,m);
    main;
end.