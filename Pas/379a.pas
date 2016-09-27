var     a,b,res,c,x :       longint;

begin
     readln(a,b);
     repeat
         if a = 0 then break;
         inc(res,a);
         x := (a+c) mod b;
         a := (a+c) div b;
         c := x;
     until false;
     writeln(res); readln;
end.
