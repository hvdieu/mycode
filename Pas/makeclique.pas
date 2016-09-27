uses math;
const
	out = 'clique.inp';

var
	ntest,n,m,k,i,u,v : longint;

begin
     randomize;
     assign(output,out); rewrite(output);
     ntest := 10;
     writeln(ntest);
     while ntest > 0 do
       begin
           dec(ntest);
           n := random(60)+1;
           m := random((n-1)*(n-1))+1;
           k := random(n)+1;
           writeln(n,' ',m,' ',k);
           for i := 1 to m do
             begin
                 u := random(n)+1; v := random(n)+1;
                 while u = v do v := random(n)+1;
                 writeln(u,' ',v);
             end;
       end;
end.
