{$Q-} {$H+}
Const   inp = '';
        out = '';
        maxn = 50010;
Var     fi,fo   :       text;
        hash,pow,a    :       array [0..maxn+1] of qword;
        base    :       longint;
        n,k,mid,res,m     :       longint;
        s       :       string;
        ok      :       boolean;

Function geths(i,j : longint) : qword;
        BEGIN
              geths := (hash[j] - hash[i-1] * pow[j-i+1] + base*base) mod base;
        END;

Procedure swap(var xx,yy : qword);
Var temp : qword;
        BEGIN
               temp := xx; xx := yy; yy := temp;
        END;

Procedure sort(l,h : longint);
Var i,j : longint;
    key : qword;
        BEGIN
              if l >= h then exit;
              i := l;
              j := h;
              key := a[(l+h) div 2];
              Repeat
                   While a[i] < key do inc(i);
                   While a[j] > key do dec(j);
                   if i <= j then
                      BEGIN
                            if i < j then swap(a[i],a[j]);
                            inc(i);
                            dec(j);
                      END;
              Until i > j;
              sort(l,j); sort(i,h);
        END;

Procedure xuly;
Var i,dem : longint;
    hash1 : qword;
        BEGIN
               For i := 1 to n - mid + 1 do
                   a[i] := geths(i,i+mid-1);
               sort(1,n-mid+1);
               i := 1;
               m := n - mid + 1;
               i := 1;
               While i < m do
                  BEGIN
                        dem := 1;
                        While (a[i] = a[i+1]) and (i < m) do
                           BEGIN
                                 inc(i);
                                 inc(dem);
                           END;
                        if dem >= k then
                           BEGIN
                                 ok := true;
                                 exit;
                           END;
                        inc(i);
                  END;


        END;

Procedure Find(d,c : longint);
        BEGIN
              While d <= c do
                 BEGIN
                        mid := (d+c) div 2;
                        ok := false;
                        xuly;
                        if ok then
                           BEGIN
                                res := mid;
                                d := mid + 1;
                           END
                              else c := mid - 1;
                 END;
        END;

Procedure main;
Var i : longint;
        BEGIN
               pow[0] := 1; hash[0] := 0;
               base := 1000000003;
               res := 0;
               For i := 1 to n do
                   pow[i] := (pow[i-1]*26) mod base;
               for i := 1 to n do
                   hash[i] := (hash[i-1]*26 + ord(s[i]) - ord('a') ) mod base;
               Find(1,n);
        END;

BEGIN
       Assign(fi,inp); reset(fi);
       Assign(fo,out); rewrite(fo);
       readln(fi,n,k);
       readln(fi,s);
       close(fi);
       if k = 1 then write(fo,n)
          else
             BEGIN
                main;
                write(fo,res);
             END;
       close(fo);
END.
