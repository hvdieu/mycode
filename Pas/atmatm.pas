USES math;
CONST
        tfi     ='ATM.inp';
        tfo     ='ATMATM.out';
        nmax    =500000;
TYPE
        arr     =array [1..nmax] of longint;
        arr1    =array [-nmax..nmax] of longint;
        arr2    =array [1..nmax] of boolean;
VAR
        fi,fo   :text;
        head,num,low,g,s,head2,c,p,d,f,vt:arr;
        ke,next,ke2,next2:arr1;
        free,dd :arr2;
        n,m,dem,top,st,t,res:longint;
 (********************************************************************)
PRocedure nhap;
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
          for i:=1 to n do read(fi,c[i]);
          read(fi,st,t);
          for i:=1 to t do read(fi,p[i]);
          m:=0;
        close(fi);
      End;
 (*********************************************************************)
Procedure visit(i:longint);
      Var
        j,u     :longint;
      Begin
        j:=head[i];
        inc(dem);
        num[i]:=dem;
        low[i]:=dem;
        inc(top);
        s[top]:=i;
        while j<>0 do
          begin
            if (j>0) and (g[ke[j]]=0) then
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
        if low[i]=num[i] then
          while u<>i do
            begin
              u:=s[top];
              dec(top);
              g[u]:=i;
            end;
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
 (************************************************************************)
Procedure khoitao;
      Var
        i,j     :longint;
      Begin
        for i:=1 to n do
          if num[i]=0 then visit(i);
        for i:=1 to n do
          begin
            j:=head[i];
            while j<>0 do
              begin
                if (j>0) and (g[i]<>g[ke[j]]) then union(g[i],g[ke[j]]);
                j:=next[j];
              end;
          end;
      End;
 (***********************************************************************)
Procedure dfs(i:longint);
      Var
        j       :longint;
      Begin
        j:=head2[i];
        free[i]:=true;
        while j<>0 do
          begin
            if (j>0) and (free[ke2[j]]=false) then dfs(ke2[j]);
            j:=next2[j];
          end;
        inc(top);
        s[top]:=i;
      End;
 (************************************************************************)
Procedure lam;
      Var
        i,j     :longint;
      Begin
        for i:=1 to n do
          if free[g[i]]=false then dfs(g[i]);
        for i:=1 to n do
          begin
            free[i]:=false;
            d[g[i]]:=d[g[i]]+c[i];
          end;
        for i:=1 to t do free[g[p[i]]]:=true;
        for i:=1 to top do vt[s[i]]:=i;
        for i:=1 to top do
          if (dd[i]) or (free[s[i]]) then
            begin
              j:=head2[s[i]];
              f[i]:=f[i]+d[s[i]];
              while j<>0 do
                begin
                  if (j<0) then
                    begin
                      dd[vt[ke2[j]]]:=true;
                      f[vt[ke2[j]]]:=max(f[i],f[vt[ke2[j]]]);
                    end;
                  j:=next2[j];
                end;
              if s[i]=g[st] then
                begin
                  res:=f[i];
                  break;
                end;
          end;
      End;
 (*************************************************************************)
Procedure inkq;
      Begin
        assign(fo,tfo);rewrite(fo);
          write(fo,res);
        close(fo);
      End;
 (*************************************************************************)
BEGIN
        nhap;
        khoitao;
        lam;
        inkq;
END.
