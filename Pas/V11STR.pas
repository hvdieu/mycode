Const   inp = '';
        out = '';
        maxn = 500001;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        b       :       array [1..1001] of longint;
        m,n     :       longint;

Procedure input;
Var i : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,m,n);
              For i := 1 to m do read(fi,b[i]);
              For i := 1 to n do read(fi,a[i]);
              close(fi);
        END;

Procedure main;
Var i,j,dem : longint;
        BEGIN
               For i := 1 to n-m+1 do
                 BEGIN
                      dem := 0;
                      For j := 0 to m-1 do
                        if a[i+j] = b[j+1] then continue
                          else
                            BEGIN
                                 inc(dem);
                                 if dem > 1 then break;
                            END;
                            if dem <= 1 then
                          BEGIN
                      write(fo,i);
                      close(fo);
                      exit;
                      END;
                 END;
        END;

BEGIN
      input;
      main;
END.