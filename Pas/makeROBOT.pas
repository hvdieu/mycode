uses math;
const
	out = 'robot.inp';

var
	n,m,x,i,u,v,t : longint;
    h : array [1..100000] of longint;

begin
     randomize;
     assign(output,out); rewrite(output);
     n := 10000; m := 300000;
     for i := 1 to n do h[i] := random(1000000000)+1;
     x := random(h[1]);
     writeln(n,' ',m,' ',x);
     for i := 1 to n do write(h[i],' ');
     writeln;
     for i := 1 to m do
       begin
           u := random(n)+1; v := random(n)+1;
           while v = u do v := random(n)+1;
           t := random(1000000000);
           writeln(u,' ',v,' ',t);
       end;
end.