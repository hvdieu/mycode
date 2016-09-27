{$H+}
Const   inp = '';
        out = '';
        maxn = 501;
Var     fi,fo   :       text;
        n       :       longint;
        f       :       array [0..maxn] of string;

Function add(a,b : string) : string;
Var sum,carry,i,x,y : longint;
    c : string;
        BEGIN
            carry := 0; c := '';
            While length(a) < length(b) do a := '0' + a;
            While length(a) < length(b) do b := '0' + b;
            For i := length(a) downto 1 do
              BEGIN
                   x := ord(a[i]) - ord('0');
                   y := ord(b[i]) - ord('0');
                   sum := x+y+carry;
                   carry := sum div 10;
                   c := chr(sum mod 10 + 48) + c;
              END;
            if carry > 0 then c:= '1' + c;
            add := c;
        END;

Function mul(a : string; b : longint) : string;
Var i,carry,s : longint;
    c,tmp : string;
        BEGIN
              c := '';carry := 0;
              For i := length(a) downto 1 do
                BEGIN
                     s := (ord(a[i]) - 48) * b + carry;
                     carry := s div 10;
                     c := chr(s mod 10 + 48) + c;
                END;

              if carry > 0 then str(carry,tmp) else tmp := '';
              mul := tmp + c;
        END;

Procedure main;
Var i : longint;
        BEGIN
             assign(fi,inp); reset(fi);
             readln(fi,n);
             close(fi);
             f[0] := '1';
             f[1] := '1';
             For i := 2 to n do
               f[i] := add(f[i-1],mul(f[i-2],i-1));
             assign(fo,out); rewrite(fo);
             write(fo,f[n]);
             close(fo);
        END;

BEGIN
     main;
END.


