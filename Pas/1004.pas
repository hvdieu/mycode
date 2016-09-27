Uses math;
Const   maxn = 201;
Var     a,f       :       array [0..maxn,0..maxn] of longint;
        dem       :       array [0..maxn] of longint;
        i,j,n,t,tt,sl       :       longint;

begin
    //  assign(input,'1004.inp'); reset(input);
    //  assign(output,'1004.out'); rewrite(output);
      readln(t);
      for tt := 1 to t do
        begin
            readln(n);
            fillchar(a,sizeof(a),0);
            for i := 1 to n do
             begin
              for j := 1 to i do read(a[i,j]);
              dem[i] := i;
             end;
            sl := n;
            for i := n+1 to 2*n-1 do
              begin
                  dec(sl);
                  for j := 1 to sl do read(a[i,j]);
                  dem[i] := sl;
              end;
            fillchar(f,sizeof(f),0);
            f[1,1] := a[1,1];
            for i := 2 to n do
             for j := 1 to i do
               f[i,j] := max(f[i-1,j],f[i-1,j-1]) + a[i,j];

            for i := n+1 to 2*n-1 do
             for j := 1 to dem[i] do
              f[i,j] := max(f[i-1,j],f[i-1,j+1]) + a[i,j];
            writeln('Case ',tt,': ',f[2*n-1,1]);
        end;
end.

