Uses math;

Const   maxn = 751;
        maxt = 30001;

Var     n,k,t,res   :       longint;
        c,f       :       array [0..maxn,0..maxt] of longint;
        i,j,tt       :       longint;

procedure main;
var i,j : longint;
        begin
             for i := 0 to n+1 do
              for j := 0 to tt+1 do f[i,j] := -maxlongint;

             f[n div 2+1,1] := 0;
              for j := 1 to tt-1 do
               for i := 1 to n do
               begin
                   f[i-1,j+1] := max(f[i-1,j+1],f[i,j]+c[i-1,j+1]);
                   f[i+1,j+1] := max(f[i+1,j+1],f[i,j]+c[i+1,j+1]);
                   f[i,j+1] := max(f[i,j+1],f[i,j]+c[i,j+1]);
               end;
             for i := 1 to n do
              if f[i,tt] > res then res := f[i,tt];
             write(res);
        end;

begin
      assign(input,'MERE.INP'); reset(input);
      assign(output,'MERE.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do
        begin
            read(k);
            for j := 1 to k do
              begin
                  read(t);
                  if t > tt then tt := t;
                  inc(c[i,t]);
              end;
        end;
     main;
end.
