CONST
        tfi     ='vmempire.inp';
        tfo     ='vmempire.ou1';
        nmax    =10000;
        oo      =1000000007;
TYPE
        arr     =array [0..nmax,0..nmax] of longint;
        arr1    =array [0..nmax] of longint;
VAR
        fi,fo   :text;
        c,f     :arr;
        p,h     :arr1;
        n,m,k   :longint;
        res     :longint;
 (*********************************************************************)
Procedure nhap;
      Begin
        assign(fi,tfi);reset(fi);
          read(fi,n,m,k);
        close(fi);
      End;
 (**********************************************************************)
Function mu(i,x:longint):int64;
      Var
        tg       :int64;
      Begin
        if i=0 then exit(1);
        if i=1 then exit(x);
        tg:=mu(i div 2,x);
        tg:=(tg*tg) mod oo;
        if i mod 2=1 then tg:=(tg*x) mod oo;
        exit(tg);
      End;
 (**********************************************************************)
Procedure khoitao;
      Var
        i,s     :longint;
      Begin
        h[0]:=1;
        for i:=1 to n do h[i]:=(int64(h[i-1])*i) mod oo;
        for i:=0 to m-1 do p[i]:=mu(i,2);
        for i:=m to n do
          begin
            s:=(int64(h[m-1])*h[i-m]) mod oo;
            p[i]:=(2*p[i-1]) mod oo;
            p[i]:=(p[i]-(int64(h[i-1])*mu(oo-2,s)) mod oo+oo) mod oo;
          end;
      End;
 (**********************************************************************)
Procedure lam;
      Var
        i,j,u,v :longint;
      Begin
        for i:=1 to n do
          begin
            for j:=1 to i-1 do
              begin
                if (i-k>0) then
                  begin
                    if i-k>=j then
                      begin
                        u:=(f[j,j-1]+p[j-1]) mod oo;
                        v:=c[j,j-1]+1;
                      end
                    else
                      begin
                        u:=(f[j,i-k]+p[j-1]) mod oo;
                        v:=c[j,i-k]+1;
                      end;
                  end
                else
                  begin
                    v:=1;
                    u:=p[j-1];
                  end;
                f[i,j]:=(f[i,j-1]+(int64(p[i-j-1])*int64(u)) mod oo) mod oo;
                c[i,j]:=(v+c[i,j-1]) mod oo;
              end;
            res:=(res+(int64(f[i,i-1])*int64(p[n-i])) mod oo) mod oo;
            res:=(res-c[i,i-1]+oo) mod oo;
          end;
        for i:=1 to n do res:=(res+(int64(p[i-1])*int64(p[n-i])) mod oo) mod oo;
        res:=(res-n+oo) mod oo;
      End;
 (***********************************************************************)
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





