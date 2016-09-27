USES math;
CONST
        tfi     ='vogcdsum.inp';
        tfo     ='vogcdsum.ou1';
        nmax    =100000;
        oo      =1000000007;
TYPE
        arr     =array [1..nmax] of int64;
        arr1    =array [0..nmax,1..200] of longint;
        arr2    =array [0..nmax,0..17] of int64;
VAR
        fi,fo   :text;
        a       :arr;
        n       :longint;
        res,s   :int64;
        c       :arr1;
        f,g     :arr2;
 (************************************************************************)
Procedure nhap;
      Var
        i       :longint;
      Begin
        assign(fi,tfi);reset(fi);
          read(fi,n);
          s:=0;
          for i:=1 to n do
            begin
              read(fi,a[i]);
              s:=max(s,a[i]);
            end;
        close(fi);
      end;
 (************************************************************************)
Function ucln(x,y:int64):int64;
      Begin
        if x=0 then exit(y);
        if y=0 then exit(x);
        if x>=y then ucln:=ucln(x mod y,y)
        else ucln:=ucln(x,y mod x);
      End;
 (************************************************************************)
Procedure sub1;
      Var
        i,j     :longint;
        s       :int64;
      Begin
        for i:=1 to n do
          begin
            s:=a[i];
            res:=(res+s) mod oo;
            for j:=i-1 downto 1 do
              begin
                s:=ucln(s,a[j]);
                res:=(res+s) mod oo;
              end;
          end;
        writeln(fo,res);
      End;
 (**********************************************************************)
Function find(i,x:longint):longint;
      Var
        l,r,mid :longint;
      Begin
        l:=1;r:=i;
        find:=i+1;
        while l<=r do
          begin
            mid:=(l+r) div 2;
            if c[i,x]-c[mid-1,x]=i-mid+1 then
              begin
                find:=mid;
                r:=mid-1;
              end
            else l:=mid+1;
          end;
      end;
 (*********************************************************************)
Procedure sub2;
      Var
        i,j,u,v :longint;
      Begin
        res:=0;
        for i:=1 to n do
          for j:=1 to s do
            begin
              if a[i] mod j=0 then u:=1 else u:=0;
              c[i,j]:=c[i-1,j]+u;
            end;
        for i:=1 to n do
          begin
            u:=i+1;
            for j:=a[i] downto 1 do
              if a[i] mod j=0 then
                begin
                  v:=find(i,j);
                  if v<u then
                    begin
                      res:=(res+int64(j)*(u-v)) mod oo;
                      u:=v;
                    end;
                end;
          end;
        writeln(fo,res);
      End;
 (**********************************************************************)
Procedure sub3;
      Var
        i,j,u,vt:longint;
        s,t     :int64;
      Begin
        res:=0;
        for i:=1 to n do
          begin
            f[i,0]:=a[i];
            g[i,0]:=i;
          end;
        for j:=1 to 17 do
          begin
            for i:=1 shl j to n do
              begin
                f[i,j]:=ucln(f[i,j-1],f[g[i,j-1]-1,j-1]);
                g[i,j]:=g[g[i,j-1]-1,j-1];
              end;
            if 1 shl j>=n then break;
          end;
        for i:=1 to n do
          begin
            s:=a[i];
            vt:=i;
            Repeat
              u:=i;
              t:=a[i];
              for j:=17 downto 0 do
                if not(f[u,j]=0) and (ucln(t,f[u,j])>=s) then
                  begin
                    t:=ucln(t,f[u,j]);
                    u:=g[u,j]-1;
                  end;
              res:=(res+s*(vt-u)) mod oo;
              if u=0 then break;
              vt:=u;
              s:=ucln(t,a[u]);
            Until false;
          end;
        writeln(fo,res);
      end;
 (**********************************************************************)
BEGIN
      assign(fo,tfo);rewrite(fo);
        nhap;
        sub3;
      close(fo);
END.

