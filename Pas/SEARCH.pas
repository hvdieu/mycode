Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        a,b,c,dem,ax   :       array [1..maxn] of longint;
        bmark,free,cmark   :       array [1..maxn] of boolean;
        m,n,p,d,l,res   :       longint;
        ok      :       boolean;

Procedure input;
Var i : longint;
        BEGIN
               Assign(fi,inp); reset(fi);
               readln(fi,m,n,p);
               for i := 1 to m do read(fi,a[i]); readln(fi);
               for i := 1 to n do read(fi,b[i]); readln(fi);
               for i := 1 to p do read(fi,c[i]); readln(fi);
               close(fi);
        END;

Procedure init;
Var i,j : longint;
        BEGIN
               fillchar(bmark,sizeof(bmark),true);
               fillchar(free,sizeof(free),true);
               fillchar(cmark,sizeof(cmark),false);
               For i := 1 to n do bmark[b[i]] := false;
               for i := 1 to p do
                  if bmark[c[i]] = false then free[i] := false;
               for i := 1 to m do inc(dem[a[i]]);
               d := 0;
               For i := 1 to m do
                 BEGIN
                       if dem[a[i]] > 0 then
                         BEGIN
                              inc(d);
                              ax[d] := a[i];
                              dem[a[i]] := 0;
                         END;
                 END;
              res :=0;
              l := 0;
              i := 1;
              While i < p do
                  BEGIN
                      While (free[i] = false) and (i<p) do inc(i);
                      if i <= p then l := 0;
                      While (free[i]) and (i<=p) do
                          BEGIN
                                inc(l);
                                cmark[c[i]] := true;
                                inc(i);
                          END;
                      ok := true;
                      for j := 1 to d do
                         BEGIN
                               if cmark[ax[j]] = false then
                                  BEGIN
                                       ok := false;
                                       break;
                                  END;
                         END;
                      if ok then
                        if l > res then res := l;
                      for j := i - 1 downto i-l do cmark[c[j]] := false;

                  END;


        END;
Procedure output;
BEGIN
      Assign(fo,out); rewrite(fo);
      write(fo,res);
      close(fo);
END;

BEGIN
      input;
      init;
      output;
END.