Const   inp = 'matrix.inp';
        out = 'matrix.out';
        maxn = 21;
Type    arr     =       array [1..maxn,1..maxn] of longint;
Var     fi,fo   :       text;
        n,k     :       longint;
        a,res,b       :       array [1..maxn,1..maxn] of longint;


Function cong(a,b : arr) : arr;
Var i,j : longint;
    c : arr;
        BEGIN
              For i := 1 to n do
                For j := 1 to n do
                  BEGIN
                        c[i,j] := a[i,j] + b[i,j];
                        c[i,j] := c[i,j] mod 10;
                  END;
              cong := c;
        END;

Function nhan(a,b : arr) : arr;
Var i,j,k : longint;
    c : arr;
        BEGIN
              fillchar(c,sizeof(c),0);
              For i := 1 to n do
                For j := 1 to n do
                  BEGIN
                       c[i,j] := 0;
                       For k := 1 to n do
                       c[i,j] :=(c[i,j] + (a[i,k] * b[k,j])) mod 10;
                  END;
              nhan := c;
        END;

Procedure sub1;
Var i,j : longint;
        BEGIN
              res := a;
              b := a;
              For i := 2 to k do
                 BEGIN
                      b := nhan(a,b);
                      res := cong(res,b);
                 END;
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

Function sum(a : arr; b : longint) : arr;
Var tmp,c,res : arr;
        BEGIN
             if b = 1 then exit(a)
               else
                 BEGIN
                       if b mod 2 = 0 then
                         BEGIN
                              tmp := sum(a,b div 2);
                              c := pow(a,b div 2);
                              c := nhan(c,tmp);
                              exit(cong(c,tmp));
                         END
                           else if b mod 2 = 1 then
                         BEGIN
                              tmp := sum(a,b div 2);
                              c := pow(a,b div 2 + 1);
                              fillchar(res,sizeof(res),0);
                              res := cong(c,tmp);
                              tmp := nhan(c,tmp);
                              res := cong(tmp,res);
                              exit(res);
                         END;
                 END;
        END;

procedure sub3;
        BEGIN
                 res := sum(a,k);
        END;

Procedure input;
Var i,j : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,n,k);
              For i := 1 to n do
               BEGIN
                  For j := 1 to n do
                    BEGIN
                      read(fi,a[i,j]);
                      a[i,j] := a[i,j] mod 10;
                    END;
                  readln(fi);
               END;
              if k <= 100 then sub1
                else sub3;
        END;


Procedure output;
Var i,j : longint;
        BEGIN
             assign(fo,out); rewrite(fo);
             For i := 1 to n do
                 BEGIN
                      For j := 1 to n do write(fo,res[i,j],' ');
                      writeln(fo);
                 END;
             close(fo);

        END;
BEGIN
      input;
      output;
END.