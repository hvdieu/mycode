Const   inp = 'kseq1.inp';
        out = 'kseq1.out';
        maxn = 301;
Var     fi,fo   :       text;
        n       :       longint;
        a       :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        res,dem     :       longint;
        ok      :       boolean;

Procedure input;
Var i : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,n);
              for i := 1 to n do read(fi,a[i]);
              close(fi);
        END;

procedure main;
Var k,i,j,vt1,vt2 : longint;
        BEGIN
              For k := n div 2 downto 1 do
                 BEGIN
                     vt1 := 1; vt2 := k;
                     fillchar(free,sizeof(free),true);
                     dem := 0; ok := false;
                     For i := 1 to n-k do
                       BEGIN
                         For j := vt2+1 to n do
                            if (a[i] < a[j]) and (i<j)
                              and free[i] and free[j] then
                               BEGIN
                                   vt2 := j;
                                   free[i] := false;
                                   free[j] := false;
                                   inc(dem);
                                   break;
                               END;
                       END;
                     if dem >= k then
                       BEGIN
                            res := k;
                            break;
                       END;
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