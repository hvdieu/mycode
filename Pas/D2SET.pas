Const   inp = 'D2SET.INP';
        out = 'D2SET.OUT';
        maxn = 1000001;
Var     fi,fo   :       text;
        a,g       :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        f       :       array [1..32] of longint;
        n,k     :       longint;
        res,d   :       int64;


procedure swap(Var xx,yy : longint);
Var temp : longint;
        BEGIN
             temp := xx; xx := yy; yy := temp;
        END;

procedure sort(l,h : longint);
Var i,j,key : longint;
        BEGIN
             if l >= h then exit;
             i:= l; j := h;
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

Function Find(d,c,key : longint) : longint;
Var mid : longint;
        BEGIN
               While d <= c do
                  BEGIN
                       mid := (d+c) div 2;
                       if key = a[mid] then
                         BEGIN
                              find := mid;
                              exit;
                         END
                           else if key > a[mid] then d := mid + 1
                             else c := mid -1
                  END;
               find := 0;
        END;

Procedure sub2;
Var i,j,dem,t,vt : longint;
        BEGIN
             For i := 1 to n do read(fi,a[i]);
             fillchar(free,sizeof(free),true);
             g[1] := 1;
              g[2] := 2;
              For i := 3 to n do
               if i mod 2 = 1 then g[i] := 1
                 else g[i] := i div 2 + 1;
             sort(1,n);
             d := 1; res := 0;
             For i := 1 to n do
               if free[i] then
                  BEGIN
                       dem := 1;
                       free[i] := false;
                       t := i*2;
                       vt := find(1,n,t);
                       While vt <> 0 do
                          BEGIN
                               free[vt] := false;
                               inc(dem);
                               t := 2*t;
                               vt := find(1,n,t);
                          END;
                       if dem mod 2 = 0 then
                           BEGIN
                              res := res + dem div 2;
                              d := (d * g[dem]) mod k;
                           END
                         else
                           BEGIN
                               res := res + dem div 2 + 1;
                               d := (d * g[dem]) mod k;
                           END;
                  END;
        END;

{Procedure sub3;
Var i,j,u : longint;
        BEGIN
              res := 0; d := 1;
              g[1] := 1; g[2] := 2;
              fillchar(f,sizeof(f),0);

              For i := 3 to 32 do
                if i mod 2 = 0 then g[i] := i div 2 + 1
                  else g[i] := 1;
              fillchar(free,sizeof(free),true);
              For i := 31 downto 1 do
                 BEGIN
                      u := n div (1 shl (i-1));
                      sole := (u+1) div 2;
                      f[i] := sole;

                 END;
        END; }

Procedure input;
Var i : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,n,k);
              if n <= 1000000 then sub2;
               // else sub3;
              close(fi);

        END;

Procedure output;
        BEGIN
             assign(fo,out);rewrite(fo);
             write(fo,res,' ',d);
             close(fo);
        END;

BEGIN
     input;
     output;
END.
