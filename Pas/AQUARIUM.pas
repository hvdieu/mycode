Const   maxn = round(1E5+10);
        maxm = round(1E5+10);
        maxh = round(1E6+10);

Type    arr     =       array [1..maxh] of extended;

Var     m,n,h,i   :       longint;
        y       :       array [1..maxm] of int64;
        a,b,c       :       array [1..maxh] of extended;

{***************************************************************************}
procedure swap(var xx,yy : int64);
var temp : int64;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure update(var t : arr;i : longint; val : extended);
        begin
             while i <= h do
               begin
                   t[i] := t[i] + val;
                   inc(i, i and (-i));
               end;
        end;
{***************************************************************************}
function get(var t : arr; i : longint) : extended;
var s : extended;
        begin
            s := 0;
            while i > 0 do
              begin
                  s := s + t[i];
                  dec(i, i and (-i));
              end;
            exit(s);
        end;
{***************************************************************************}
procedure khoitao;
var i,j : longint;
    y1,y2 : int64;
    a1,b1,c1 : extended;
        begin
              for i := 1 to m do
                begin
                   y1 := y[i]; y2 := y[i+1];
                   if y1 > y2 then swap(y1,y2);
                   if y2 > y1 then
                     begin
                        a1 := 1 / (2*(y2-y1));
                        b1 := -y1 / (y2-y1);
                        c1 := sqr(y1) / (2*(y2-y1));
                        update(a,y1+1,a1); update(a,y2+1,-a1);
                        update(b,y1+1,b1); update(b,y2+1,-b1);
                        update(c,y1+1,c1); update(c,y2+1,-c1);
                     end;
                   b1 := 1; c1 := -y2 + (y2-y1)/2;
                   update(b,y2+1,1); update(c,y2+1,c1);
                end;
        end;
{***************************************************************************}
procedure main;
var i,j,k : longint;
    a1,b1,c1,res : extended;
        begin
             readln(n);
             for i := 1 to n do
               begin
                   readln(k);
                   a1 := get(a,k); b1 := get(b,k); c1 := get(c,k);
                   res := a1*k*k + b1*k + c1;
                   writeln(res:0:4);
               end;
        end;
{***************************************************************************}
begin
     assign(input,'AQUARIUM.INP'); reset(input);
     assign(output,'AQUARIUM.OUT'); rewrite(output);
     readln(m,h);
     for i := 1 to m+1 do read(y[i]);
     khoitao;
     main;
end.
