Const   maxn = 101;
Var     cung    :       array [0..2*maxn,0..2*maxn] of boolean;
        f       :       array [0..2*maxn,0..2*maxn] of longint;
        l,i,j,k,x,y,t,ts,res,n,left,right :       longint;

begin
      assign(input,'planset.inp'); reset(input);
      assign(output,'planset.out'); rewrite(output);
      readln(n);
      for i := 1 to n do
        begin
            read(x,y);
            cung[x,y] := true; cung[y,x] := true;
        end;
      for l := 2 to 2*n do
        begin
            for i := 0 to 2*n do
              begin
                  j := i+l-1;
                  left := i; right := j;
                  if j > 2*n-1 then j := j - 2*n;
                  if cung[i,j] then ts := 1
                   else ts := 0;
                  for k := left to right-1 do
                     begin
                         t := k;
                         if k > 2*n-1 then t := k-2*n;
                         if f[i,j] < f[i,t] + f[t+1,j] + ts then
                          f[i,j] := f[i,t] + f[t+1,j] + ts;
                     end;
                  if f[i,j] > res then res := f[i,j];
              end;
        end;
      write(res);
end.