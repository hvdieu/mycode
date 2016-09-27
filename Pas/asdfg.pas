const   inp = 'ab.inp';
        out = 'ab.out';
var     a,n,s,i :longint;
begin
    assign(input,inp);reset(input);

    assign(output,out);rewrite(output);
    readln(a,n);
    s:=1;
    for i:=1 to n do
    s:=s*a;
    write(s);
end.
