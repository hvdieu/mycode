Var i : longint;
n,d : longint;
sl,sr,l,r,a : array [0..100010] of int64;
Function min(x,y : longint) : longint;
BEGIN
    if x<y then min:=x
      else min:=y;
END;
BEGIN
   readln(n);
     for i:=1 to n do
         begin
              read(a[i]);
              sl[i]:=sl[i-1]+a[i];
         end;
     for i:=n downto 1 do
         sr[i]:=sr[i+1]+a[i];
     for i:=1 to n do
         l[i]:=min(l[i-1],sl[i]);
     r[n]:=sl[n];
     for i:=n-1 downto 1 do
         r[i]:=min(sl[i],r[i+1]);
     d:=0;
     for i:=1 to n do
         if (a[i]>0) then
            if (l[i]+r[i]>0) and (h[i]-s[i-1]>0) then inc(d);
     writeln(d);
END.

