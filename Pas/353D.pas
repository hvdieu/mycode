{$H+}
Const   maxn = 1000001;
Var     s       :       ansistring;
        n,i,d,c,dem,res     :       longint;

begin
     assign(input,'asd.inp'); reset(input);
     assign(output,'asd.out'); rewrite(output);
     read(s);
     n := length(s);
     d := 1; c := n;
     while (d < n) and (s[d] = 'F') do inc(d);
     while (c > 1) and (s[c] = 'M') do dec(c);
     dem := -1;
     for i := d to c do
       begin
            if s[i] = 'M' then
              begin
                  inc(res);
                  if dem > -1 then dec(dem);
              end
            else inc(dem);
       end;
     if d > c then write(0)
      else write(res+dem);
end.