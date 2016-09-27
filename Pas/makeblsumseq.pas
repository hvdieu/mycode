Uses math;
Const
	out = 'BLSUMSEQ.INP';

Var
	n,q,i,u,t,v : longint;

begin
     randomize;
     assign(output,out); rewrite(output);
     n := 100; q := 1000;
     writeln(n,' ',q);
     for i := 1 to n do write(i,' ');
     writeln;
     for i := 1 to q do
       begin
           u := random(n)+1; v := random(n)+1;
           if u > v then
             begin
                t := u; u := v; v := t;
             end;
           writeln(random(2),' ',u,' ',v,' ',random(10000)+1);
       end;
end.
