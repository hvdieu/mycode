uses math;
Const
	inp = 'factories.inp';

var
	n,q,s,t,i,u : longint;

begin
     randomize;
     assign(output,inp); rewrite(output);
     n := 500000; q := 500;
     writeln(n,' ',q);
     for i := 1 to n-1 do
       begin
           u := random(i);
           writeln(i-1,' ',i,' ',random(1000000000));
       end;
     while q > 0 do
       begin
           dec(q);
           s := random(200)+1; t := random(200)+1;
           writeln(s,' ',t);
           for i := 1 to s do write(random(n),' ');
           writeln;
           for i := 1 to t do write(random(n),' ');
           writeln;
       end;
end.
