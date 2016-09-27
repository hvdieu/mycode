Const   maxn = 100001;
Var     n,i,j,d,c       :       longint;
        s       :       ansistring;
        ok      :       boolean;

begin
   //  assign(input,'asd.inp'); reset(input);
   //  assign(output,'asd.out'); rewrite(output);
     readln(s);
     n := length(s);
     if n <> 1 then
     begin
        i := 1;
        ok := true;
        while i <= n do
          begin
              while s[i] = '-' do inc(i);
              d := i;
              while s[i] = '+' do inc(i);
              c := i-1;
              if c-d > 0 then
               for j := d to c do s[j] := '-';
          end;
        for i := 1 to n do
         if s[i] = '+' then ok := false;
     end;
     if ok then write('Yes')
      else write('No');
end.

