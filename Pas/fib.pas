Const   inp = 'fib.inp';
        out = 'fib.out';
Var     fi,fo : text;
        a,b     :       int64;
        k,t       :       longint;

Function timx : int64;
Var i,j : longint;
        BEGIN

        END;

Procedure input;
Var st : longint;
      BEGIN
            assign(fi,inp); reset(fi);
            assign(fo,out); rewrite(fo);
            readln(fi,t);
            For st := 1 to t do
               BEGIN
                     readln(fi,a,b,k);
                     x := timx;
                     y := timy;
               END;
      END;