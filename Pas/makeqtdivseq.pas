uses math;
Const
	out = 'qtdivseq.inp';

Var
	n,k,i : longint;
begin
    assign(output,out); rewrite(output);
    writeln(1000000,' ',99999);
    for i := 1 to 1000000 do write(0,' ');
end.