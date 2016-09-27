{$MODE OBJFPC}
Const     inp = 'SPSEQ.INP';
          out = 'SPSEQ.OUT';
          maxn = 100010;
Var       fi,fo         :       text;
          a             :       array [0..maxn+1] of longint;
          lu,l,startofu,startof     :       array [0..maxn+1] of longint;
          n,m,k,max     :       longint;
{*        *     *       *         *}
Procedure Input;
Var i : longint;
BEGIN
      assign(fi,inp);reset(fi);
      readln(fi,n);
      for i:=1 to n do read(fi,a[i]);
      close(fi);
END;
{*      *       *       *       *}
Procedure Initd;
BEGIN
    fillchar(l,sizeof(l),0);
    fillchar(startof,sizeof(startof),0);
    a[0]:=maxint;
    a[n+1]:=-maxint;
    l[n+1]:=1;
    startof[1]:=n+1;
    m:=1;
END;
{*      *       *       *       *}
Function Findd(i : longint) : longint;
Var dau,cuoi,giua,j : longint;
BEGIN
    dau:=1;cuoi:=m+1;
    repeat
        giua:=(dau+cuoi) div 2;
        j:=startof[giua];
        if a[j] < a[i] then dau:=giua
             else cuoi:=giua;
      until dau+1=cuoi;
      findd:=startof[dau];
END;
{*      *       *       *       *}
Procedure Solved;
Var i,j : longint;
BEGIN
     For i:=n downto 0 do
       BEGIN
           j:=findd(i);
           k:=l[j]+1;
           if k>m then
             BEGIN
                 m:=k;
                 startof[k]:=i;
             END
               else if a[i] < a[startof[k]] then
                     startof[k]:=i;
               l[i]:=k;

       END;
END;
{*      *       *       *       *}
Procedure Initu;
BEGIN
    fillchar(lu,sizeof(lu),0);
    fillchar(startofu,sizeof(startofu),0);
    a[0]:=-maxint;
    a[n+1]:=maxint;
    lu[0]:=1;
    startofu[1]:=0;
    m:=1;
END;
{*      *       *       *       *}
Function Findu(i : longint) : longint;
Var dau,cuoi,giua,j : longint;
BEGIN
    dau:=1;cuoi:=m+1;
    repeat
        giua:=(dau+cuoi) div 2;
        j:=startofu[giua];
        if a[j] < a[i] then dau:=giua
             else cuoi:=giua;
      until dau+1=cuoi;
      findu:=startofu[dau];
END;
{*      *       *       *       *}
Procedure Solveu;
Var i,j : longint;
BEGIN
     For i:=1 to n+1 do
       BEGIN
           j:=findu(i);
           k:=lu[j]+1;
           if k>m then
             BEGIN
                 m:=k;
                 startofu[k]:=i;
             END
               else if a[i] < a[startofu[k]] then
                     startofu[k]:=i;
               lu[i]:=k;

       END;
END;
{*      *       *       *       *}
procedure output;
Var i : longint;
BEGIN
    assign(fo,out);rewrite(fo);
    For i:=1 to n do
      BEGIN
          Dec(lu[i]);
          Dec(l[i]);
      END;
    max:=1;
    For i:=1 to n do
      if max<l[i]+lu[i]-1 then max:=l[i]+lu[i]-1;
    if max mod 2 = 0 then max:=max-1;
    write(fo,max);
    close(fo);
END;
{*      *       *       *       *}
BEGIN
   input;
   initu;
   solveu;
   initd;
   solved;
   output;
END.

