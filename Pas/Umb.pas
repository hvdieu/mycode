Const   inp = 'umb.in';
        out = 'umb.out';
        maxn = 5001;
Var     fi,fo   :       text;
        x       :       array [0..maxn] of longint;
        f       :       array [0..maxn] of longint;
        c       :       array [0..100001] of longint;
        n,m     :       longint;

Procedure input;
Var i : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,n,m);
              For i := 1 to n do read(fi,x[i]);
              readln(fi);
              For i := 1 to m do read(fi,c[i]);
              close(fi);
        END;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
             temp := xx; xx := yy; yy := temp;
        end;

Procedure sort(l,h : longint);
Var i,j,key : longint;
        BEGIN
             if l >= h then exit;
             i := l; j := h; key := x[(l+h) div 2];
             Repeat
                While x[i] < key do inc(i);
                While x[j] > key do dec(j);
                if i <= j then
                  BEGIN
                       swap(x[i],x[j]);
                       inc(i); dec(j);
                  END;
             until i > j;
             sort(l,j);sort(i,h);
        END;
Function min(xx,yy : longint) : longint;
        BEGIN
             if xx > yy then min := yy
               else min := xx;

        END;

Procedure main;
Var i,j : longint;
        BEGIN
              sort(1,n);
              For i := m-1 downto 1 do
                if c[i] > c[i+1] then c[i] := c[i+1];
              f[1] := 0;
              For i := 1 to n do f[i] := c[x[i] - x[1]+1] ;
              f[0] := 0;
              For i := 2 to n do
                For j := i downto 1 do
                  f[i] := min(f[i],f[j-1] + c[ x[i] - x[j]+1]);
              assign(fo,out); rewrite(fo);
              write(fo,f[n]);
              close(fo);
        END;


BEGIN
     input;
     main;
END.
