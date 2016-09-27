Const   inp = '';
        out = '';
Var     fi,fo : text;
        l,r,t,s1,s2     :       int64;
        left,right,k      :       extended;
        test,i    :       longint;
{*      *       *       *       *}
Procedure Solve;
Var j : integer;
BEGIN
    if l=r then
      BEGIN
        For j:=39 downto 1 do
          BEGIN
             k:= exp(ln(l) / j);
             s1:= trunc(k*1000000);
             s2:= trunc(k) *1000000;
             if s1=s2 then
              BEGIN
                  writeln(fo,'Case #',i,': ',j);
                  exit;
              END;
          END;
      END
      else BEGIN
    For j:= 39 downto 1 do
      BEGIN
          left := exp( 1 / j * ln(l) );
          right:= exp( 1 / j * ln(r) );
          if (trunc( left + 1 ) <= right) then
            BEGIN
              writeln(fo,'Case #',i,': ',j);
              exit;
            END;
      END;
      END;
END;
{*      *       *       *       *}
BEGIN
    assign(fi,inp);reset(fi);
    assign(fo,out);rewrite(fo);
    readln(fi,test);
    For i:=1 to test do
      BEGIN
         readln(fi,l,r);
         solve;
      END;
    close(fi);
    close(fo);

END.
