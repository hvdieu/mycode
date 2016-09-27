{$H+}
Const   inp = 'WS.INP';
        out = 'WS.OUT';
        maxn = 1000001;
Var     fi,fo   :       text;
        d       :       array [1..maxn] of int64;
        dem     :       array ['a'..'z'] of int64;
        s       :       string;
        k,res       :       int64;
        n       :       longint;
        nt      :       array [1..maxn] of longint;

Procedure input;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,k);
              readln(fi,s);
              close(fi);
        END;

Procedure sangnt;
Var j,i : longint;
        BEGIN
                n := length(s);
                fillchar(nt,sizeof(nt),0);
                For i := 2 to trunc(sqrt(n)) do
                     if nt[i] = 0 then
                       BEGIN
                             j := i*i;
                             While j <= n do
                               BEGIN
                                    if nt[i] = 0 then nt[j] := i;
                                    j := j + i;
                               END;
                       END;
        END;

Function power(a,n : int64) : int64;
Var tmp : int64;
        BEGIN
             if n=1 then exit(a)
              else if n = 0 then exit(1)
               else
                 BEGIN
                      tmp := power(a, n div 2) mod k;
                      if (n mod 2 =1) then exit((tmp*tmp*a) mod k)
                        else exit((tmp*tmp) mod k);
                 END;
        END;

Procedure main;
Var i,t,j : longint;
    ch  : char;
        BEGIN
              fillchar(d,sizeof(d),0);
              For i := 2 to n do
                 BEGIN
                      if nt[i] = 0 then inc(d[i])
                        else
                           BEGIN
                                t := i;
                                While nt[t] <> 0 do
                                   BEGIN
                                        inc(d[ nt[t] ]);
                                        t := t div nt[t];
                                   END;
                                inc(d[t]);
                           END;
                 END;
             For i := 1 to n do
               inc(dem[s[i]]);
             For ch := 'a' to 'z' do
                BEGIN
                    For i := 2 to dem[ch] do
                       BEGIN
                            if nt[i] = 0 then dec(d[i])
                              else
                                BEGIN
                                      t := i;
                                      While nt[t] <> 0 do
                                        BEGIN
                                             dec(d[ nt[t] ]);
                                             t := t div nt[t];
                                        END;
                                      dec(d[t]);
                                END;
                       END;
                END;
             res := 1;
            For i := 2 to n do
             For j := 1 to d[i] do
                   BEGIN
                     res := res*i;
                     res:= (res+k) mod k;
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
      sangnt;
      main;
      output;
END.