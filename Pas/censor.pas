{$H+}
Uses math;
Const
    inp = 'censor.in';
    out = 'censor.out';

Var
    s : string;
    a : array [1..200000] of string;
    n, i, j : longint;
    stop : boolean;

begin
    assign(input, inp); reset(input);
    assign(output,out); rewrite(output);
    readln(s);
    readln(n);
    for i := 1 to n do readln(a[i]);
    stop := false;
    while (stop = false) do
        begin
            stop := true;
            for i := 1 to n do if (length(a[i]) < length(s)) then
            begin
              repeat
                j := pos(a[i], s);
                if (j = 0) then break;
                stop := false;
                delete(s, j, length(a[i]));
              until false;
            end;
        end;
    writeln(s);
end.