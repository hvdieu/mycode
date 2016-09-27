const inp = 'ab.inp';
      out = 'ab.out';
      maxn = 100;
var   n,i :longint;
      a : array [1..maxn] of longint;
 begin
      assign(input,inp); reset(input);
      assign(output,out);rewrite(output);
      readln(n);
      for i := 1 to n do read(a[i]);
      for i := n downto 1 do write(a[i],' ');
 end.
