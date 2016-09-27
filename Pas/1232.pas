Const   maxn = 101;
        oo = 100000007;
Var     f      :       array [0..10001] of longint;
        n,t,i,st,j,k,x,y       :       longint;
        a       :       array [1..maxn] of longint;

procedure main;
var i,j : longint;
        begin
            fillchar(f,sizeof(f),0);
            f[0] := 1;
            for i := 1 to n do
              for j := 1 to k do
               if j - a[i] >= 0 then
                f[j] := (f[j] + f[j-a[i]]) mod oo;
            writeln(f[k]);
        end;

begin
      assign(input,'1232.inp'); reset(input);
      assign(output,'1232.out'); rewrite(output);
      readln(t);
      for st := 1 to t do
        begin
            write('Case ',st,': ');
            readln(n,k);
            for i := 1 to n do read(a[i]);
            main;
        end;
end.
