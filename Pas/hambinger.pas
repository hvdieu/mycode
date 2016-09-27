CONST
        tfi     ='input.txt';
        tfo     ='harbinge.out';
        nmax    =100000;
TYPE
        arr     =array [0..nmax] of longint;
        arr1    =array [-nmax..nmax] of longint;
        arr2    =array [1..nmax] of real;
        arr3    =array [1..nmax] of int64;
VAR
        fi,fo   :text;
        head,s,v,d:arr;
        ke,next,ts:arr1;
        c       :arr2;
        f,p,q   :arr3;
        n,m,y   :longint;
 (*******************************************************************)
Procedure nhap;
      Var
        i,x,y,z :longint;
      Begin
        assign(fi,tfi);reset(fi);
          read(fi,n);
          for i:=1 to n-1 do
            begin
              read(fi,x,y,z);
              ke[i]:=y;
              next[i]:=head[x];
              head[x]:=i;
              ke[-i]:=x;
              next[-i]:=head[y];
              head[y]:=-i;
              ts[i]:=z;
              ts[-i]:=z;
            end;
         for i:=2 to n do read(fi,s[i],v[i]);
        close(fi);
      End;
 (********************************************************************)
Procedure push(x,y:int64;z:real);
      Begin
        inc(m);
        p[m]:=x;
        q[m]:=y;
        c[m]:=z;
      End;
 (*********************************************************************)
Function find(x:longint):longint;
      Var
        l,r,mid :longint;
      Begin
        l:=1;r:=m;
        while l<=r do
          begin
            mid:=(l+r) div 2;
            if c[mid]<=x then
              begin
                find:=mid;
                l:=mid+1;
              end
            else r:=mid-1;
          end;
      End;
 (*********************************************************************)
Function find1(a,b:int64):longint;
      Var
        l,r,mid :longint;
        k       :real;
      Begin
        l:=1;r:=m;
        find1:=m+1;
        while l<=r do
          begin
            mid:=(l+r) div 2;
            k:=(b-q[mid])/(p[mid]+a);
            if k<=c[mid] then
              begin
                find1:=mid;
                r:=mid-1;
              end
            else l:=mid+1;
          end;
      End;
 (*********************************************************************)
Procedure visit(i:longint);
      Var
        j,u,vi,l,t:longint;
        k,si     :real;
        a,b     :int64;
      Begin
        j:=head[i];
        l:=m;
        while j<>0 do
          begin
            if (d[ke[j]]=0) and (ke[j]<>1) then
              begin
                d[ke[j]]:=d[i]+ts[j];
                u:=find(v[ke[j]]);
                f[ke[j]]:=int64(s[ke[j]])+int64(d[ke[j]])*v[ke[j]]
                          +int64(p[u])*v[ke[j]]+q[u];
                vi:=find1(d[ke[j]],f[ke[j]]);
                a:=p[vi];
                b:=q[vi];
                si:=c[vi];
                k:=(f[ke[j]]-q[vi-1])/(p[vi-1]+d[ke[j]]);
                m:=vi-1;
                push(-d[ke[j]],f[ke[j]],k);
                visit(ke[j]);
                m:=l;
                p[vi]:=a;
                q[vi]:=b;
                c[vi]:=si;
              end;
            j:=next[j];
          end;
      End;
 (**********************************************************************)
Procedure inkq;
      Var
        i       :longint;
      Begin
        assign(fo,tfo);rewrite(fo);
          for i:=2 to n do writeln(fo,f[i],' ');
        close(fo);
      End;
 (**********************************************************************)
BEGIN
        nhap;
        push(0,0,0);
        visit(1);
        inkq;
END.

