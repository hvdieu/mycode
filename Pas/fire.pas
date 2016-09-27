USES math;
CONST
        tfi     ='input.txt';
        tfo     ='fire.out';
        nmax    =10000;
TYPE
        arr     =array [1..nmax] of double;
VAR
        fi,fo   :text;
        x,y,r,a,b,c:arr;
        n       :longint;
        res     :double;
 (********************************************************************)
Procedure nhap;
      Var
        i       :longint;
      Begin
        assign(fi,tfi);reset(fi);
          read(fi,n);
          for i:=1 to n do read(fi,x[i],y[i],r[i]);
        close(fi);
      End;
 (*********************************************************************)
Procedure doicho(var x,y:double);
      Var
        tg      :double;
      Begin
        tg:=x;
        x:=y;
        y:=tg;
      End;
 (**********************************************************************)
Procedure sort(l,r:longint);
      Var
        i,j,x   :longint;
        key,key1,key3:double;
      Begin
        i:=l;j:=r;
        x:=l+random(r-l+1);
        key:=a[x];
        key1:=b[x];
        key3:=c[x];
        Repeat
          while (a[i]<key) or ((a[i]=key) and (b[i]<key1)) or
          ((a[i]=key) and (b[i]=key1) and (c[i]<key3)) do inc(i);
          while (a[j]>key) or ((a[j]=key) and (b[j]>key1)) or
          ((a[j]=key) and (b[j]=key1) and (c[j]>key3)) do dec(j);
          if i<=j then
            begin
              doicho(a[i],a[j]);
              doicho(b[i],b[j]);
              doicho(c[i],c[j]);
              inc(i);
              dec(j);
            end;
        Until i>j;
        if i<r then sort(i,r);
        if l<j then sort(l,j);
      End;
 (*********************************************************************)
Function kc(x,y,p,q:double):double;
      Begin
        kc:=sqrt((x-p)*(x-p)+(y-q)*(y-q));
      End;
 (*********************************************************************)
Procedure lam;
      Var
        i,j     :longint;
      Begin
        res:=1000000;
        for i:=1 to n do
          begin
            a[i]:=x[i];
            b[i]:=y[i];
            c[i]:=r[i];
          end;
        sort(1,n);
        for i:=1 to n do
          for j:=max(i-100,1) to i-1 do
           res:=min(res,kc(a[i],b[i],a[j],b[j])-c[i]-c[j]);
      {  for i:=1 to n do
          begin
            a[i]:=x[i];
            b[i]:=r[i];
            c[i]:=y[i];
          end;
        sort(1,n);
        for i:=1 to n do
          for j:=max(i-100,1) to i-1 do
           res:=min(res,kc(a[i],c[i],a[j],c[j])-b[i]-b[j]);  }
        for i:=1 to n do
          begin
            a[i]:=y[i];
            b[i]:=x[i];
            c[i]:=r[i];
          end;
        sort(1,n);
        for i:=1 to n do
          for j:=max(i-100,1) to i-1 do
           res:=min(res,kc(a[i],b[i],a[j],b[j])-c[i]-c[j]);
       { for i:=1 to n do
          begin
            a[i]:=y[i];
            b[i]:=r[i];
            c[i]:=x[i];
          end;
        sort(1,n);
        for i:=1 to n do
          for j:=max(i-100,1) to i-1 do
           res:=min(res,kc(a[i],c[i],a[j],c[j])-b[i]-b[j]); }
        for i:=1 to n do
          begin
            a[i]:=r[i];
            b[i]:=x[i];
            c[i]:=y[i];
          end;
        sort(1,n);
        for i:=1 to n do
          for j:=max(i-100,1) to i-1 do
           res:=min(res,kc(c[i],b[i],c[j],b[j])-a[i]-a[j]);
        for i:=1 to n do
          begin
            a[i]:=r[i];
            b[i]:=y[i];
            c[i]:=x[i];
          end;
        sort(1,n);
        for i:=1 to n do
          for j:=max(i-100,1) to i-1 do
           res:=min(res,kc(c[i],b[i],c[j],b[j])-a[i]-a[j]);
      End;
 (**********************************************************************)
Procedure inkq;
      Begin
        assign(fo,tfo);rewrite(fo);
          write(fo,(trunc(res*10000)/10000):0:4);
        close(fo);
      End;
 (***********************************************************************)
BEGIN
        nhap;
        lam;
        inkq;
END.


