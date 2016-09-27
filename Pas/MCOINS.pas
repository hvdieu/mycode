Const   inp = '';
        out = '';
        maxn = 1000001;
Var     fi,fo   :       text;
        f       :       array [0..maxn] of integer;
        a       :       array [1..50] of longint;
        max,n,i,k,l,m :       longint;

BEGIN
      assign(fi,inp); reset(fi);
      readln(fi,k,l,m);
      max := 0;
      for i := 1 to m do
         BEGIN
             read(fi,a[i]);
             if a[i] > max then max := a[i];
         END;
      close(fi);

      f[0] := 0;
      For i := 1 to max do
        BEGIN
             if (i-k >= 0) and (i-l >=0) then
               if (f[i-1] = 1) and (f[i-k] = 1) and (f[i-l]=1) then f[i] := 0
                 else f[i] := 1;
             if (i-k >=0) and (i-l < 0) then
               if (f[i-1] = 1) and (f[i-k] = 1) then f[i] := 0
                 else f[i] := 1;
             if (i-k < 0) and (i-l >=0) then
               if (f[i-1] = 1) and (f[i-l] =1) then f[i] := 0
                 else f[i] := 1;
             if (i-k < 0) and (i-l < 0) then
               if f[i-1] = 1 then f[i] := 0
                 else f[i] := 1;
        END;
      assign(fo,out); rewrite(fo);
      for i := 1 to m do
        if f[a[i]] = 1 then write(fo,'A')
          else write(fo,'B');
      close(fo);

END.