Const   inp = 'MPILOT.INP';
        out = 'MPILOT.OUT';
        maxn = 10001;
Var     fi,fo   :       text;
        f       :       array [0..maxn,0..5001] of longint;
        n,i,j       :       longint;
        x,y     :       array [1..maxn] of longint;
Function min (xx,yy : longint) : longint;
BEGIN
      if xx > yy then min := yy
        else min := xx;
END;

BEGIN
     Assign(fi,inp); reset(fi);
     readln(fi,n);
     For i := 1 to n do readln(fi,x[i],y[i]);
     f[0,0] := 99999999;
     For j := 1 to n div 2 do f[0,j] := 0;
     fillchar(f,sizeof(f),0);
     close(fi);
     For i := 1 to n do
       For j := 1 to n div 2 do
         if 2*j <= i then
           f[i,j] := min (f[i-1,j-1] + x[i], f[i-1,j] + y[i]);
     Assign(fo,out); rewrite(fo);
     write(fo,f[n,n div 2]);
     close(fo);

END.