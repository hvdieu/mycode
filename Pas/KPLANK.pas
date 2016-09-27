Const   maxn = 1000001;
Var     n,i,j,res,top       :       longint;
        st,l,r,a      :       array [0..maxn] of longint;

begin
    // assign(input,'asd.inp'); reset(input);
    // assign(output,'asd.out'); rewrite(output);
     read(n);
     for i := 1 to n do read(a[i]);

     top := 1; l[1] := 1; st[1] := 1;
     for i := 2 to n do
       if a[i] > a[i-1] then
         begin
             l[i] := 1;
             inc(top); st[top] := i;
         end
       else
         begin
             while (top > 0) and (a[st[top]] >= a[i]) do dec(top);
             l[i] := i - st[top];
             inc(top); st[top] := i;
         end;
     top := 1; r[n] := 1; st[1] := n; st[0] := n+1;
     for i := n-1 downto 1 do
       if a[i] > a[i+1] then
         begin
             r[i] := 1;
             inc(top); st[top] := i;
         end
       else
         begin
             while (top > 0) and (a[st[top]] >= a[i]) do dec(top);
             r[i] := abs(i - st[top]);
             inc(top); st[top] := i;
         end;
     for i := 1 to n do
      if (r[i]+l[i]-1 >= a[i]) and (a[i] >= res) then res := a[i];
     write(res);
end.