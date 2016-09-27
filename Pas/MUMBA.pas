Const   maxn = 16;
        res     :       array [1..maxn] of longint = (2,3,4,5,7,7,8,10,9,9,9,9,10,11,5,2);
Var     n       :       longint;

begin
     assign(input,'MUMBA.INP'); reset(input);
     assign(output,'MUMBA.OUT'); rewrite(output);
     readln(n);
     if n >= 17 then write(0) else write(res[n]);
end.