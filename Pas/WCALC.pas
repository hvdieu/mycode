Const   inp = '';
        out = '';
Var     fi,fo : text;
        b,n     :       int64;
        ts,ms,res   :       int64;
        m       :   longint;

BEGIN
        Assign(fi,inp); reset(fi);
        readln(fi,b,n);
        close(fi);
        ms := n*n;
        res := 0;
        For m := 1 to 2*n-1 do
          BEGIN
               ts := 2*b*m*n - b*m*m;
               if ts mod ms = 0 then inc(res);
          END;
        Assign(fo,out); rewrite(fo);
        write(fo,res);
        close(fo);

END.