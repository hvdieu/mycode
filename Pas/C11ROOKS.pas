Uses math;
Const   inp = '';
        out = '';
        maxn = 301;

Var     n,res       :       longint;
        a       :       array [1..maxn,1..maxn] of longint;
        h,c     :       array [1..maxn] of longint;

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
procedure khoitao;
var i,j : longint;
        begin
            for i := 1 to n do
             for j := 1 to n do
              begin
                inc(h[i],a[i,j]); inc(c[j],a[i,j]);
              end;
        end;
{****************************************************************************}
procedure main;
var i,j,l,r,m1,m2,temp,m3,m4,i1,i3 : longint;
        begin
            for i := 1 to n do
             begin
                 m1 := -maxlongint; m2 := -maxlongint;
                 for j := 1 to n do
                  if c[j]-2*a[i,j] > m1 then
                   begin
                       m2 := m1; m1 := c[j]-2*a[i,j];
                   end
                  else if (c[j]-2*a[i,j]<=m1) and (c[j]-2*a[i,j]>m2) then m2 := c[j]-2*a[i,j];
                 if h[i]+m1+m2 > res then res := h[i]+m1+m2;
             end;
            for j := 1 to n do
             begin
                 m1 := -maxlongint; m2 := -maxlongint;
                 for i := 1 to n do
                  if (h[i]-2*a[i,j]>m1) then
                   begin
                     m2 := m1; m1 := h[i]-2*a[i,j];
                   end
                  else if (h[i]-2*a[i,j]<=m1) and (h[i]-2*a[i,j]>m2) then m2 := h[i]-2*a[i,j];
                 if c[j]+m1+m2> res then res := c[j]+m1+m2;
             end;
            for l := 1 to n-1 do
             for r := l+1 to n do
              begin
                   m1 := -maxlongint; m2 := -m1; m3 := m1; m4 := m1;
                   for i := 1 to n do
                    begin
                        temp := h[i]-2*a[i,l]-a[i,r];
                        if temp > m1 then
                         begin
                             m2 := m1; m1 := temp; i1 := i;
                         end
                        else if (temp>m2) then m2 := temp;
                        temp := h[i]-a[i,l]-2*a[i,r];
                        if temp > m3 then
                         begin
                             m4 := m3; m3 := temp; i3 := i;
                         end
                        else if temp > m4 then m4 := temp;
                    end;
                   if i1=i3 then
                    begin
                        res := max(res,c[l]+c[r]+m1+m4);
                        res := max(res,c[l]+c[r]+m2+m3);
                    end
                   else res := max(res,c[l]+c[r]+m1+m3);
              end;
             writeln(res);
        end;
{****************************************************************************}
begin
     nhap;
     khoitao;
     main;
end.