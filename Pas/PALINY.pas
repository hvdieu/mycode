{$H+} {$Q-}
Const   inp = 'PALINY.INP';
        out = 'PALINY.OUT';
        maxn = 50010;
Var     fi,fo   :       text;
        n,res,l,mid       :       longint;
        s       :       string;
        pow,hs,ht : array [0..maxn+1] of qword;
        base    :       longint;
        ok      :       boolean;

Function geths(i,j : longint) : int64;
        BEGIN
               geths := (hs[j] - hs[i-1]*pow[j-i+1] + base*base) mod base;
        END;

Function getht(i,j : longint) : int64;
        BEGIN
              getht := (ht[i] - ht[j+1]*pow[j-i+1] + base*base) mod base;
        END;

Procedure le;
Var k,i : longint;
    hash1,hash2 : int64;
        BEGIN
              l := mid div 2;
              For i := 1 to n - mid + 1 do
                  BEGIN
                        hash1 := geths(i,i+l);
                        hash2 := getht(i+l,i+mid-1);
                        if hash1 = hash2 then
                           BEGIN
                                 ok := true;
                                 exit;
                           END;
                  END;
        END;


Procedure Findle(d,c : longint);
        BEGIN
               While d <= c do
                   BEGIN
                         mid := (d + c) div 2;
                         if mid mod 2 = 0 then inc(mid);
                         ok := false;
                         le;
                         if ok then
                           BEGIN
                              d := mid + 2;
                              res := mid;
                           END
                            else c := mid - 2;
                   END;
        END;

Procedure chan;
Var k,i : longint;
    hash1,hash2 : int64;
        BEGIN
              l := mid div 2;
              For i := 1 to n - mid + 1 do
                  BEGIN
                        hash1 := geths(i,i+l-1);
                        hash2 := getht(i+l,i+mid-1);
                        if hash1 = hash2 then
                           BEGIN
                                 ok := true;
                                 exit;
                           END;
                  END;
        END;

Procedure Findchan(d,c : longint);
        BEGIN
              While d <= c do
                  BEGIN
                         mid := (d+c) div 2;
                         if mid mod 2 = 1 then inc(mid);
                         ok := false;
                         chan;
                         if ok then
                            BEGIN
                                 d := mid + 2;
                                 if mid > res then res := mid;
                            END
                               else c := mid - 2;
                  END;
        END;

Procedure main;
Var i : longint;
        BEGIN
                pow[0] := 1; hs[0] := 0;
                ht[n+1] := 0; base := 1000000003;
                for i := 1 to n do
                  pow[i] := (pow[i-1] * 26) mod base;

                For i := n downto 1 do
                   ht[i] := (ht[i+1] * 26 + ord(s[i]) - ord('a') ) mod base;

                For i := 1 to n do
                   hs[i] := (hs[i-1] * 26 + ord(s[i]) - ord('a') ) mod base;

                Findle(1,n);
                Findchan(1,n);
        END;

BEGIN
       Assign(fi,inp); reset(fi);
       readln(fi,n);
       readln(fi,s);
       close(fi);
       main;
       assign(fo,out); rewrite(fo);
       write(fo,res);
       close(fo);
END.
