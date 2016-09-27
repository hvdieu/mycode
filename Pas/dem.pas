Uses math;
Const
    inp = 'jednakost.out.10';
    out = 'asd.out';

Var
    s : ansistring;
    i,dem : longint;
begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(s);
    for i := 1 to length(s) do
     if s[i]='+' then inc(dem);
    writeln(dem);
    readln;
end.
