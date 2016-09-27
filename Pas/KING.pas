Const   maxn = 21;
Var     n,i,j       :       longint;
        a       :   array [1..maxn,1..maxn] of longint;
        d       :   array [1..maxn] of longint;

procedure main;
var i,j : longint;
        begin
            fillchar(d,sizeof(d),0);
            for i := 1 to n do
              for j := 1 to n do d[i] := d[i] - a[i,j];


        end;

begin
     assign(input,'KING.INP'); reset(input);
     assign(output,'KING.OUT'); rewrite(output);
     readln(t);
     while t > 0 do
       begin
           dec(t);
           readln(n);
           for i := 1 to n do
             for j := 1 to n do read(a[i,j]);
           main;
       end;
end.