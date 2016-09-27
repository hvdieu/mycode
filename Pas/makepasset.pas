uses math;
Const
	out = 'passet.inp';


var i,n,x : longint;
	a : array [0..1] of integer;

begin
    randomize;
    assign(output,out); rewrite(output);
    a[0] := 1; a[1] := -1;
    n := 300000;
    for i := 1 to n do
      begin
          x := random(8)+1;
          if (x=3) or (x=4) then writeln(x)
           else writeln(x,' ',random(1000000000)*a[random(2)]);
      end;
    write(0);
end.
