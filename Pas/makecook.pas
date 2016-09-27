Const out = 'cook.inp';
Var	fo : text;
	n,q,max,k,i,u : longint;

begin
     assign(fo,out); rewrite(fo);
     write('n, q, max : ');read(n,q,max);
     writeln(fo,n);
     for i := 1 to n do
       begin
           u := random(n);
           while u = i do u := random(n);
           writeln(fo,random(max),' ',u);
       end;	
     writeln(fo,q);
     for i := 1 to q do
       begin
            k := random(2);
            inc(k);
            if k = 1 then
              begin
                  writeln(fo,k,' ',random(n),' ',random(max));
              end
            else writeln(fo,k,' ',random(n));
       end;
     close(fo);
end.	