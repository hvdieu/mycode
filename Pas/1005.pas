Const   maxn = 31;
Var     n,k,i,t,tt,j   :       longint;
        f       :       array [0..maxn,0..maxn*maxn] of qword;

begin
    //  assign(input,'1005.inp'); reset(input);
    //  assign(output,'1005.out'); rewrite(output);
      readln(t);
      for tt := 1 to t do
        begin
            readln(n,k);
            write('Case ',tt,': ');
            if n < k then writeln(0)
            else
            begin
            fillchar(f,sizeof(f),0);
            for i := 1 to n do
             f[i,0] := 1;
            f[1,1] := n;
            for i := 2 to n do
             for j := 1 to k do
              f[i,j] := f[i-1,j] + f[i-1,j-1]*(n-j+1);
            writeln(f[n,k]);
            end;
        end;
end.