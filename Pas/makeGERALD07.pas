Uses math;
Const
	out = 'input.txt';
    maxn = 20;
    maxm = 20;
    maxq = 20;

Var
	i, n, m, q, u, v, t, ntest, test : longint;

begin
    randomize;
    assign(output, out); rewrite(output);
    ntest := 1;
    writeln(ntest);
    for test := 1 to ntest do
    	begin
        	n := 20;
            m := 50;
            q := 50;
            writeln(n,' ',m,' ',q);
            for i := 1 to m do
            	begin
                    writeln(random(n)+1,' ',random(n)+1);
                end;
            for i := 1 to q do
            	begin
                    u := random(m)+1; v := random(m)+1;
                    if u > v then
                    	begin
                            t := u; u := v; v := t;
                        end;
                    writeln(u,' ',v);
                end;
        end;
end.
