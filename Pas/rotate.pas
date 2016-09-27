Const   maxn = 100001;

Var     n,q,k   :       longint;
        pos,section     :       array [0..maxn] of longint;

{***************************************************************************}
procedure rotate1_right(x : longint);
var i : longint;
        begin

        end;
{***************************************************************************}
procedure rotate2_right(x : longint);
var i : longint;
        begin

        end;
{***************************************************************************}
procedure nhap;
var i,kind,x : longint;
        begin
             assign(input,'rotate.inp'); reset(input);
             assign(output,'rotate.out'); rewrite(output);
             readln(n,k,q);
             for i := 1 to q do
               begin
                   readln(kind,x);
                   if kind = 1 then
                   begin
                    if x > 0 then rotate1_right(x)
                     else rotate1_right(n-x);
                   end
                    else if x > 0 then rotate2_right(x)
                     else rotate2_right(n+x);
               end;
        end;
{***************************************************************************}
begin
     nhap;
end.
