Const   maxn = 17000;
Var     n,k,top,bot     :       longint;
        st,p,a      :       array [1..maxn] of longint;
        i,j,t     :   longint;

begin
   //  assign(input,'MINK.INP'); reset(input);
   //  assign(output,'MINK.OUT'); rewrite(output);
     readln(t);
     while t > 0 do
       begin
           dec(t);
           fillchar(st,sizeof(st),0);
           fillchar(p,sizeof(p),0);
           top := 0; bot := 1;
           readln(n,k);
           for i := 1 to n do read(a[i]);

           for i := 1 to k-1 do
             begin
                 while (top>=bot) and (st[top] >= a[i]) do dec(top);
                 inc(top);
                 st[top] := a[i]; p[top] := i;
             end;

           for i := 1 to n-k+1 do
             begin
                 while (top>=bot) and (st[top] >= a[i+k-1]) do dec(top);
                 inc(top); st[top] := a[i+k-1]; p[top] := i+k-1;
                 write(a[p[bot]],' ');
                 while (top>=bot) and (p[bot] <= i) do inc(bot);
             end;
           writeln;
       end;
end.