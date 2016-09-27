Const   maxn = 46;
Var     n,i,t,k     :       longint;
        f       :       array [0..maxn] of longint;

procedure khoitao;
var i : longint;
        begin
            f[0] := 1; f[1] := 1;
            for i := 2 to 45 do f[i] := f[i-1] + f[i-2];
        end;

procedure main;
var i : longint;
        begin
             i := n;
             repeat
                  if k <= f[i-2] then i := i-2
                   else
                     begin
                         k := k - f[i-2];
                         i := i-1;
                     end;
             until i < 2;
             if i = 0 then writeln('a')
              else writeln('b');
        end;

begin
      assign(input,'FIB1.INP'); reset(input);
      assign(output,'FIB1.OUT'); rewrite(output);
      readln(t);
      khoitao;
      while t > 0 do
        begin
            dec(t);
            readln(n,k);
            if n = 0 then writeln('a')
             else if n = 1 then writeln('b')
              else main;
        end;
end.
