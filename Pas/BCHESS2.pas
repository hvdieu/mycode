{$h+}
USES math;
CONST
        tfi     ='BCHESS.INP';
        tfo     ='BCHESS.OU1';
        nmax    =2000;
TYPE
        arr     =array [1..nmax] of  string;
        arr1    =array [1..nmax,1..nmax] of longint;
        arr2    =array [0..nmax] of longint;
VAR
        fi,fo   :text;
        a       :arr;
        f       :arr1;
        l,h     :arr2;
        n       :longint;
        t1,s1,t2,s2,t3,s3:longint;
 (******************************************************************)
PRocedure nhap;
      Var
        i       :longint;
      Begin
        assign(fi,tfi);reset(fi);
          readln(fi,n);
          for i:=1 to n do readln(fi,a[i]);
        close(fi);
      End;
 (******************************************************************)
Procedure lam;
      Var
        i,j,k   :longint;
      Begin
        for i:=1 to n do
          for j:=1 to n do
            begin
              if (j<>1) and (a[i,j]<>a[i,j-1]) then l[j]:=l[j-1]+1
              else l[j]:=1;
              if (i<>1) and (a[i-1,j]<>a[i,j]) then h[j]:=h[j]+1
              else h[j]:=1;
              f[i,j]:=1;
              if (i>1) and (j>1) and (a[i-1,j-1]=a[i,j]) then
                f[i,j]:=min(f[i-1,j-1]+1,min(l[j],h[j]));
            end;
        for i:=1 to n do
          for j:=1 to n do
            begin
              k:=f[i,j]-f[i,j] mod 2;
              if s1<k then
                begin
                  s1:=k;
                  t1:=1;
                end
              else if s1=k then inc(t1);
              k:=f[i,j]-(1-f[i,j] mod 2);
              if a[i,j]='1' then
                begin
                  if s2<k then
                    begin
                      s2:=k;
                      t2:=1;
                    end
                  else if s2=k then inc(t2);
                end
              else
                begin
                  if s3<k then
                    begin
                      s3:=k;
                      t3:=1;
                    end
                  else if s3=k then inc(t3);
                end;
            end;
      End;
 (******************************************************************)
Procedure inkq;
      Begin
        assign(fo,tfo);rewrite(fo);
          writeln(fo,s1,' ',t1);
          writeln(fo,s2,' ',t2);
          writeln(fo,s3,' ',t3);
        close(fo);
      End;
 (********************************************************************)
BEGIN
        nhap;
        lam;
        inkq;
END.

