Const   inp = 'PYTHAEQ.INP';
        out = 'PYTHAEQ.OUT';

Var     fi,fo   :       text;
        r,temp,i,n,m       :       longint;
        res     :       qword;

BEGIN
      assign(fi,inp); reset(fi);
      assign(fo,out); rewrite(fo);
      readln(fi,r);
      close(fi);
      r := abs(r);
      if r = 0 then write(fo,1)
      else BEGIN
      temp := round(sqrt(r div 2))+1;
      res := 4;
      For i := 1 to temp do
        BEGIN
             n := sqr(i);
             m := r - n;
             if sqrt(m) = trunc(sqrt(m)) then res := res + 8;
        END;
      write(fo,res);
      END;
      close(fo);
END.
