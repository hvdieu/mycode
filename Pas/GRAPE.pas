Const   inp = '';
        out = '';
        maxn = 511;
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of longint;
        b       :       array [1..maxn] of longint;
        m,n,q,dem,min1   :       longint;
        l,r     :       array [1..100001] of longint;

Procedure input;
Var i,j : longint;
        BEGIN
             Assign(fi,inp); reset(fi);
             Assign(fo,out); rewrite(fo);
             readln(fi,m,n,q);
             For i := 1 to m do
              BEGIN
                 For j := n downto 1 do read(fi,a[i,j]);
                 readln(fi);
              END;
              For i := 1 to q do readln(fi,l[i],r[i]);
              close(fi);
        END;

Function find1(d,c,key : longint) : longint;
Var mid,ans : longint;
        BEGIN
              if key > b[c] then exit(1000);
              While d <= c do
                BEGIN
                     mid := (d+c) div 2;
                      if b[mid] >= key then
                        BEGIN
                          ans := mid;
                          c := mid - 1;
                        END
                           else d := mid + 1;
                END;
              find1 := ans
        END;

Function find2(d,c,key : longint) : longint;
Var mid,ans : longint;
        BEGIN
              if key < b[d] then exit(-1000);
              While d <= c do
                BEGIN
                     mid := (d+c) div 2;
                     if b[mid] <= key then
                        BEGIN
                             ans := mid;
                             d := mid + 1;
                        END
                          else c := mid - 1;
                END;
              find2 := ans;
        END;

Procedure main;
Var i,j,k,u,v,res : longint;
        BEGIN
             For k := 1 to q do
                BEGIN
                       For i := m downto 1 do
                         BEGIN
                             dem := 0;
                             res := 0;
                             j := 1;
                             While (i+dem <= m) and (j+dem <= n) do
                               BEGIN
                                    b[dem+1] := a[i+dem,j+dem];
                                    inc(dem);
                               END;
                             u := Find1(1,dem,l[k]);
                             v := Find2(1,dem,r[k]);
                             if res < v-u+1 then res := v-u+1;
                         END;
                       For j := 2 to n do
                         BEGIN
                              dem := 0;
                              i := 1;
                              While (i+dem <= m) and (j + dem <= n) do
                                BEGIN
                                     b[dem+1] := a[i+dem,j+dem];
                                     inc(dem);
                                END;
                              u := find1(1,dem,l[k]);
                              v := find2(1,dem,r[k]);
                              if res < v-u+1 then res := v-u+1;
                         END;
                       writeln(fo,res*res);

                END;
             close(fo);
        END;

BEGIN
     input;
     main;
END.
