Uses math;
Const   inp = 'PERNALTY.INP';
        out = 'PERNALTY.OUT';
        maxn = 10001;

Var     n,k,s,x,y,top,bot,tmax,res,u,v,i : longint;
        a,f : array [0..100,-maxn..2*maxn] of longint;
        st,p : array [1..3*maxn] of longint;

procedure main;
var i,j : longint;
  begin
      inc(k);
      for i := 0 to tmax-1 do
        begin
            top := 0; bot := 1;
            for j := -k+2 to k-1 do
              begin
                  while (top>=bot) and (st[top]<=f[i,j]) do dec(top);
                  inc(top); st[top] := f[i,j]; p[top] := j;
              end;
            for j := 1 to n do
              begin
                  while (top>=bot) and (st[top]<=f[i,j+k-1]) do dec(top);
                  inc(top); st[top] := f[i,j+k-1]; p[top] := j+k-1;
                  f[i+1,j] := f[i,p[bot]]+a[i+1,j];
                  while (top>=bot) and (p[bot]<=j-k+1) do inc(bot);
              end;
        end;
      for j := 1 to n do res := max(Res,f[tmax,j]);
      writeln(Res);
  end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n,k,s);
     for i := 1 to s do
       begin
           readln(u,v);   tmax := max(tmax,u);
           inc(a[u,v]);
       end;
     main;
end.