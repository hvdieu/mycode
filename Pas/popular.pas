USES math;
CONST
        tfi     ='popular.inp';
        tfo     ='popular.out';
        nmax    =150000;
        mmax    =300000;
TYPE
        arr     =array [0..nmax] of longint;
        arr2    =array [1..nmax] of boolean;
        arr3    =array [-mmax..mmax] of longint;
VAR
        fi,fo   :text;
        n,m,top,dem,res:longint;
        head,st,g,num,low,a,dd,head2,d,vt:arr;
        free    :arr2;
        ke2,next2,ke,next:arr3;
 (*******************************************************************)
Procedure nhap;
      Var
        i,x,y   :longint;
      Begin
        assign(fi,tfi);reset(fi);
          read(fi,n,m);
          for i:=1 to m do
            begin
              read(fi,x,y);
              ke[i]:=y;
              next[i]:=head[x];
              head[x]:=i;
              ke[-i]:=x;
              next[-i]:=head[y];
              head[y]:=-i;
            end;
        close(fi);
      End;
 (********************************************************************)
Procedure dfs(i,t:longint);
      Var
        j       :longint;
      Begin
        j:=head[i];
        free[i]:=true;
        inc(dd[i]);
        while j<>0 do
          begin
            if ((j*t)>0) and (free[ke[j]]=false) then dfs(ke[j],t);
            j:=next[j];
          end;
      End;
 (*********************************************************************)
Procedure sub1;
      Var
        i,j     :longint;
        kt      :boolean;
      Begin
        for i:=1 to n do
          begin
            for j:=1 to n do
              begin
                dd[j]:=0;
                free[j]:=false;
              end;
            dfs(i,1);
            for j:=1 to n do free[j]:=false;
            dfs(i,-1);
            kt:=true;
            for j:=1 to n do
              if dd[j]=0 then kt:=false;
            if kt then
              begin
                inc(top);
                st[top]:=i;
              end;
          end;
        writeln(fo,top);
        for i:=1 to top do write(fo,st[i],' ');
      End;
 (************************************************************************)
Procedure visit(i:longint);
      Var
        j,u     :longint;
      Begin
        j:=head[i];
        inc(dem);
        num[i]:=dem;
        low[i]:=dem;
        inc(top);
        st[top]:=i;
        while j<>0 do
          begin
            if (j>0) and (free[ke[j]]=false) then
              begin
                if num[ke[j]]=0 then
                  begin
                    visit(ke[j]);
                    low[i]:=min(low[i],low[ke[j]]);
                  end
                else low[i]:=min(low[i],num[ke[j]]);
              end;
            j:=next[j];
          end;
        u:=0;
        if low[i]=num[i] then
          while u<>i do
            begin
              u:=st[top];
              dec(top);
              free[u]:=true;
              g[u]:=i;
            end;
      End;
 (*********************************************************************)
Procedure doicho(var x,y:longint);
      Var
        tg      :longint;
      Begin
        tg:=x;
        x:=y;
        y:=tg;
      End;
 (**********************************************************************)
Procedure sort(l,r:longint);
      Var
        i,j,key :longint;
      Begin
        i:=l;j:=r;
        key:=g[a[l+Random(r-l+1)]];
        Repeat
          while g[a[i]]<key do inc(i);
          while g[a[j]]>key do dec(j);
          if i<=j then
            begin
              doicho(a[i],a[j]);
              inc(i);
              dec(j);
            end;
        Until i>j;
        if i<r then sort(i,r);
        if l<j then sort(l,j);
      End;
 (***********************************************************************)
Procedure union(x,y:longint);
      Begin
        inc(m);
        ke2[m]:=y;
        next2[m]:=head2[x];
        head2[x]:=m;
        ke2[-m]:=x;
        next2[-m]:=head2[y];
        head2[y]:=-m;
      End;
 (***********************************************************************)
Procedure visit2(i:longint);
      Var
        j       :longint;
      Begin
        j:=head2[i];
        free[i]:=false;
        while j<>0 do
          begin
            if (j>0) and (free[ke2[j]]) then visit2(ke2[j]);
            j:=next2[j];
          end;
        inc(top);
        st[top]:=i;
      End;
 (**********************************************************************)
Procedure khoitao;
      Var
        i,j,u    :longint;
      Begin
        for i:=1 to n do
          begin
            if num[i]=0 then visit(i);
            a[i]:=i;
          end;
        sort(1,n);
        m:=0;
        for i:=1 to n do
          if g[a[i]]<>g[a[i-1]] then
            begin
              j:=i;top:=0;inc(dem);
              while (j<=n) and (g[a[j]]=g[a[i]]) do
                begin
                  u:=head[a[j]];
                  while u<>0 do
                    begin
                      if (u>0) and (g[ke[u]]<>g[a[j]]) and (dd[g[ke[u]]]<>dem) then
                        begin
                          inc(top);
                          st[top]:=g[ke[u]];
                          dd[g[ke[u]]]:=dem;
                        end;
                      u:=next[u];
                    end;
                  inc(j);
                end;
              for j:=1 to top do union(g[a[i]],st[j]);
            end;
        top:=0;
        for i:=1 to n do
          if free[g[i]] then visit2(g[i]);
      End;
 (*********************************************************************)
Procedure lam;
      Var
        i,j,u,k :longint;
      Begin
        for i:=1 to top do
          begin
            vt[st[i]]:=i;
            free[st[i]]:=false;
          end;
        k:=0;d[1]:=1;
        for i:=1 to top do
          begin
            j:=head2[st[i]];
            u:=maxlongint;
            while j<>0 do
              begin
                if j<0 then u:=min(u,vt[ke2[j]]);
                j:=next2[j];
              end;
            if k=i then d[i]:=1;
            k:=max(k,u);
          end;
        inc(d[top]);
        k:=maxlongint;
        for i:=top downto 1 do
          begin
            j:=head2[st[i]];
            u:=-maxlongint;
            while j<>0 do
              begin
                if j>0 then u:=max(u,vt[ke2[j]]);
                j:=next2[j];
              end;
            if k=i then inc(d[i]);
            k:=min(k,u);
          end;
        for i:=1 to top do
          if d[i]=2 then free[st[i]]:=true;
      End;
 (*********************************************************************)
Procedure inkq;
      Var
        i       :longint;
      Begin
          for i:=1 to n do
            if free[g[i]] then inc(res);
          writeln(fo,res);
          for i:=1 to n do
            if free[g[i]] then write(fo,i,' ');
      End;
 (*********************************************************************)
BEGIN
      assign(fo,tfo);rewrite(fo);
        nhap;
    //    if (n<=700) and (m<=1100) then sub1
       // else
          begin
            khoitao;
            lam;
            inkq;
          end;
      close(fo);
END.
