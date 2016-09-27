Const   maxn = 100001;
Var     pos     :       array [0..maxn] of longint;
        ok      :       boolean;
        n,i,dem,x     :       longint;

begin
    //  assign(input,'asd.inp'); reset(input);
    //  assign(output,'asd.out');rewrite(output);
      readln(n);
      for i := 0 to n-1 do
       begin
           read(x);
           pos[x] := i;
           if x = i then inc(dem);
       end;
      for i := 0 to n-1 do
       begin
           if pos[i] <> i then
            begin
                if pos[pos[i]] = i then ok := true;
            end;
       end;
      if dem = n then write(dem)
       else if ok then write(dem+2)
        else write(dem+1);

end.