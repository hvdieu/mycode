{$MODE OBJFPC}
Const   inp = '';
        out = '';
        maxn = 500000;
Var     fi,fo : text;
        k,sum : int64;
        j,n,t,ii,i       :       longint;
        a       :       array [1..maxn] of qword;
        res     :       array [1..maxn] of string;
        pos     :       array [1..maxn] of longint;

procedure sort(l,h : longint);
Var i,j,tmp : longint;
    key,temp : qword;
        BEGIN
              if l >= h then exit;
              i := l; j := h;
              key := a[(l+h) div 2];
              Repeat
                 While a[i] < key do inc(i);
                 While a[j] > key do dec(j);
                 if i <= j then
                    BEGIN
                          temp := a[i]; a[i] := a[j]; a[j] := temp;
                          tmp := pos[i]; pos[i] := pos[j]; pos[j] := tmp;
                          inc(i);
                          dec(j);
                    END;
              Until i > j;
              sort(l,j); sort(i,h);
        END;

BEGIN
      assign(fi,inp); reset(fi);
      Assign(fo,out); rewrite(fo);
      n := 0;
      While not eof(fi) do
        BEGIN
            inc(n);
            readln(fi,a[n]);
        END;
      For ii := 1 to n do pos[ii] := ii;
      sort(1,n);
      t := 1; i := 1; j := 1;
      sum := 0;
            Repeat
               While ((sum = a[t]) or (sum-i=a[t])) and (t<=n) do
                 BEGIN
                   res[pos[t]] := 'Thu Uyen';
                   inc(t);
                 END;
               While (sum > a[t]) and (sum - i > a[t]) and (t <= n) do
                 BEGIN
                      res[pos[t]] := 'Conan';
                      inc(t);
                 END;
               inc(i);
               if i = 1 shl j then
                  BEGIN
                       sum := sum + i;
                       inc(j);
                  END
                    else sum := sum + 2*i;
               While ((sum = a[t]) or (sum-i=a[t])) and (t<=n) do
                 BEGIN
                   res[pos[t]] := 'Thu Uyen';
                   inc(t);
                 END;
               While (sum > a[t]) and (sum - i > a[t]) and (t <= n) do
                 BEGIN
                      res[pos[t]] := 'Conan';
                      inc(t);
                 END;
            Until t > n;
      For i := 1 to n do writeln(fo,res[i]);
      close(fi); close(fo);
END.
