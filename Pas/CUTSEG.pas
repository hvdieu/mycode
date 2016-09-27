USES math;
CONST
        tfi     ='';//'cutseg.inp';
        tfo     ='';//'cutseg.out';
        nmax    =200;
        oo      =1000000;
TYPE
        arr     =array [1..nmax,1..nmax,0..nmax] of longint;
        arr1    =array [0..nmax,'0'..'9'] of longint;
VAR
        fi,fo   :text;
        f       :arr;
        n       :longint;
        s       :string;
        sl      :arr1;
 (*********************************************************************)
Procedure nhap;
      Var
        i       :longint;
        c       :char;
      Begin
        assign(fi,tfi);reset(fi);
          readln(fi,n);
          readln(fi,s);
          for i:=1 to n do
            begin
              for c:='0' to '9' do sl[i,c]:=sl[i-1,c];
              inc(sl[i,s[i]]);
            end;
        close(fi);
      End;
 (*********************************************************************)
Procedure lam;
      Var
        i,l,j,t,k:longint;
      Begin
        for i:=1 to n do
          for j:=i to n do
            for t:=0 to n do f[i,j,t]:=-oo;
        for i:=1 to n do
          begin
            f[i,i,0]:=1;
            f[i,i,1]:=0;
          end;
        for i:=1 to n-1 do
          begin
            if s[i]=s[i+1] then
              begin
                f[i,i+1,0]:=4;
                f[i,i+1,2]:=0;
              end
            else f[i,i+1,0]:=2;
            f[i,i+1,1]:=1;
          end;
        for l:=3 to n do
          for i:=1 to n-l+1 do
            begin
              j:=i+l-1;
              for t:=i to j-1 do f[i,j,0]:=max(f[i,j,0],f[i,t,0]+f[t+1,j,0]);
              for t:=1 to sl[j,s[i]]-sl[i-1,s[i]] do
                begin
                  if s[i]=s[j] then f[i,j,t]:=max(f[i,j,t],f[i,j-1,t-1]);
                  for k:=i to j-1 do
                    if s[k]=s[i] then
                      f[i,j,t]:=max(f[i,j,t],f[i,k,t]+f[k+1,j,0]);
                  f[i,j,0]:=max(f[i,j,0],f[i,j,t]+t*t);
                end;
            end;
      End;
 (**********************************************************************)
Procedure inkq;
      Begin
        assign(fo,tfo);rewrite(fo);
          writeln(fo,f[1,n,0]);
        close(fo);
      End;
 (***********************************************************************)
BEGIN
        nhap;
        lam;
        inkq;
END.


