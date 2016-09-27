Const   inp = 'asd.inp';
        out = 'asd.out';
        maxn = 100001;

Var     n,w,k,l,r,x,res,i   :       longint;
        a       :       array [1..maxn] of integer;
        f,g     :       array [-maxn..maxn] of longint;
        ch      :       char;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);





     readln(n,k,w);
     for i := 1 to n do
      begin
          read(ch);
          if ch='1' then inc(a[i]);
      end;
     readln;
     for i := 1 to n do f[i] := f[i-1]+a[i];
     for i := k to n do g[i] := g[i-k]+a[i];
     for i := 1 to w do
       begin
           readln(l,r);
           x := (r-l+1) div k;
           res := 0;
           res := res + f[r]-f[l-1];
           res := res + x;
           res := res-2*(g[r]-g[l-1]);
           writeln(res);
       end;
end.
