Const   maxn = 55;
        maxt = 1010;
Var     a,c     :       array [1..maxn] of longint;
        i,n,t,st,k,m,j     :       longint;
        f       :       array [0..maxn,0..maxt] of int64;
        oo      :       qword;

procedure main;
var i,j,s,dem,sum,x : longint;
        begin
             fillchar(f,sizeof(f),0);
             f[0,0] := 1;
             for i := 1 to n do
             begin
              for j := k downto 0 do
                begin
                  f[i,j] := (f[i,j] + f[i-1,j]) mod oo;
                  for x := 1 to c[i] do
                   if j - a[i]*x >= 0 then
                   f[i,j] := (f[i,j] + f[i-1,j-a[i]*x]) mod oo;
                end;
             end;
             writeln(f[n,k]);
        end;

begin
    // assign(input,'1231.inp'); reset(input);
    // assign(output,'1231.out'); rewrite(output);
     readln(t);
     oo := 100000007;
     for st := 1 to t do
       begin
           write('Case ',st,': ');
           readln(n,k);
           for i := 1 to n do read(a[i]);
           for i := 1 to n do read(c[i]);
           main;
       end;
end.