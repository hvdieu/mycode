Const   inp = '';
        out = '';
        maxn = 1001;
Var     fi,fo   :       text;
        m,n,i,j,k,st :       longint;
        dem     :       array [1..maxn*maxn] of longint;
        a       :       array [1..maxn,1..maxn] of longint;
        ok1,ok2 : boolean;


BEGIN
      assign(fi,inp); reset(fi);
      assign(fo,out); rewrite(fo);
      readln(fi,m,n); readln(fi,k);
      For i := 1 to k do read(fi,dem[i]);
      ok1 := true;
      ok2 := false;
      i := 1; j := 0;
      fillchar(a,sizeof(a),0);
      For st := 1 to k do
        BEGIN
             While dem[st] > 0 do
               BEGIN
                    if ok1 and (dem[st] > 0) then
                      BEGIN
                           inc(j);
                           a[i,j] := st;
                           dec(dem[st]);
                           if j = n then
                             BEGIN
                                 ok1 := false;
                                 ok2 := true;
                                 inc(i);
                                 j := n+1;
                             END;
                      END;
                    if ok2 and (dem[st] > 0) then
                      BEGIN
                           dec(j);
                           a[i,j] := st;
                           dec(dem[st]);
                           if j = 1 then
                             BEGIN
                                  ok1 := true;
                                  ok2 := false;
                                  inc(i);
                                  j := 0;
                             END;
                      END;
               END;
        END;
      For i := 1 to m do
       BEGIN
          For j := 1 to n do write(fo,a[i,j],' ');
       writeln(fo);
       END;
      close(fi); close(fo);
END.