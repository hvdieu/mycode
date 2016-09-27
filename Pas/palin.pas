{$h+}
USES math;
CONST
        tfi     ='palin.inp';
        tfo     ='palin.ou1';
        nmax    =500;
        oo      =1000000007;
TYPE
        arr     =array [0..1,0..nmax,0..nmax] of longint;
VAR
        fi,fo   :text;
        n,m,res :longint;
        f       :arr;
        s1,s2   :string;
 (**********************************************************************)
Procedure nhap;
      Begin
        assign(fi,tfi);reset(fi);
          readln(fi,s1);
          readln(fi,s2);
        close(fi);
      End;
 (***********************************************************************)
Procedure lam;
      Var
        i,ok,u,l,j,v:longint;
      Begin
        m:=length(s1);n:=length(s2);
        ok:=0;f[0,0,0]:=1;
        for l:=0 to min(n,(m+n) div 2) do
          begin
            for i:=0 to (m+n) div 2 do
              begin;
                for j:=max(l-i,0) to (m+n) div 2-i-1 do
                  if f[ok,i,j]<>0 then
                    begin
                      u:=m-(i+j-l)+1;v:=n-l+1;
                      if i>=u-1 then break;
                      if (i<u-2) and (s1[i+1]=s1[u-1]) then
                        begin
                          f[ok,i+1,j]:=f[ok,i+1,j]+f[ok,i,j];
                          if f[ok,i+1,j]>oo then f[ok,i+1,j]:=f[ok,i+1,j]-oo;
                        end;
                      if (j<v-1) and (s2[j+1]=s1[u-1]) then
                        begin
                          f[ok,i,j+1]:=f[ok,i,j+1]+f[ok,i,j];
                          if f[ok,i,j+1]>oo then f[ok,i,j+1]:=f[ok,i,j+1]-oo;
                        end;
                    end;
                j:=(m+n) div 2-i;
                res:=res+f[ok,i,j];
                if res>oo then res:=res-oo;
                f[ok,i,j]:=0;
              end;
            for i:=0 to (m+n) div 2 do
              begin
                for j:=max(l-i,0) to (m+n) div 2-i-1 do
                  if f[ok,i,j]<>0 then
                    begin
                      u:=n-l+1;v:=m-(i+j-l)+1;
                      if j<u-1 then
                        begin
                          if (i<v-1) and (s1[i+1]=s2[u-1]) then
                            begin
                              f[1-ok,i+1,j]:=f[1-ok,i+1,j]+f[ok,i,j];
                              if f[1-ok,i+1,j]>oo then f[1-ok,i+1,j]:=f[1-ok,i+1,j]-oo;
                            end;
                          if (j<u-2) and (s2[j+1]=s2[u-1]) then
                            begin
                              f[1-ok,i,j+1]:=(f[1-ok,i,j+1]+f[ok,i,j]) mod oo;
                              if f[1-ok,i,j+1]>oo then f[1-ok,i,j+1]:=f[1-ok,i,j+1]-oo;
                            end;
                        end;
                      f[ok,i,j]:=0;
                    end;
              end;
            ok:=1-ok;
          end;
      End;
 (***********************************************************************)
Procedure inkq;
      Begin
        assign(fo,tfo);rewrite(fo);
          write(fo,res);
        close(fo);
      End;
 (************************************************************************)
BEGIN
        nhap;
        lam;
        inkq;
END.
