{$MODE OBJFPC}
Const     inp = '';
          out = '';
          maxn = 100010;
Var       fi,fo         :       text;
          a             :       array [0..maxn+1] of longint;
          l,startof     :       array [0..maxn+1] of longint;
          n,m,k     :       integer;
{*        *     *       *         *}
Procedure Input;
Var i : longint;
BEGIN
      assign(fi,inp);reset(fi);
      readln(fi,n);
      for i:=1 to n do readln(fi,a[i]);
      close(fi);
END;
{*      *       *       *       *}
Procedure Init;
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
Function Find(i : longint) : longint;
Var dau,cuoi,giua,j : longint;
BEGIN
    dau:=1;cuoi:=m+1;
    repeat
        giua:=(dau+cuoi) div 2;
        j:=startof[giua];
        if a[j] < a[i] then dau:=giua
             else cuoi:=giua;
      until dau+1=cuoi;
      find:=startof[dau];
END;
{*      *       *       *       *}
Procedure Solve;
Var i,j : longint;
BEGIN
     For i:=n downto 0 do
       BEGIN
           j:=find(i);
           k:=l[j]+1;
           if k>m then
             BEGIN
                 m:=k;
                 startof[k]:=i;
             END
               else if a[i]< a[startof[k]] then
                     startof[k]:=i;
               l[i]:=k;

       END;
END;
{*      *       *       *       *}
procedure output;
BEGIN
    assign(fo,out);rewrite(fo);
    write(fo,m-2);
    close(fo);
END;
{*      *       *       *       *}
BEGIN
   input;
   init;
   solve;
   output;
END.

