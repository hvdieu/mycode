Uses math;
Const   inp = 'KDIFF.INP';
        out = 'KDIFF.OUT';
        maxn = 300001;

Var     n,i,k,top1,bot1,top2,bot2,res : longint;
        a,p1,p2,f,g : array [1..maxn] of longint;

function check(j : longint) : boolean;
var t1,t2 : longint;
  begin
      t1 := min(a[p1[bot1]],a[j]);
      t2 := max(a[p2[bot2]],a[j]);
      if t2-t1>k then exit(false)
       else exit(true);
  end;

procedure push(j : longint);
  begin
      while (top1>=bot1) and (a[p1[bot1]]>=a[j]) do dec(top1);
      inc(top1); p1[top1] := j;
      while (top2>=bot2) and (a[p2[bot2]]<=a[j]) do dec(top2);
      inc(top2); p2[top2] := j;
  end;

procedure pop(i : longint);
  begin
      while (top1>=bot1) and (p1[bot1]<=i) do inc(bot1);
      while (top2>=bot2) and (p2[bot2]<=i) do inc(bot2);
  end;

procedure main;
var i,j : longint;
  begin
      j := 2;
      bot1 := 1; bot2 := 1;
      top1 := 1; top2 := 1;
      p1[1] := 1; p2[1] := 1;
      for i := 1 to n do
        begin
           while (j<=n) and (check(j)) do
             begin
                 push(j);
                 inc(j);
             end;
           f[i] := j-i;
           pop(i);
        end;
      g[n] := f[n];
      for i := n-1 downto 1 do g[i] := max(g[i-1],f[i]);
      for i := 1 to n do res := max(res,f[i]+g[i+f[i]]);
      writeln(res);
  end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n,k);
     for i := 1 to n do read(a[i]);
     main;
end.
