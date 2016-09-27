uses math;
Const
	inp = 'ifunc.inp';

Var
	n : longint;

begin
     randomize;
     assign(output,inp) ;rewrite(output);
     n := 100;
     while n > 0 do
       begin
           dec(n);
           writeln(random(1125899906842624));
       end;
end.



