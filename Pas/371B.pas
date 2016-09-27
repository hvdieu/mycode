Var     m1,m2      :       array [1..5] of longint;
        a,b,res     :       longint;

begin
        readln(a,b);
        while a mod 2 = 0 do
          begin
              inc(m1[2]);
              a := a div 2;
          end;
        while a mod 3 = 0 do
          begin
              inc(m1[3]);
              a := a div 3;
          end;
        while a mod 5 = 0 do
          begin
              inc(m1[5]);
              a := a div 5;
          end;

        while b mod 2 = 0 do
          begin
              inc(m2[2]);
              b := b div 2;
          end;
        while b mod 3 = 0 do
          begin
              inc(m2[3]);
              b := b div 3;
          end;
        while b mod 5 = 0 do
          begin
              inc(m2[5]);
              b :=b div 5;
          end;
        if a <> b then write(-1)
         else
          begin
              res := res + abs(m1[2]-m2[2]);
              inc(Res,abs(m1[3]-m2[3]));
              inc(res,abs(m1[5]-m2[5]));
              write(res);
          end;
        readln;

end.