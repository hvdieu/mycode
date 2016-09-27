Uses math;
Const   maxn = 50;
Var     a       :       array [1..maxn] of longint;
        b       :       array [1..4] of longint;
        f       :       array [0..maxn,1..4] of int64;
        res     :       int64;
        n,w,i     :       longint;

procedure main;
var i,j,t,cp : longint;
        begin
              for i := 0 to n do
               for j := 1 to 4 do
                 f[i,j] := 1 shl 50;

              for i := 1 to 4 do f[1,i] := abs(a[1]-b[i])+w*2;
              for i := 2 to n do
                for j := 1 to 4 do
                 begin
                      for t := 1 to 4 do
                       begin
                         if j=t then cp := abs(a[i]-b[j]) + w
                          else cp := abs(a[i]-b[j])+w*3;
                         f[i,j] := min(f[i,j], f[i-1,t] + cp);
                       end;
                 end;
              res := 1 shl 50;
              for i := 1 to 4 do
               if res > f[n,i] then res := f[n,i];
              writeln(res);
        end;

begin
      assign(input,'FAX.INP'); reset(input);
      assign(output,'FAX.OUT'); rewrite(output);
      readln(n,w);
      for i := 1 to n do read(a[i]);
      b[1] := 1; b[2] := 86; b[3] := 172; b[4] := 256;
      main;
end.