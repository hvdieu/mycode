uses crt;
Var     y       :       double;
        i       :       longint;

begin
     clrscr;
     for i := 1 to 50 do y := y + i / (i+1);
     write('Y = ',y:0:5);
     readln;
end.