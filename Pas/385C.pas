uses math;
Const   maxn = 100001;
        maxp = 10000001;
        inp = '';
        out = '';

Var     n,i,j,x,maxx,m,l,r   :       longint;
        dem     :       array [1..maxp] of longint;
        s,f       :       array [0..maxp] of int64;
        prime   :       array [1..maxp] of boolean;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n);
     for i := 1 to n do
      begin
          read(x);
          maxx := max(x,maxx);
          inc(dem[x]);
      end;
     fillchar(prime,sizeof(prime),true);
     for i := 2 to maxx do
      begin
      if prime[i] then
       begin
          j := 1;
          while i*j <= maxx do
            begin
                prime[i*j] := false;
                inc(f[i],dem[i*j]);
                inc(j);
            end;
       end;
      end;
     for i := 2 to 10000000 do s[i] := s[i-1]+f[i];
     readln(m);
     for i := 1 to m do
      begin
          readln(l,r);
          if l > maxx then writeln(0)
           else if (r <= maxx) then writeln(s[r]-s[l-1])
            else writeln(s[maxx]-s[l-1]);
      end;
end.