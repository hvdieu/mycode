Uses math;
Const   maxn = 100010;

Var     n,i     :       longint;
        a     :       array [0..maxn] of int64;
        f,d     :       array [1..2,0..maxn] of int64;
        res,sum,s,dem     :       int64;

procedure main;
var i,j : longint;
        begin
            f[1,n+1] := 1 shl 62;
            f[2,n+1] := - 1 shl 62;
            for i := n downto 1 do
              begin
                  s := s + a[i];
                  if f[1,i+1] > s then
                    begin
                        f[1,i] := s; d[1,i] := 1;
                    end
                  else if f[1,i+1] = s then
                    begin
                        f[1,i] := s; d[1,i] := d[1,i+1]+1;
                    end
                  else
                    begin
                        f[1,i] := f[1,i+1]; d[1,i] := d[1,i+1];
                    end;

                  if f[2,i+1] < s then
                    begin
                        f[2,i] := s; d[2,i] := 1;
                    end
                  else if f[2,i+1] = s then
                    begin
                        f[2,i] := s; d[2,i] := d[2,i+1]+1;
                    end
                  else
                    begin
                        f[2,i] := f[2,i+1]; d[2,i] := d[2,i+1];
                    end;
              end;
            s := 0;
            for i := 1 to n-1 do
              begin
                  s := s + a[i];
                  if f[1,i+1] = f[2,i+1] then
                    begin
                         if res < abs(s - f[1,i+1]) then
                           begin
                               res := abs(s - f[1,i+1]);
                               dem := d[1,i+1];
                           end
                         else if res = abs(s-f[1,i+1]) then inc(dem,d[1,i+1]);
                    end
                  else
                     begin
                         if res < abs(s-f[1,i+1]) then
                           begin
                               res := abs(s-f[1,i+1]);
                               dem := d[1,i+1];
                           end
                         else if res = abs(s-f[1,i+1]) then inc(dem,d[1,i+1]);

                        if res < abs(s-f[2,i+1]) then
                          begin
                              res := abs(s-f[2,i+1]);
                              dem := d[2,i+1];
                          end
                        else if res = abs(s-f[2,i+1]) then inc(dem,d[2,i+1]);
                     end;
              end;
            writeln(res,' ',dem);
        end;

begin
     assign(input,'DSEQ.INP'); reset(input);
     assign(output,'DSEQ.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n do read(a[i]);
     main;
end.
