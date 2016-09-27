Const   maxn = 1000;
Var     n,i,x,r5,r0,s       :       longint;
        dem     :       array [0..5] of longint;

begin
   //  assign(input,'A.inp'); reset(input);
   //  assign(output,'A.out'); rewrite(output);
     read(n);
     for i := 1 to n do
      begin
          read(x); inc(dem[x]);
      end;
     for i := 1 to dem[5] do
      begin
          s := s + 5;
          if s mod 9 = 0 then r5 := i;
      end;
     if (dem[0] = 0) then write(-1)
      else if (r5 = 0) and (dem[0] > 0) then write(0)
       else if (r5 > 0) then
        begin
            for i := 1 to r5 do write(5);
            for i := 1 to dem[0] do write(0);
        end;
end.
