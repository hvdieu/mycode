uses math;
const
    inp = 'a.inp';
    out = 'a.out';
    oo = 1000000007;

var
    a,b : int64 ;
    res,tich : int64;
    i : longint;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(a,b);
     tich := 0;
     for i := 1 to a do
      tich := (tich + b*i) mod oo;
     for i := 1 to b-1 do
       begin
          res := (res + (tich*i) mod oo +(a*i) mod oo) mod oo;
       end;
     writeln(res);
end.