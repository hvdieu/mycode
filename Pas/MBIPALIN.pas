Uses math;
Const   maxn = 20;
        maxm = 1000001;

Var     n,m     :       longint;
        f,g       :       array [0..maxm] of qword;
        res       :       qword;

{**************************************************************************}
procedure main;
var i,j,d,c,bound,x,sl,k,seed,base,tg : longint;
        begin
            n := n div 2;
            d := 1; c := 9; seed := 1;
            sl := n div 2;
            for i := 1 to sl do seed := (seed*10) mod m;
            for i := 1 to sl-1 do
              begin
                  d := d*10;
                  c := c*10+9;
              end;
            if n mod 2 = 1 then
              begin
                  d := d*10;
                  c := c*10+9;
              end;
            for i := d to c do
              begin
                  x := i; tg := 0;
                  if n mod 2 = 1 then x := x div 10;
                  for j := 1 to sl do
                    begin
                        tg := tg*10+x mod 10;
                        x := x div 10;
                    end;
                  k := ((int64(i) mod m)*int64(seed) + tg mod m) mod m;
                  inc(f[k]);
              end;
            g := f;
            c := d-1;
            for i := 0 to c do
              begin
                  x := i; tg := 0;
                  if n mod 2 = 1 then x := x div 10;
                  for j := 1 to sl do
                    begin
                        tg := tg*10+x mod 10;
                        x := x div 10;
                    end;
                  k := ((int64(i) mod m)*seed + tg mod m) mod m;
                  inc(g[k]);
              end;
            base := 1;
            for i := 1 to n do base := (base*10) mod m;
            for i := 0 to m-1 do
              begin
                  k := (m - (int64(i)*base) mod m) mod m;
                  res := res + f[i]*g[k];
              end;
            writeln(res);
        end;
{***************************************************************************}
procedure trau;
var i,j : longint;
        begin
            for i := 10 to 99 do
             if i mod m = 0 then inc(res);
            writeln(res);
        end;
{***************************************************************************}
begin
    // assign(input,'mbipalin.inp'); reset(input);
    // assign(output,'mbipalin.out'); rewrite(output);
     readln(n,m);
     if n = 2 then trau
      else main;
end.