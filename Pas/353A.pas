Const   maxn = 110;
Var     x,y     :       array [1..maxn] of integer;
        n,i,s1,s2     :       longint;
        ok      :     boolean;

begin
     // assign(input,'asd.inp'); reset(input);
     // assign(output,'asd.out'); rewrite(output);
      readln(n);
      for i := 1 to n do
        begin
             read(x[i],y[i]);
             inc(s1,x[i]); inc(s2,y[i]);
        end;
      if (s1 mod 2 = 0) and (s2 mod 2 = 0) then write(0)
       else if (s1 mod 2 + s2 mod 2 = 1) then write(-1)
        else
         begin
             for i := 1 to n do
              if (x[i] mod 2 + y[i] mod 2 = 1) then ok := true;
             if ok then write(1)
              else write(-1);
         end;
end.