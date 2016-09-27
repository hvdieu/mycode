Const   maxn = 100005;
Var     i,j,n,d,c    :       longint;
        a       :       array [1..maxn] of string;
        s       :       string;

begin
     assign(input,'asd.inp'); reset(input);
     assign(output,'asd.out'); rewrite(output);
     readln(n);
     for i := 1 to n do readln(a[i]);
     readln(s);
     j := 1;
     d := 1;
     while d <= length(s) do
       begin
           while s[d] <> '<' do inc(d);
           while s[d] <> '3' do inc(d);
       end;
end.