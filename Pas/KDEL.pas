Const   inp = '';
        out = '';
        max = 620000;
Var     fi,fo : text;
        s       :       ansistring;
        n,k,dem,i,j,scs,vt,u,dd       :       longint;
        prime   :       array [1..max] of boolean;
        st,maxcs      :       string;
{*      *       *       *       *}
Procedure Sangngto;
Var i,j : longint;
BEGIN
    fillchar(prime,sizeof(prime),true);
    For i:=2 to trunc(sqrt(max)) do
      BEGIN
          if prime[i] then
            BEGIN
                j:=i*i;
                While j <= max do
                  BEGIN
                      prime[j]:=false;
                      j:=j+i;
                  END;
            END;
      END;
END;
{*      *       *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,k);
    close(fi);
    Sangngto;
    dem:=0;
    s:='';
    For i:=2 to max do
      BEGIN
        if prime[i] then
          BEGIN
              str(i,st);
              s:=s + st;
              inc(dem);
              if dem=n then break;
          END;
      END;
    dd:= length(s);
    scs:=dd - k;
    vt:=0;
    Assign(fo,out);rewrite(fo);
    For u:=1 to dd-k do
      BEGIN
          maxcs:= '/';
          For j:=vt+1 to dd-scs+1 do
          BEGIN
                if s[j] > maxcs then
                  BEGIN
                      vt:=j;
                      maxcs:= s[j];
                      if maxcs= '9' then break;
                  END;
            END;
          dec(scs);
          write(fo,s[vt]);
      END;
    close(fo);

END.
