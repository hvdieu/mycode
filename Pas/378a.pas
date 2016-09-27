var     a,b,i,x,y,z : integer;

begin
     readln(a,b);
     for i := 1 to 6 do
      if abs(a-i)=abs(b-i) then inc(y)
       else if abs(a-i)>abs(b-i) then inc(x)
        else inc(z);
      writeln(z,' ',y,' ',x);
      readln;
end.
