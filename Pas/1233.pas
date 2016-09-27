Const   maxn = 101;
        maxm = 100001;
Var     a,c     :       array [1..maxn] of longint;
        f       :       array [0..maxm] of boolean;
        b       :       array [0..maxm] of longint;
        n,m,t,st,res,i        :       longint;

procedure main;
var i,j : longint;
        begin
            fillchar(f,sizeof(f),false);
            f[0] := true;
            res := 0;
            for i := 1 to n do
              begin
                  fillchar(b,sizeof(b),0);
                  for j := 1 to m do
                  if j - a[i] >= 0 then
                   if (f[j] = false) and (f[j-a[i]] = true) and (b[j-a[i]] < c[i]) then
                     begin
                         f[j] := true; inc(res);
                         b[j] := b[j-a[i]]+1;
                     end;
              end;
            writeln(res);
        end;

begin
      assign(input,'1233.inp'); reset(input);
      assign(output,'1233.out'); rewrite(output);
      readln(t);
      for st := 1 to t do
       begin
           write('Case ',st,': ');
           readln(n,m);
           for i := 1 to n do read(a[i]);
           for i := 1 to n do read(c[i]);
           main;
       end;
end.