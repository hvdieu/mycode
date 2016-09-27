CONST
        tfi     ='voscun.inp';
        tfo     ='voscun.ou1';
        nmax    =1000;
TYPE
        arr     =array [1..nmax] of longint;
        arr1    =array [1..nmax] of boolean;
VAR
        fi,fo   :text;
        d,q     :arr;
        n,r,f,m,u:longint;
        res     :int64;
        free    :arr1;
 (**********************************************************************)
Procedure push(x:longint);
      Begin
        inc(r);
        q[r]:=x;
        free[x]:=true;
      End;
 (*********************************************************************)
Procedure pop;
      Begin
        u:=q[f];
        inc(f);
      End;
 (*********************************************************************)
Procedure lam;
      Var
        i,a,b,c,v,j,s:longint;
      Begin
        read(fi,n);
        push(1);
        f:=1;
        while f<=r do
          begin
            pop;
            for j:=0 to 10 do
              begin
                v:=u+1 shl j;
                if (v<=n) and (free[v]=false) then
                  begin
                    d[v]:=d[u]+1;
                    push(v);
                  end;
                v:=u-1 shl j;
                if (v>0) and (free[v]=false) then
                  begin
                    d[v]:=d[u]+1;
                    push(v);
                  end;
              end;
          end;
        s:=0;
        for i:=1 to n do s:=s+d[i];
        for i:=1 to n do
          for j:=1 to n do
            res:=res+int64(n)*(d[i]+d[j])+s;
        writeln(fo,res);
        read(fi,m);
        for i:=1 to m do
          begin
            read(fi,a,b,c);
            s:=d[a]+d[b]+d[c];
            writeln(fo,s);
          end;
      end;
 (**********************************************************************)
BEGIN
      assign(fi,tfi);reset(fi);
      assign(fo,tfo);rewrite(fo);
        lam;
      close(fi);
      close(fo);
END.

