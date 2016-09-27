CONST
        tfi     ='c11seq4.inp';
        tfo     ='c11seq4.out';
        nmax    =1500000;
TYPE
        arr     =array [0..nmax,0..1] of int64;
        arr1    =array [1..nmax] of longint;
        arr2    =array [0..1000,0..1000] of boolean;
        arr3    =array [1..4,1..4] of int64;
VAR
        fi,fo   :text;
        m,n     :int64;
        f       :arr;
        top     :longint;
        qx,qy   :arr1;
        free    :arr2;
        a,b     :arr3;
 (***********************************************************************)
Function nhan(x,y:int64):int64;
      Var
        tg      :int64;
      Begin
        if y=0 then exit(0);
        if y=1 then exit(x);
        tg:=nhan(x,y div 2);
        tg:=tg+tg;
        if tg>=m then tg:=tg-m;
        if y mod 2=1 then tg:=tg+x;
        if tg>=m then tg:=tg-m;
        exit(tg);
      End;
 (***********************************************************************)
Procedure sub1;
      Var
        i,j     :longint;
        u,v     :int64;
      Begin
        f[1,1]:=((n+1) div 2) mod m;
        f[1,0]:=(n div 2) mod m;
        u:=((n+1) div 2) mod m;v:=(n div 2+1) mod m;
        for i:=2 to n do
          begin
            f[i,1]:=(nhan(f[i-1,0],u)+nhan(f[i-1,1],u-1));
            if f[i,1]>=m then f[i,1]:=f[i,1]-m;
            f[i,0]:=(nhan(f[i-1,0],v-1)+nhan(f[i-1,1],v));
            if f[i,0]>=m then f[i,0]:=f[i,0]-m;
            f[i,1]:=f[i,1]+u;
            if f[i,1]>=m then f[i,1]:=f[i,1]-m;
            f[i,0]:=(f[i,0]+v-1) mod m;
            if f[i,0]>=m then f[i,0]:=f[i,0]-m;
          end;
        writeln(fo,f[n,1]);
      end;
 (***********************************************************************)
Procedure push(x,y:longint);
      Begin
        inc(top);
        qx[top]:=x;
        qy[top]:=y;
        free[x,y]:=true;
      end;
 (***********************************************************************)
Procedure sub2;
      Var
        i,u,v,p,q,j     :longint;
      Begin
        push(((n+1) div 2) mod m,(n div 2) mod m);
        u:=((n+1) div 2) mod m;v:=(n div 2+1) mod m;
        Repeat
          p:=((qy[top]*u) mod m+(qx[top]*(u-1)) mod m) mod m;
          q:=((qy[top]*(v-1)) mod m+(qx[top]*v) mod m) mod m;
          p:=(p+u) mod m;
          q:=(q+v-1) mod m;
          if free[p,q] then break;
          push(p,q);
        Until false;
        for i:=1 to top do
          if (qx[i]=p) and (qy[i]=q) then
            begin
              j:=i;
              break;
            end;
        n:=n mod (top-j+1);
        if n=0 then n:=top-j+1;
        write(fo,qx[j+n-1]);
      end;
 (***********************************************************************)
Operator *(m1,m2:arr3) m3:arr3;
      Var
        i,j,t   :longint;
        s       :longint;
      Begin
        for i:=1 to 4 do
          for j:=1 to 4 do
            begin
              m3[i,j]:=0;
              for t:=1 to 4 do
                m3[i,j]:=(nhan(m1[i,t],m2[t,j])+m3[i,j]) mod m;
            end;
      End;
 (************************************************************************)
Function mu(i:int64):arr3;
      Var
        tg      :arr3;
      Begin
        if i=1 then exit(a);
        tg:=mu(i div 2);
        tg:=tg*tg;
        if i mod 2=1 then tg:=tg*a;
        exit(tg);
      End;
 (************************************************************************)
Procedure sub3;
      Var
        u,v,res:int64;
        i       :longint;
      Begin
        u:=((n+1) div 2) mod m;v:=(n div 2+1) mod m;
        a[1,3]:=1;a[2,4]:=1;
        a[3,1]:=(m+1-v) mod m;a[3,2]:=(m-v) mod m;a[3,3]:=v;a[3,4]:=v;
        a[4,1]:=(m-u) mod m;a[4,2]:=(1-u+m) mod m;a[4,3]:=u;a[4,4]:=u;
        b:=mu(n-2);
        f[1,1]:=((n+1) div 2) mod m;
        f[1,0]:=(n div 2) mod m;
        for i:=2 to 2 do
          begin
            f[i,1]:=(nhan(f[i-1,0],u)+nhan(f[i-1,1],u-1));
            if f[i,1]>=m then f[i,1]:=f[i,1]-m;
            f[i,0]:=(nhan(f[i-1,0],v-1)+nhan(f[i-1,1],v));
            if f[i,0]>=m then f[i,0]:=f[i,0]-m;
            f[i,1]:=f[i,1]+u;
            if f[i,1]>=m then f[i,1]:=f[i,1]-m;
            f[i,0]:=(f[i,0]+v-1) mod m;
            if f[i,0]>=m then f[i,0]:=f[i,0]-m;
          end;
        res:=(nhan(f[2,1],b[4,4])+nhan(f[2,0],b[4,3])+nhan(f[1,0],b[4,1])+nhan(f[1,1],b[4,2])) mod m;
        writeln(fo,res);
      End;
 (**********************************************************************)
BEGIN
      assign(fi,tfi);reset(fi);
      assign(fo,tfo);rewrite(fo);
        read(fi,n,m);
        sub3;
      close(fi);
      close(fo);
END.

