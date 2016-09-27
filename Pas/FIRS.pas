Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        a,cs       :       array [1..maxn] of longint;
        free       :       array [0..maxn] of boolean;
        n,nheap,res       :       longint;

Procedure Swap(Var xx,yy : longint);
Var temp : longint;
        BEGIN
              temp := xx; xx := yy; yy := temp;
        END;

Procedure input;
Var i : longint;
        BEGIN
              Assign(fi,inp); reset(fi);
              readln(fi,n);
              For i := 1 to n do read(fi,a[i]);
              close(fi);
        END;
Procedure Quicksort(L,h : longint);
Var i,j,key : longint;
        BEGIN
              if l >= h then exit;
              i := l;
              j := h;
              key := a[ (l+h) div 2];
              Repeat
                   While a[i] < key do inc(i);
                   While a[j] > key do dec(j);
                   if i <= j then
                       BEGIN
                             if i < j then
                                BEGIN
                                      if (a[i] = a[j]) and (cs[i] > cs[j]) then swap(cs[i],cs[j])
                                        else
                                           BEGIN
                                                if a[i] <> a[j] then
                                                BEGIN
                                                swap(cs[i],cs[j]);
                                                swap(a[i],a[j]);
                                                END;
                                           END;
                                END;
                             inc(i);
                             dec(j);
                       END;
              until i > j;
              Quicksort(L,j); Quicksort(i,h);
        END;

Procedure main;
Var i,j : longint;
        BEGIN
              res := 0;
              fillchar(free,sizeof(free),true);
              for i := 1 to n do cs[i] := i;
              quicksort(1,n);
              i := 0;
              free[0] := false;
              free[n+1] := false;
              repeat
                      inc(i);
                      j := cs[i];
                      if free[j] then
                        BEGIN
                              inc(res);
                              free[j] := false;
                              dec(n);
                              if free[j+1] then
                                BEGIN
                                     free[j+1] := false;
                                     dec(n);
                                END;
                              if free[j-1] then
                                BEGIN
                                     free[j-1] := false;
                                     dec(n);
                                END;
                        END;
              until n = 0;

        END;

Procedure output;
        BEGIN
              Assign(fo,out); rewrite(fo);
              write(fo,res);
              close(fo);
        END;

BEGIN
            input;
            main;
            output;
END.