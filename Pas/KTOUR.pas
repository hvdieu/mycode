Const   inp = 'ktour.inp';
        out = 'ktour.out';
        maxn = 100010;
        epsilon = 0.00000001;
Var     fi,fo   :       text;
        m,n,yo     :       longint;
        dau,cuoi      :       array [1..maxn] of double;
        xo,x1,y1      :       array [1..maxn] of longint;
        res     :       double;
Procedure Swap( Var xx,yy : longint);
Var temp : longint;
        BEGIN
              temp := xx; xx := yy; yy := temp;
        END;
Procedure dc( Var xx,yy : double);
Var temp : double;
        BEGIN
              temp := xx; xx := yy; yy := temp;
        END;

Procedure Sort(L,h : longint);
Var i,j : longint;
     key  :  extended;
        BEGIN
               if l >=h then exit;
               i := l; j := h; key := xo[l+ random(h-l+1)];
               Repeat
                    While xo[i] < key do inc(i);
                    while xo[j] > key do dec(j);
                    if i <= j then
                        BEGIN
                               if i < j then swap(xo[i],xo[j]);
                               inc(i);
                               dec(j);
                        END;
               Until i > j;
               Sort(l,j); Sort(i,h);
        END;

Procedure input;
Var i : longint;
        BEGIN
               Assign(fi,inp); reset(fi);
               readln(fi,n,yo);
               For i := 1 to n do readln(fi,xo[i]);
               readln(fi,m);
               For i := 1 to m do readln(fi,x1[i],y1[i]);
               close(fi);
        END;

Procedure Qsort(l,h : longint);
Var i,j : longint;
    key : double;
        BEGIN
               if l >= h then exit;
               i := l; j := h; key := dau[l + random(h-l+1)];
               Repeat
                    While dau[i] < key do inc(i);
                    While dau[j] > key do dec(j);
                    if i <= j then
                       BEGIN
                             if i < j then
                                BEGIN
                                      dc(dau[i],dau[j]);
                                      dc(cuoi[i],cuoi[j]);
                                END;
                             inc(i); dec(j);
                       END;
               Until i > j;
               Qsort(l,j); Qsort(i,h);

        END;

Function ok(d : double) : boolean;
Var i,j,dem  : longint;
    temp : double;
        BEGIN
              dem := 0;
              For i := 1 to m do
                  BEGIN
                         temp := abs(yo - y1[i]);
                         if d >= temp then
                            BEGIN
                                  inc(dem);
                                  temp := sqrt(sqr(d) - sqr(temp));
                                  dau[dem] := x1[i] - temp;
                                  cuoi[dem] := x1[i] + temp;
                            END;
                  END;
                if dem = 0 then exit(false);
                Qsort(1,dem);
                i := 0;
                For j := 1 to dem do
                    BEGIN
                          While (i < n) and (xo[i+1] >= dau[j])
                             and (xo[i+1] <= cuoi[j]) do inc(i);
                          if i = n then exit(true);
                    END;
              exit(false);


        END;

Procedure main;
Var i,j : longint;
    l,r,mid : double;
        BEGIN
               Sort(1,n);
               l := 0;
               r := 1000000;
               While l + epsilon < r do
                  BEGIN
                         mid := (l+r) / 2;
                         if ok(mid) then
                          BEGIN
                             res := mid;
                             r := mid;
                          END
                               else l := mid;
                  END;

        END;

Procedure output;
        BEGIN
              Assign(fo,out); rewrite(fo);
              write(fo,res:0:6);
              close(fo);
        END;

BEGIN
      Input;
      main;
      output;
END.
