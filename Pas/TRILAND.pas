Const   inp = '';
        out = '';
        maxn = 1001;
Var     fi,fo   :       text;
        x,y     :       array [1..maxn] of int64;
        f       :       array [1..maxn] of qword;
        n       :       longint;
        res     :       qword;

Procedure input;
Var i : longint;
        BEGIN
               Assign(fi,inp); reset(fi);
               readln(fi,n);
               For i := 1 to n do readln(fi,x[i],y[i]);
               close(fi);
        END;

Procedure Swap(Var xx,yy : qword);
Var temp : qword;
        BEGIN
              temp := xx; xx := yy; yy := temp;
        END;

Procedure Sort(l,h   :   longint);
Var i,j : longint;
    key : qword;
        BEGIN
              if l >= h then exit;
              i := l;
              j := h;
              key := f[ (l+h) div 2];
              Repeat
                   While f[i] < key do inc(i);
                   While f[j] > key do dec(j);
                   if i <= j then
                      BEGIN
                            if i < j then swap(f[i],f[j]);
                            inc(i);
                            dec(j);
                      END;
              until i > j;
              Sort(l,j); sort(i,h);
        END;

Procedure main;
Var i,j,k,b : longint;
        BEGIN
               res := 0;
               For i := 1 to n do
                 BEGIN
                      For j := 1 to n do
                        f[j] := sqr(x[i] - x[j]) + sqr(y[i] - y[j]);
                      Sort(1,n);
                      k := 1;
                      b := 1;
                      While k < n do
                         BEGIN
                               b := 1;
                               While (f[k] = f[k+1]) and (k < n) do
                                  BEGIN
                                         inc(b);
                                         inc(k);
                                  END;
                               res := res + ((b*(b-1)) div 2);
                               inc(k);
                         END;
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
       main;
       output;
END.