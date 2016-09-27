Const   maxn = 1000001;
Var     ra,vao  :       array [0..maxn] of longint;
        s       :       ansistring;
        res,n,i     :       longint;

begin
   //  assign(input,'asd.inp'); reset(input);
   //  assign(output,'asd.out'); rewrite(output);
     readln(s);
     n := length(s);
     for i := 1 to n do
      if s[i] = '0' then
       begin
           inc(ra[i-1]); inc(vao[i mod n]);
       end
      else begin
          inc(ra[i mod n]); inc(vao[i-1]);
      end;
     for i := 0 to n-1 do
       if (ra[i] = 2) or (vao[i] = 2) then inc(res);
     res := res - 1;
     if res = 0 then write(1)
      else write(res);
end.
