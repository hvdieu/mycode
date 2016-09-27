Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        n,i     :       longint;
        a       :       array [1..maxn] of longint;
        s ,sr      :       array [0..maxn+1] of longint;

procedure Swap(Var xx, yy : longint);
Var temp : longint;
        BEGIN
           temp := xx; xx := yy; yy := temp;
        END;

Procedure Quicksort(L, H : longint);
Var i,j,key   :   longint;
BEGIN
       if l >= h then exit;
       i := l;
       j := h;
       key := a[ (l+h) div 2];
       Repeat
                While a[i] > key do inc(i);
                While a[j] < key do dec(j);
                if i <= j then
                    BEGIN
                          if i < j then swap(a[i],a[j]);
                          inc(i);
                          dec(j);
                    END;
       Until i > j;
       Quicksort(l,j);
       Quicksort(i,h);
END;

Function find(d,c,key  : longint) : longint;
Var mid : longint;
        BEGIN
            While d <= c do
                BEGIN
                      mid := (d+c) div 2;
                      if a[mid] > key then d := mid + 1
                        else c := mid - 1;
                END;
            find := c + 1;
        END;

Procedure main;
Var i,j,k,vt : longint;
    sum   : longint;
        BEGIN
             for i := 1 to n do
              if a[i] > n-1 then
                BEGIN
                    writeln(fo,'NO');
                    exit;
                END;
             Quicksort(1,n);
             fillchar(s, sizeof(s), 0);
             For i := 1 to n do s[i] := s[i-1] + a[i];
             fillchar(sr, sizeof(sr), 0);
             for i := n downto 1 do sr[i] := sr[i+1] + a[i];
             for k := 1 to n do
                BEGIN
                       vt := find(k+1,n,k);
                       sum := k * (vt-k - 1) + sr[vt];
                       if s[k] > k*(k-1) + sum then
                           BEGIN
                               writeln(fo,'NO');
                               exit;
                           END;
                END;
             writeln(fo,'YES');
        END;

Procedure nhap;
Var i,t,st,sa : longint;
        BEGIN
             Assign(fi, inp); reset(fi);
             Assign(fo,out) ; rewrite(fo);
             readln(fi, t);
             for st := 1 to t do
                BEGIN
                     readln(fi, n);
                     sa := 0;
                     for i := 1 to n do
                       BEGIN
                        readln(fi,a[i]);
                        sa := sa + a[i];
                       END;
                       if sa mod 2 = 1 then writeln(fo,'NO')
                       else
                     main;
                END;
             close(fi);
             close(fo);
        END;

BEGIN
     nhap;
END.