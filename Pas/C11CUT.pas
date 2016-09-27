Const   inp = 'C11CUT.INP';
        out = 'C11CUT.OUT';
        maxn = 4;

Var     m,n     :       integer;
        a       :       array [1..4,1..4] of integer;

{***************************************************************************}
procedure main;
var i,j : longint;
        begin
             assign(input,inp); reset(input);
             assign(output,out); rewrite(output);
        end;
{***************************************************************************}
begin
     nhap;
end.