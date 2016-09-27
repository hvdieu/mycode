Uses math;
Const out = 'palin.inp';
var i,t : longint;
begin

     assign(output,out); rewrite(output);
     t := 1;
     while t > 0 do
      begin
      dec(t);
     for i := 1 to 1000 do write(random(2));
     writeln;
     end;
end.
