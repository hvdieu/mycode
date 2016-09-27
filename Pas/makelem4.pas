Const	out = 'asd.inp';
	maxn = 10001;

Var	n,m,i,u,v,k : longint;

begin
     randomize;
     assign(output,out); rewrite(output);
     n := 10000; m := 100000;
     writeln(n); writeln(m);
     for i := 1 to m do
       begin
           k := random(3)+1;
           case k of
            1,2 : begin
                      u := random(n)+1; v := u+random(n-u);
                      writeln(k,' ',u,' ',v);
            	  end;
            3 : writeln(3);
            end;
       end;
end.
