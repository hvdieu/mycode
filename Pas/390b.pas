Const   inp = '';
        out = '';
        maxn = 100001;

Var     res     :       int64;
        n,i       :       longint;
        a,b     :       array [1..maxn] of int64;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(n);
    for i := 1 to n do read(a[i]);
    for i := 1 to n do read(b[i]);
    res := 0;
    for i := 1 to n do
     if b[i]=1 then dec(res) else
      begin
          if 2*a[i]<b[i] then dec(res)
           else
            begin
                res := res + (b[i] div 2)*(b[i]-b[i] div 2);
            end;
      end;
    writeln(res);
end.