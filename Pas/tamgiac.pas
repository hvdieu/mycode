const  inp='tamgiac.in';
       out='tamgiac.out';
var a,b,c:integer;
        p,s:real;
begin
  assign(input,inp);reset(input);
  assign(output,out);rewrite(output);
 read(a);
 read(b);
 read(c);
 p:=(a+b+c)/2;
 s:=sqrt(p*(p-a)*(p-b)*(p-c));
 write(s);
end.