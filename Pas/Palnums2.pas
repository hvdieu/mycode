Const   inp = 'palnums.in';
        out = 'palnums.out';
Var     fi,fo : text;
        x       :       array [1..6] of char;
        n       :       string;
        s,d       :       longint;
        res : int64;

Procedure input;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,n); readln(fi,s);
              close(fi);
        END;
Function cmp(a,b : string) : integer;
        BEGIN
            While length(a) < length(b) do a := '0' + a;
            While length(a) > length(b) do b := '0' + b;
            if a > b then exit(1)
              else if a = b then exit(0)
               else exit(-1);
        END;

Procedure xuly(k : integer);
Var u,sum1,sum2,t : integer;
    s1,s2 : string;
        BEGIN
              s1 := ''; sum1 := 0; sum2 := 0;
              For u := 1 to k do
                BEGIN
                  s1 := s1 + x[u];
                  val(x[u],t);
                  sum1 := sum1 + t;
                END;
              s2 := s1; sum2 := sum1;
              For u := k downto 1 do s1 := s1 + x[u];
              sum1 := sum1 * 2;
              For u := k-1 downto 1 do
                BEGIN
                  s2 := s2 + x[u];
                  val(x[u],t);
                  sum2 := sum2 + t;
                END;
              if (cmp(s1,n) = -1) and (sum1 mod s = 0) then inc(res);
              if (cmp(s2,n) = -1) and (sum2 mod s = 0) then inc(res);

        END;

Procedure Try(i,k : integer);
Var j : char;
        BEGIN
              if i = 1 then
                BEGIN
                     For j := '1' to '9' do
                         BEGIN
                               x[i] := j;
                               if i = k then xuly(k)
                                 else Try(i+1,k);
                         END;
                END
              else
                BEGIN
                     For j := '0' to '9' do
                         BEGIN
                               x[i] := j;
                               if i = k then xuly(k)
                                 else try(i+1,k);
                         END;
                END;
        END;

Procedure main;
Var k : integer;
        BEGIN
              d := length(n);
              if d mod 2 = 1 then d := d div 2 + 1
                else d := d div 2;
              res := 0;
              For k := 1 to d do
                  Try(1,k);

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
