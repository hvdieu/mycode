uses math;
Const
    inp = '';
    out = '';

Var
    a,b,c,r,p,s,gocA,gocB,gocC,AB,AC,BC,s2,res : double;

begin
    assign(input,inp) ;reset(input);
    assign(output,out); rewrite(output);
    readln(a,b,c,r);
    p := (a+b+c)/2;
    s := sqrt(p*(p-a)*(p-b)*(p-c));
    p := p*2;
    gocA := arccos((b*b+c*c-a*a)/(2*b*c));
    gocB := arccos((a*a+c*c-b*b)/(2*a*c));
    gocC := arccos((a*a+b*b-c*c)/(2*a*b));
    AC := r/tan(gocA/2)+r/tan(gocC/2);
    AB := r/tan(gocA/2)+r/tan(gocB/2);
    BC := r/tan(gocB/2)+r/tan(gocC/2);
    p := (AB+BC+AC)/2;
    s2 := sqrt(p*(p-AB)*(p-AC)*(p-BC));
    s2 := s2-r*r*pi;
    res := (s-s2)/s;
    writeln(res:0:15);
end.