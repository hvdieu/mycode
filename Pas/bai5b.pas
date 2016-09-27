Uses crt;
Var     i,tg       :       longint;
        res     :       double;

begin
     clrscr;
     res := 1;
     tg := 1;
     repeat
           inc(i);
           tg := tg * i;
           if 1 / tg < 2*0.000001 then break
            else res := res + 1 / tg;
     until false;
     write('e(n) = ',res:0:5);
     readln;
end.