Const   inp = '';
        out = '';
        maxp = 2700000;
        maxn = 196700;
Var     fi,fo   :       text;
        prime   :       array [1..maxp] of boolean;
        p       :       array [0..maxn] of longint;
        t,i,k,dem,t1 :       longint;
        n       :       int64;

Procedure Sang;
Var i,j,tg : longint;
        BEGIN
                fillchar(prime,sizeof(prime),true);
                dem := 0;
                tg := trunc( sqrt(maxp) );
                For i := 2 to tg do
                        BEGIN
                                if prime[i] then
                                        BEGIN
                                            j := i*i;
                                            inc(dem);
                                            p[dem] := i;
                                            While j <= maxp do
                                                BEGIN
                                                    prime[j] := false;
                                                    j:= j + i;
                                                END;
                                        END;
                        END;
                For i := tg + 1 to maxp do
                        BEGIN
                            if prime[i] then
                                BEGIN
                                        inc(dem);
                                        p[dem] := i;
                                END;
                        END;
        END;

Function find(d,c,key : longint) : longint;
Var res,mid : longint;
BEGIN
        mid:= (d + c) div 2;
        While d <= c do
          BEGIN
              mid:= (d+c) div 2;
              if p[mid] = key then
                 BEGIN
                     find := mid;
                     exit;
                 END
                   else if p[mid] > key then
                        BEGIN
                                c:= mid -1;
                        END
                          else d:= mid + 1;
          END;
        find := c + 1 ;
END;

Procedure main( n : int64; k : longint);
Var i,j,key,vt,pos : longint;
    s,res   :       int64;
        BEGIN
                key := trunc ( exp( 1/k * ln(n) ) );
                vt := find(1,dem,key);
                res := -1;
                s := 1;
                For i := 0 to k - 1 do
                 s := s * p[vt + i];
                if vt < 10 then vt := 1
                        else vt := vt - 10;
                res := -1;
                For i := vt to dem do
                        BEGIN
                            s:=1;
                            for j := 0 to k - 1 do
                                s := s * p[i + j];
                            if ( s < n) and (s > res ) then res := s
                                else if s >= n then break;
                        END;
                writeln(fo,res);


        END;

BEGIN
        Assign(fi, inp); reset(fi);
        Assign(fo, out); rewrite(fo);
        readln(fi,t);
        Sang;
        For t1 := 1 to t do
                BEGIN
                        readln(fi,n,k);
                        if n <= 30 then writeln(fo,-1)
                        else
                        main(n,k);
                END;
        close(fi);
        close(fo);

END.
