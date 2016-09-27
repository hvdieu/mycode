uses math;
const
	out = 'cutseqs.inp';
    maxn = 100;

Var
	n,i : longint;
    m : int64;

begin
     randomize;
     assign(output,out); rewrite(output);
     n := 100000;
     m := random(int64(1) shl 31);
     writeln(n,' ',m);
     for i := 1 to n do write(random(1000000),' ');
end.

