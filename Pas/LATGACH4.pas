Const   inp = '';
        out = '';
Type    arr = array [1..2,1..2] of int64;
Var     fi,fo : text;
        a,kq       :       array [1..2,1..2] of int64;
        t,n,st     :       longint;
        i,base       :       longint;

Function nhan(a,b : arr) : arr;
Var i,j,k : longint;
    c : arr;
        BEGIN
              fillchar(c,sizeof(c),0);
              For i := 1 to 2 do
                For j := 1 to 2 do
                  BEGIN
                       c[i,j] := 0;
                       For k := 1 to 2 do
                       c[i,j] :=(c[i,j] + (a[i,k] * b[k,j])) mod base;
                  END;
              nhan := c;
        END;


Function pow(a : arr; b : longint) : arr;
Var tmp : arr;
        BEGIN
              if b = 1 then exit(a)
                  else if b mod 2 = 0 then
                      BEGIN
                           tmp := pow(a,b div 2);
                           exit(nhan(tmp,tmp));
                      END
                        else
                      BEGIN
                           tmp := pow(a,b div 2);
                           tmp := nhan(tmp,tmp);
                           exit(nhan(tmp,a));
                      END;

        END;


BEGIN
      assign(fi,inp); reset(fi);
      assign(fo,out); rewrite(fo);
      readln(fi,t);
      base := 111539786;
      a[1,1] := 0; a[1,2] :=1; a[2,1] := 1; a[2,2] := 1;
      For st := 1 to t do
        BEGIN
             readln(fi,n);
             kq := pow(a,n+1);
             writeln(fo,kq[1,2]);

        END;
      close(fi); close(fo);
END.
