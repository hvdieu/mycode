CONST
        tfi     ='';//'nkleaves.inp';
        tfo     ='';//'nkleaves.out';
        nmax    =100000;
        oo      =900000000000000000;
TYPE
        arr     =array [1..nmax] of longint;
        arr1    =array [0..1,1..nmax] of int64;
        arr2    =array [0..nmax] of int64;
        arr3    =array [1..nmax] of real;
VAR
        fi,fo   :text;
        a,s     :arr;
        f       :arr1;
        p,q,g   :arr2;
        c       :arr3;
        n,k,top:longint;
        res     :int64;
 (*********************************************************************)
Procedure nhap;
      Var
        i       :longint;
      Begin
        assign(fi,tfi);reset(fi);
          read(fi,n,k);
          for i:=n downto 1 do read(fi,a[i]);
        close(fi);
      End;
 (**********************************************************************)
Procedure khoitao;
      Var
        i       :longint;
      Begin
        s[1]:=a[1];
        for i:=2 to n do s[i]:=s[i-1]+a[i];
        g[1]:=s[1];
        for i:=2 to n do g[i]:=g[i-1]+s[i];
      End;
 (**********************************************************************)
Procedure push(x,y:int64;z:real);
      Begin
        inc(top);
        p[top]:=x;
        q[top]:=y;
        c[top]:=z;
      End;
 (**********************************************************************)
Procedure lam;
      Var
        i,ok,j,t :longint;
        l       :real;
       Begin
         ok:=1;
         for i:=1 to n do f[ok,i]:=g[i-1];
         for t:=2 to k do
           begin
             ok:=1-ok;
             top:=0;
             j:=t;
             push(-s[j-1],f[1-ok,j-1]+int64(s[j-1])*(j-1)-g[j-1],-oo);
             j:=1;
             for i:=t to n do
               begin
                 while (j<=top) and (c[j]<=i-1) do inc(j);
                 dec(j);
                 f[ok,i]:=g[i-1]+p[j]*(i-1)+q[j];
                 while top<>0 do
                   begin
                     l:=(f[1-ok,i]+int64(s[i])*i-g[i]-q[top])/(p[top]+s[i]);
                     if l<=c[top] then dec(top) else break;
                   end;
                 push(-s[i],f[1-ok,i]+int64(s[i])*i-g[i],l);
                 if top<j then j:=top;
               end;
           end;
         res:=f[ok,n];
       End;
 (**********************************************************************)
Procedure inkq;
      Begin
        assign(fo,tfo);rewrite(fo);
          write(fo,res);
        close(fo);
      End;
 (***********************************************************************)
BEGIN
        nhap;
        khoitao;
        lam;
        inkq;
END.

