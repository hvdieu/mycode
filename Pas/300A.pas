Uses math;
Const
    inp = 'input.txt';
    out = 'output.txt';

Var
    s, ss, x : string;
    ok : boolean;
    n,i,len : longint;

begin
    assign(input, inp); reset(input);
    assign(output, out); rewrite(output);
    readln(s);
    n := length(s);
    x := 'CODEFORCES';
    ok := false;
    if (pos(x, s) <> 0) then ok := true
    else begin
        for len := 1 to n-10 do
         for i := 1 to n-len+1 do
          begin
              ss := s;
              delete(ss, i, len);
              if (pos(x, ss) <> 0) then ok := true;
          end;
    end;
    if (ok = true) then write('YES')
    else write('NO');
end.