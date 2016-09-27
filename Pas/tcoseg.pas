USES math;
CONSt
        tfi     ='input.txt';
        tfo     ='viethoho.txt';
        nmax    =1200;
TYPE
        arr     =array [1..nmax] of longint;
        arr2    =array [1..2*nmax] of real;
VAR
        fi,fo   :text;
        a,b     :arr;
        c       :arr2;
        xm,ym,xf,yf,xa,ya,xp,yp,n,m:longint;
        k       :real;
        res     :int64;
 (********************************************************************)
Procedure nhap;
      Var
        i       :longint;
      Begin
        assign(fi,tfi);reset(fi);
          read(fi,n,xf,xa,xp,xm,yf,ya,yp,ym);
        close(fi);
      End;
 (********************************************************************)
Procedure khoitao;
      Var
        i       :longint;
        s       :int64;
      Begin
        a[1]:=xf;
        b[1]:=yf;
        for i:=2 to n do
          begin
            s:=(int64(a[i-1])*int64(xp)+int64(xa)) mod xm;
            a[i]:=s;
            s:=(int64(b[i-1])*int64(yp)+int64(ya)) mod ym;
            b[i]:=s;
          end;
      End;
 (***********************************************************************)
Procedure doicho(var x,y:real);
      Var
        tg      :real;
      Begin
        tg:=x;
        x:=y;
        y:=tg;
      End;
 (************************************************************************)
Procedure sort(l,r:longint);
      Var
        i,j     :longint;
        key     :real;
      Begin
        i:=l;j:=r;
        key:=c[l+Random(r-l+1)];
        Repeat
          while c[i]<key do inc(i);
          while c[j]>key do dec(j);
          if i<=j then
            begin
              doicho(c[i],c[j]);
              inc(i);
              dec(j);
            end;
        Until i>j;
        if i<r then sort(i,r);
        if l<j then sort(l,j);
      End;
 (**********************************************************************)
Procedure push(x:real);
      Begin
        inc(m);
        c[m]:=x;
      End;
 (***********************************************************************)
Function check:int64;
      Var
        i,j     :longint;
        s       :int64;
      Begin
        s:=m*(m-1)*(m-2) div 6;
        for i:=1 to m+1 do if c[i]-c[1]>180 then
          begin
            j:=i-1;
            break;
          end;
        s:=s-(j-1)*(j-2) div 2;
        for i:=2 to m do
          begin
            while c[j]-c[i]<=180 do inc(j);
            s:=s-(j-i-1)*(j-i-2) div 2;
          end;
        exit(s);
      End;
 (************************************************************************)
Procedure lam;
      Var
        i,j,vhh    :longint;
        s       :real;
      Begin
        for i:=1 to n do
          begin
            m:=0;
            for j:=1 to n do
              if j<>i then
                begin
                  s:=(a[j]-a[i])/sqrt((sqr(int64(a[j])-int64(a[i]))+sqr(int64(b[j])-int64(b[i]))));
                  s:=arccos(s)*180/pi;
                  if b[j]<b[i] then s:=360-s;
                  push(s);
                end;
            sort(1,m);
            for j:=m+1 to 2*m do c[j]:=c[j-m]+360;
            vhh := check;
            res:=res+vhh;
            writeln(fo,vhh );
          end;
      End;
 (************************************************************************)
Procedure xuli;
      Var
        k       :int64;
      Begin
        k:=int64(n)*(n-1)*(n-2)*(n-3) div 24;
        res:=k-res;
      End;
 (***********************************************************************)
Procedure inkq;
      Begin
          write(fo,res);
        close(fo);
      End;
 (************************************************************************)
BEGIN
        nhap;
        assign(fo,tfo);rewrite(fo);
        khoitao;
        if (n<=3) then res:=0
        else
          begin
            lam;
            xuli;
          end;
        inkq;
END.

