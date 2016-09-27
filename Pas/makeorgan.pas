Const	out = 'organ.inp';
var	n,s,w,m,bmin,bmax,ntest,i : longint;

begin
     randomize;
     assign(output,out); rewrite(output);
     ntest := 10;
     writeln(ntest);
     while ntest > 0 do
       begin
           dec(ntest);
           n := random(200)+1; s := random(n)+1; w := 20;
           m := random(100)+1; bmin := 1021; bmax := random(100000000)+10;
           writeln(n,' ',s,' ',w,' ',m,' ',bmin,' ',bmax);
           for i := 1 to n do write(random(100000)+1,' ');
           writeln;
       end;
end.
