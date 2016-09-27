var a : array [1..100000] of longint;
        m,n,i,c : longint;

Function min(x,y : longint) : longint;
BEGIN
    if x>y then min:=y
      else min:=x;
END;
BEGIN
    readln(n);
    for i:=1 to n do read(a[i]);
    m:=0;
    for i:=n downto 1 do
      BEGIN
      if a[i]<=0 then m:=min(m+a[i],a[i])
        else m:=m+a[i];
          if m>0 then inc(c);
      END;
    write(c);

END.
