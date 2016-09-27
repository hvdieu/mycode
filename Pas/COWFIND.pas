Var     s       :       string;
        i,j,dem1,dem2,n : longint;
        res     :       int64;

begin
     assign(input,'COWFIND.INP'); reset(input);
     assign(output,'COWFIND.OUT'); rewrite(output);
     readln(s);
     n := length(s);
     for i := n-1 downto 1 do
      if (s[i] = ')') and (s[i+1] = ')') then inc(dem2);

     for i := 2 to n do
      begin
          if (s[i] = '(') and (s[i-1]='(') then inc(res,dem2);
          if (s[i] = ')') and (s[i-1] = ')') then dec(dem2);
      end;
     writeln(Res);
end.