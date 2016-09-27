Var     m,n,k,i,t,res,count   :       longint;
        a       :       array [1..1000] of integer;

begin
   //  assign(input,'asd.inp'); reset(input);
   //  assign(output,'asd.out'); rewrite(output);
     readln(n,m,k);
     for i := 1 to n do
      begin
          read(t);
          if t = 1 then
           if m = 0 then inc(res)
            else dec(m);
          if t = 2 then
           if (k > 0) then dec(k)
            else if m > 0 then dec(m)
             else inc(res);
      end;
     writeln(res);
end.
