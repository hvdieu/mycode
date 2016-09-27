{$h+}
USES math;
CONST
        tfi     ='NKCNT1.INP';
        tfo     ='NKCNT1.OU1';
        nmax    =5000;
TYPE
        arr     =array [0..nmax,0..nmax] of longint;
        arr1    =array [1..nmax] of longint;
        arr2    =array [1..nmax] of string;
VAR
        fi,fo   :text;
        f       :arr;
        h,l     :arr1;
        n,m     :longint;
        res     :int64;
        st      :arr2;
 (*************************************************************************)
Procedure nhap;
      Var
        i,j     :longint;
      Begin
        assign(fi,tfi);reset(fi);
          readln(fi,m,n);
          for i:=1 to m do
            begin
              read(fi,st[i]);
              readln(fi);
            end;
        close(fi);
      End;
 (************************************************************************)
Procedure lam;
      Var
        i,j,t   :longint;
      Begin
        for i:=1 to m do
          for j:=1 to n do
            if st[i,j]='0' then
              begin
               t:=min(min(h[j],l[i]),f[i-1,j-1]);
               f[i,j]:=t+1;
               res:=res+int64(t)+1;
               inc(l[i]);
               inc(h[j]);
              end
            else
              begin
                l[i]:=0;
                h[j]:=0;
              end;
      End;
 (**********************************************************************)
Procedure inkq;
      Begin
        assign(fo,tfo);rewrite(fo);
          write(fo,res);
        close(fo);
      End;
 (*********************************************************************)
BEGIN
        nhap;
        lam;
        inkq;
END.



