Uses math;
Const
	inp = 'brick.inp';
	out = 'brick.out';

Var
	n,k,x,u,v,i,j,kk,t : longint;
	res : int64;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(k);
	res := 0;
    for i := 1 to 50 do
     for j := 1 to i-2 do
      for kk := 1 to j-2 do
       for t := 1 to kk-2 do
        if (i mod 2 = j mod 2) and (j mod 2 = t mod 2) and (t mod 2=kk mod 2) then
        begin
           x := sqr(i)-sqr(j)+sqr(kk)-sqr(t);
           if (x >0) and (x <=k) then inc(res);
        end;
	writeln(res);
end.
