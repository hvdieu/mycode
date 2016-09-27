Uses math;
Const
    inp = 'BLSUMSEQ.INP';
    out = 'BLSUMSEQ.OU1';
    maxn = 100;
    oo = int64(1) shl 32;

Var
    n,q,i,u,v,k,x,dem,j,ii : longint;
    a : array [1..maxn] of longint;
    dp : array [0..10000] of int64;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n,q);
     for i := 1 to n do read(a[i]);
     for ii := 1 to q do
       begin
          readln(k,u,v,x);
          fillchar(dp,sizeof(dp),0);
          dp[0] := 1;
          for i := u to v do
           for j := 10000 downto a[i] do
            dp[j] := (dp[j] + dp[j-a[i]]) mod oo;
          if k = 1 then writeln(dp[x])
           else begin
             dem := 0;
             for i := 1 to 100000 do
             begin
              if (i <= 10000) and (dp[i] = 0) then inc(dem);
              if (i > 10000) then inc(dem);
              if dem=x then begin writeln(i); break; end;
             end;
           end;
       end;
end.
