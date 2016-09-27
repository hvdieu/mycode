Uses math;
Const   maxn = 21;
Var     t,n,st,i,j,res  :       longint;
        a       :       array [1..maxn,1..3] of longint;
        f       :       array [1..maxn,1..3] of longint;

procedure main;
var i,j,k,u : longint;
        begin
             fillchar(f,sizeof(f),0);
             for i := 1 to 3 do
                f[1,i] := a[1,i];
             for i := 2 to n do
               for k := 1 to 3 do
                f[i,k] := 999999999;

              for i := 2 to n do
                for j := 1 to 3 do
                 for t := 1 to 3 do
                  if j <> t then
                   f[i,j] := min(f[i,j],f[i-1,t] + a[i,j]);
              res := maxlongint;
               for j := 1 to 3 do
                 if f[n,j] < res then res := f[n,j];
              writeln(res);

        end;

begin
     // assign(input,'1047.inp'); reset(input);
     // assign(output,'1047.out'); rewrite(output);
      readln(t);
      for st := 1 to t do
        begin
            write('Case ',st,': ');
            readln(n);
            for i := 1 to n do
             for j := 1 to 3 do read(a[i,j]);
            main;
        end;
end.