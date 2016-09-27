Uses math;

Var
    i,j,n : longint;
    res,t : double;

begin
    n := 49;  res := 00;
    for i := 1 to n do
     begin
        t := 1;
        for j := 1 to n-2 do t := t*1.07;
        res := res+0.5*t;
     end;
    writeln(res:0:2);
    readln;
end.