uses math;
Const   maxn = 4010;
Var     n,m,i,j,k     :       longint;
        f,g       :       array [0..maxn,0..maxn] of int64;
        a       :       array [1..maxn] of longint;
        s       :       array [0..maxn] of int64;
        temp    :       int64;

function tinh(i,j : longint) : int64;
var k : longint;
    res : int64;
        begin
            if f[i,j] <> -1 then exit(f[i,j]);
            if i = j then
              begin
                  f[i,j] := 0;
                  exit(0);
              end;
            res := -1 shl 50;
            for k := i to j-1 do
             begin
                 res := max(res,(s[k]-s[i-1])*(s[j]-s[k])+tinh(i,k)+tinh(k+1,j));
             end;
            f[i,j] := res;
            exit(res);

        end;

begin
      assign(input,'LEMON.INP'); reset(input);
      assign(output,'LEMON.OUT'); rewrite(output);
      readln(n,m);
      for i := 1 to n do
       begin
         read(a[i]);
         s[i] := s[i-1]+a[i];
       end;
      for i := 1 to n do
       for j := 1 to n do f[i,j] := -1;
      for i := 0 to n do
       for j := 0 to m do g[i,j] := 1 shl 50;
      g[0,0] := 0;
      for i := 1 to n do
        for j := 1 to min(i,m) do
          for k := i-1 downto j-1 do
           g[i,j] := min(g[i,j],g[k,j-1]+tinh(k+1,i));

      writeln(g[n,m]);
end.
