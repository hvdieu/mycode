Const   inp = 'palnums.in';
        out = 'palnums.out';
Var     fi,fo : text;
        x       :       array [1..7] of integer;
        nn       :       string;
        dd,d,sum1,sum2       :       integer;
        n,num1,num2,res : qword;
        s : longint;

Procedure input;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,nn); readln(fi,s);
              close(fi);
        END;

Procedure xuly(k : integer);
Var u,t : integer;
        BEGIN
               if (2*sum1) mod s = 0 then
                  BEGIN
                       if 2*k < dd then inc(res)
                         else if 2*k = dd then
                           BEGIN
                                num2 := num1;
                                For u := k downto 1 do num2 := num2*10+x[u];
                                if num2 <= n then inc(res);
                           END;
                  END;
               if (2*sum1-x[k]) mod s = 0 then
                  BEGIN
                       if 2*k-1 < dd then inc(res)
                         else if 2*k-1 = dd then
                           BEGIN
                                num2 := num1;
                                For u := k-1 downto 1 do num2 := num2*10+x[u];
                                if num2 <= n then inc(res);
                           END;
                  END;

        END;

Procedure Try(i,k : integer);
Var j : integer;
        BEGIN
              if i = 1 then
                BEGIN
                     For j := 1 to 9 do
                         BEGIN
                               x[i] := j;
                               sum1 := sum1 + j;
                               num1 := num1 * 10 + j;
                               if i <= k then xuly(i);
                               if i < k then Try(i+1,k);
                               sum1 := sum1 - j;
                               num1 := num1 div 10;
                         END;
                END
              else
                BEGIN
                     For j := 0 to 9 do
                         BEGIN
                               x[i] := j;
                               sum1 := sum1 + j;
                               num1 := num1 * 10 + j;
                               if i <= k then xuly(i);
                               if i < k then try(i+1,k);
                               sum1 := sum1 - j;
                               num1 := num1 div 10;
                         END;
                END;
        END;

Procedure main;
Var k,i : integer;
    ch : char;
        BEGIN
              dd := length(nn);
              Val(nn,n);
              if dd mod 2 = 1 then d := dd div 2 + 1
                else d := dd div 2;
              res := 0;
               BEGIN
                  sum1 := 0; sum2 := 0;
                  num1 := 0; num2 := 0;
                  Try(1,d);
               END;

        END;

Procedure output;
        BEGIN
              assign(fo,out); rewrite(fo);
              write(fo,res);
              close(fo);
        END;

BEGIN
      input;
      main;
      output;
END.
