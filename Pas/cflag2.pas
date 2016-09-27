CONST
        tfi     ='cflag2.inp';
        tfo     ='cflag2.out';
        nmax    =1500;
        oo      =21266327;
TYPE
        arr     =array [1..nmax,1..2] of longint;
VAR
        fi,fo   :text;
        f       :arr;
        n,k,m   :longint;
 (********************************************************************)
Procedure nhap;
      Begin
        assign(fi,tfi);reset(fi);
          read(fi,n,k);
        close(fi);
      End;
 (*********************************************************************)
Function mu(i,k:longint):longint;
      Var
        tg      :int64;
      Begin
        if i=0 then exit(1);
        if i=1 then exit(k);
        tg:=mu(i div 2,k);
        tg:=(tg*tg) mod oo;
        if i mod 2=1 then tg:=(tg*k) mod oo;
        exit(tg);
      End;
 (**********************************************************************)
Procedure lam;
      Var
        i,s1,s2 :longint;
      Begin
        if k=1 then
          begin
            write(fo,1);
            exit;
          end;
        f[1,1]:=k;f[2,1]:=k;f[2,2]:=k*(k-1);
        for i:=3 to n do
          if i mod 2=n mod 2 then
            begin
              s1:=mu(i-1,k);
              s2:=(int64(s1)*(s1-1)) mod oo;
              f[i,2]:=((int64(s2)*(f[i-2,1]+f[i-2,2])) mod oo
              +(int64(s1)*int64(f[i-2,2])) mod oo) mod oo;
              f[i,1]:=(int64(s1)*int64(f[i-2,1])) mod oo;
            end;
        m:=(m-f[n,1]-f[n,2]+2*oo) mod oo;
        m:=(int64(mu(oo,m))*int64(mu(oo-2,4))) mod oo;
        m:=(m+f[n,1]+(int64(mu(oo,f[n,2]))*int64(mu(oo-2,2))) mod oo) mod oo;
        writeln(fo,m);
        writeln(fo,f[n][1],' ',f[n][2]);
      End;
 (**********************************************************************)
BEGIN
      assign(fo,tfo);rewrite(fo);
        nhap;
        m:=mu(n*n,k);
        lam;
      close(fo);
END.
