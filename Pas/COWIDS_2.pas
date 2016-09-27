Uses math;
Const   maxn = 501;
Var     n,i,k,dem,j,m   :       longint;
        f,g       :       array [0..maxn,0..maxn] of longint;
        res       :       array [1..maxn] of longint;

procedure truyvet(i,j : longint);
        begin
            inc(m);
            if i = 1 then
             begin
              if j = 1 then res[m] := 1
               else res[m] := 0;
              exit;
             end;
            if n <= f[i-1,j] then
              begin
                  res[m] := 0;
                  truyvet(i-1,j);
              end
            else begin
                      res[m] := 1;
                      n := n - f[i-1,j];
                      truyvet(i-1,j-1);
                 end;
        end;

procedure main;
var i,j : longint;
        begin
             g[1,1] := 1;
             f[0,0] := 1;
             f[1,1] := 1;
             f[1,0] := 1;
             for i := 2 to 30 do
              for j := 1 to min(k,i) do
               begin
                   g[i,j] := g[i-1,j] + f[i-1,j-1];
                   f[i,j] := f[i-1,j] + f[i-1,j-1];
               end;
             i := k;
             while g[i,k] < n do inc(i);
             res[1] := 1; m := 1;
             n := n - g[i-1,k];
             truyvet(i-1,k-1);
             for j := 1 to i do write(res[j]);
        end;

begin
      assign(input,'cowids.inp'); reset(input);
      assign(output,'cowids.out'); rewrite(output);
      readln(n,k);
      if k = 1 then
        begin
            write(1);
            for i := 1 to n-1 do write(0);
        end
      else if k = 2 then
        begin
            write(1);
            dem := 1; i := 0;
            while dem < n do
              begin
                  inc(i);
                  dem := dem+i;
              end;
            dec(dem,i);
            n := n-dem;
            for j := 1 to i-n do write(0);
            write(1);
            for j := 1 to n-1 do write(0);
        end
      else main;
end.