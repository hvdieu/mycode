Uses math;
Const
	inp = 'RUNNING.INP';
	out = 'RUNNING.OUT';
	maxn = 10001;
	maxm = 501;

Var
	n,m,t,i,j : longint;
	f : array [0..1,0..maxm,0..1] of longint;
	d : array [1..maxn] of longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	for i := 1 to n do read(d[i]);
	t := 0;
	for i := 1 to n do
	  begin
	  	t := 1-t;
	  	for j := 0 to m do
          begin
            f[t,j,0] := max(f[1-t,j+1,0],f[1-t,j+1,1]);
            f[t,j,0] := max(f[1-t,j,0],f[t,j,0]);
            if j>0 then
              f[t,j,1] := max(f[1-t,j-1,1]+d[i],f[1-t,0,0]+d[i]);
          end;
	  end;
	writeln(f[t,0,0]);
end.
