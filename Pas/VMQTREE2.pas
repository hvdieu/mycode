USES math;
CONST
        tfi     ='vmqtree.inp';
        tfo     ='vmqtree2.out';
        nmax    =50000;
        oo      =1000000000;
TYPE
        arr     =array [0..nmax] of longint;
        arr1    =array [-nmax..nmax] of longint;
        arr2    =array [1..nmax,1..3] of longint;
        arr3    =array [0..nmax,0..16] of longint;
VAR
        fi,fo   :text;
        n,t,q,gh,pp:longint;
        head,pa,d,h,p:arr;
        ke,next,ts:arr1;
        g       :arr2;
        f,f1,f2 :arr3;
 (************************************************************************)
Procedure nhap;
      Var
        i,x,y   :longint;
      Begin
        read(fi,n);
        for i:=1 to n do
          begin
            head[i]:=0;
            pa[i]:=0;
          end;
        for i:=1 to n-1 do
          begin
            read(fi,x,y);
            ke[i]:=y;
            next[i]:=head[x];
            head[x]:=i;
            ke[-i]:=x;
            next[-i]:=head[y];
            head[y]:=-i;
          end;
      End;
 (************************************************************************)
Procedure visit(i:longint);
      Var
        j       :longint;
      Begin
        j:=head[i];
        g[i,1]:=0;g[i,2]:=0;g[i,3]:=0;
        while j<>0 do
          begin
            if (ke[j]<>1) and (pa[ke[j]]=0) then
              begin
                pa[ke[j]]:=i;
                d[ke[j]]:=d[i]+1;
                visit(ke[j]);
                if g[ke[j],1]+1>=g[i,1] then
                  begin
                    g[i,3]:=g[i,2];
                    g[i,2]:=g[i,1];
                    g[i,1]:=g[ke[j],1]+1;
                  end
                else if g[ke[j],1]+1>=g[i,2] then
                  begin
                    g[i,3]:=g[i,2];
                    g[i,2]:=g[ke[j],1]+1;
                  end
                else if g[ke[j],1]+1>g[i,3] then g[i,3]:=g[ke[j],1]+1;
              end;
            j:=next[j];
          end;
      End;
 (************************************************************************)
Procedure dfs(i:longint);
      Var
        j       :longint;
      Begin
        j:=head[i];
        while j<>0 do
          begin
            if (pa[ke[j]]=i) then
              begin
                if g[ke[j],1]+1=g[i,1] then p[ke[j]]:=g[i,2] else p[ke[j]]:=g[i,1];
                h[ke[j]]:=max(h[i],p[ke[j]])+1;
                dfs(ke[j]);
              end;
            j:=next[j];
          end;
      End;
 (**********************************************************************)
Procedure khoitao;
      Var
        i,j     :longint;
      Begin
        visit(1);dfs(1);
        p[1]:=-oo;
        for i:=1 to n do
          begin
            f[i,0]:=pa[i];
            f1[i,0]:=p[i]-d[pa[i]];
            f2[i,0]:=p[i]+d[pa[i]];
          end;
        for j:=1 to 16 do
          begin
            for i:=1 to n do
              begin
                f[i,j]:=f[f[i,j-1],j-1];
                f1[i,j]:=max(f1[i,j-1],f1[f[i,j-1],j-1]);
                f2[i,j]:=max(f2[i,j-1],f2[f[i,j-1],j-1]);
              end;
            gh:=j;
            if 1 shl j>=n then break;
          end;
        d[0]:=-1;
      End;
 (***********************************************************************)
Procedure doicho(var x,y:longint);
      Var
        tg      :longint;
      Begin
        tg:=x;
        x:=y;
        y:=tg;
      End;
 (***********************************************************************)
Function get2(i,u:longint):longint;
      Var
        j       :longint;
      Begin
        get2:=-oo;
        if u<=0 then exit;
        for j:=gh downto 0 do
          if 1 shl j<=u then
            begin
              u:=u-1 shl j;
              get2:=max(get2,f2[i,j]);
              i:=f[i,j];
            end;
      End;
 (***********************************************************************)
Function get1(i,u:longint):longint;
      Var
        j       :longint;
      Begin
        get1:=-oo;
        if u<=0 then exit;
        for j:=gh downto 0 do
          if 1 shl j<=u then
            begin
              u:=u-1 shl j;
              get1:=max(get1,f1[i,j]);
              i:=f[i,j];
            end;
        pp:=i;
      End;
 (***********************************************************************)
Function get(u,v:longint):longint;
      Var
        i,p,q,k,j:longint;
      Begin
        if d[u]<d[v] then doicho(u,v);
        p:=v;q:=u;
        for i:=gh downto 0 do
          if d[f[u,i]]>=d[v] then u:=f[u,i];
        if u=v then
          begin
            get:=max(g[q,1],h[u]);k:=g[q,1]+d[q]-d[p];
            k:=max(k,get2(q,d[q]-d[p]-1)-d[p]);
            if k=g[p,1] then get:=max(get,g[p,2]) else get:=max(get,g[p,1]);
            get:=max(get2(pp,d[q]-d[p]-(d[q]-d[p]) div 2-1)-d[p],max(get,get1(q,(d[q]-d[p]) div 2)+d[q]));
            exit;
          end;
        for i:=gh downto 0 do
          if f[u,i]<>f[v,i] then
            begin
              u:=f[u,i];
              v:=f[v,i];
            end;
        j:=1;
        if max(g[u,1]+1,g[v,1]+1)=g[pa[u],1] then inc(j);
        if min(g[u,1]+1,g[v,1]+1)=g[pa[u],j] then inc(j);
        u:=pa[u];get:=max(max(h[u],g[u,j])+d[p]-d[u],max(g[p,1],g[q,1]));
        get:=max(get,get1(p,d[p]-d[u]-1)+d[p]);
        if d[p]<>d[q] then get:=max(get2(pp,d[q]-d[u]-(d[q]+d[p]-2*d[u]) div 2-1)-2*d[u]+d[p],
        max(get,get1(q,(d[q]+d[p]-2*d[u]) div 2)+d[q]))
        else get:=max(get,get1(q,d[q]-d[u]-1)+d[q]);
      End;
 (**********************************************************************)
Procedure inkq;
      Var
        i,u,v   :longint;
      Begin
        readln(fi,q);
        for i:=1 to q do
          begin
            read(fi,u,v);
            writeln(fo,get(u,v));
          end;
      End;
 (************************************************************************)
BEGIN
      assign(fi,tfi);reset(fi);
      assign(fo,tfo);rewrite(fo);
        read(fi,t);
        while t<>0 do
          begin
            nhap;
            khoitao;
            inkq;
            dec(t);
          end;
      close(fi);
      close(fo);
END.






