Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        a,b,c,dem,ax,dx,cdem   :       array [1..maxn] of longint;
        bmark,free   :       array [1..maxn] of boolean;
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
                              dx[d] := dem[a[i]];
                              dem[a[i]] := 0;
                         END;
                 END;
              res :=0;
              l := 0;
              i := 1;
              fillchar(cdem,sizeof(cdem),0);
              While i < p do
                  BEGIN
                      While (free[i] = false) and (i<p) do inc(i);
                      if i <= p then l := 0;
                      While (free[i]) and (i<=p) do
                          BEGIN
                                inc(l);
                                inc(cdem[c[i]]);
                                inc(i);
                          END;
                      ok := true;
                      for j := 1 to d do
                         BEGIN
                               if cdem[ax[j]] < dx[j] then
                                  BEGIN
                                       ok := false;
                                       break;
                                  END;
                         END;
                      if ok then
                        if l > res then res := l;
                      for j := i - 1 downto i-l do cdem[c[j]] := 0;

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
