Uses crt;
Var     x,y,z,tg     :       double;

begin
     clrscr;
     write('Nhap x,y :'); readln(x,y);
     tg := sqr(x) + sqr(y);
     if tg <= 1 then z := sqr(x) + sqr(y)
      else if (tg > 1) and (y >= x) then z := x + y
       else if (tg > 1) and (y < x) then z := 0.5;
     writeln(z:0:2);
     readln;
end.
