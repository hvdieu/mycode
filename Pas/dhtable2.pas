{$Coperators ON}
Uses math;
Const
    inp = 'input.txt';
    out = 'output.txt';

Var
    s, ss : string;
    n, i, j : longint;
    t, l, r, mid, ans : int64;

function count(x : int64) : int64;
    var i : longint;
        y, sum, mu : int64;
        s : string;
begin
    sum := 0; mu := 9; y := 0;
    str(x, s);
    for i := 1 to length(s)-1 do
      begin
          sum += mu * i;
          if (sum > t) then exit(sum);
          mu *= 10;
          y := y*10 + 9;
      end;
    x -= y;
    sum += x*length(s);
    exit(sum);
end;

begin
   // assign(input, inp); reset(input);
   // assign(output, out); rewrite(output);
    read(n); read(t);
    if (t <= n) then
      begin
          for i := 1 to n-t do write(' ');
          s := '';
          j := 0;
          while (length(s) <= t) do
            begin
                inc(j);
                str(j, ss);
                s := s + ss;
            end;
          write(copy(s, 1, t));
      end
    else begin
          t -= n;
          l := 1; r := 1000000000000000;
          while (l <= r) do
            begin
                mid := (l + r) div 2;
                if (count(mid) <= t) then
                  begin
                     ans := mid; l := mid + 1;
                  end
                else r := mid - 1;
            end;
          t -= count(ans);
          s := '';
          while (length(s) <= t+n+1) do
            begin
                inc(ans);
                str(ans, ss);
                s := s + ss;
            end;
          writeln(copy(s, t+1, n));
    end;
end.
