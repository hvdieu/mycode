Uses crt;

Var     i,j,soga,socho    :       longint;

begin
     clrscr;
     for i := 0 to 36 do
       begin
           j := 36 - i;
           if i*2 + j*4 = 100 then
             begin
                 soga := i;
                 socho := j;
             end;
       end;
     writeln('So ga : ',soga);
     writeln('So cho : ',socho);
     readln;
end.