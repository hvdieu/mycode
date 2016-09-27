Const  inp = '';
       out = '';
Var    fi,fo :  text;
        n,k,dem :       longint;
{*      *       *       *       *}
Procedure Try(s : longint);
Var a,b,t : longint;
BEGIN
    t:= s + k;
    if (t mod 2 = 0) and (s > k) then
      BEGIN
          inc(dem);
          a:= t div 2;
          b := s - a;
          Try(a);
          Try(b);
      END;
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    read(fi,n,k);
    close(fi);
    dem:=1;
    Try(n);
    Assign(fo,out);rewrite(fo);
    write(fo,dem);
    close(fo);
END.