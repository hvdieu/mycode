Const   inp = 'CHOOSE.IN';
        out = 'CHOOSE.OUT';
        maxn = 501;

Var     m,n,res,m1,m2     :       longint;
        a       :       array [1..maxn,1..maxn] of longint;

{***************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(m,n);
            for i := 1 to m do
             for j := 1 to n do read(a[i,j]);
        end;
{***************************************************************************}
procedure main;
var l,r,i,x : longint;
        begin
            res := -maxlongint;
            for l := 1 to n-1 do
             for r := l+1 to n do
              begin
                   m1 := -maxlongint; m2 := - maxlongint;
                   for i := 1 to m do
                    begin
                       x := a[i,l]+a[i,r];
                       if x > m1 then
                         begin
                             m2 := m1; m1 := x;
                         end
                       else if (x <= m1) and (x > m2) then m2 := x;
                    end;
                   if m1+m2 > res then res := m1+m2;
              end;
             writeln(res);
        end;
{***************************************************************************}
begin
    nhap;
    main;
end.