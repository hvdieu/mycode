CONST
        tfi     ='qbtreek.inp';
        tfo     ='';
        nmax    =499;
        mmax    =500;
        oo      =9901;
TYPE
        arr     =array [0..nmax,0..mmax] of longint;
        arr1    =array [0..nmax,0..mmax] of boolean;
VAR
        fi,fo   :text;
        f       :arr;
        free    :arr1;
        n,m,res :longint;
 (*****************************************************************)
Procedure nhap;
      Begin
        assign(fi,tfi);reset(fi);
          read(fi,n,m);
        close(fi);
      End;
 (******************************************************************)
Function call(i,j:longint):longint;
      Var
        t       :longint;
      Begin
        if j=0 then exit(0);
        if i=0 then exit(1);
        if free[i,j]=false then
          begin
            free[i,j]:=true;
            for t:=0 to (i-1) div 2-1 do f[i,j]:=(f[i,j]+2*call(t,j-1)*call(i-t-1,j-1)) mod oo;
            t:=(i-1) div 2;
            if (i-1) mod 2=0 then f[i,j]:=(f[i,j]+call(t,j-1)*call(t,j-1)) mod oo
            else f[i,j]:=(f[i,j]+2*call(t,j-1)*call(i-t-1,j-1)) mod oo
          end;
        exit(f[i,j]);
      End;
 (******************************************************************)
Procedure inkq;
      Begin
        assign(fo,tfo);rewrite(fo);
          write(fo,res);
        close(fo);
      End;
 (******************************************************************)
BEGIN
        nhap;
        if (n mod 2=1) and (2*m-1<=n) then
        res:=(call(n div 2,m)-call(n div 2,m-1)+oo) mod oo;
        inkq;
        readln;
END.












