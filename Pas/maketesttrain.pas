Program Maketest;
Const inp = 'TRAIN.IN1';
Var m,n,d : integer;
   f : text;
   i,a,b,t : integer;
BEGIN
    assign(f,inp);rewrite(f);
    n:=random(5000);
    m:=random(10);
    d:=random(25);
    writeln(f,n,' ',m,' ',d);
    for i:=1 to d do
      BEGIN
         b:=random(m);
         a:=random(b);
         t:=random(n);
         writeln(f,a,' ',b,' ',t);
      END;
    close(f);

END.
