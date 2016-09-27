{$h+}
USES math;
CONST
  tfi ='vobrack.inp';
  tfo ='vobrack.ou1';
  nmax  =1000;
TYPE
  arr =array [1..nmax] of longint;
  arr1  =array [0..10*nmax] of longint;
VAR
  fi,fo :text;
  n,res,top:longint;
  a,b,c,s:arr;
  f,g :arr1;
 (*******************************************************************)
Procedure nhap;
  Var
    i,j,u,v:longint;
    s :string;
  Begin
    assign(fi,tfi);reset(fi);
      readln(fi,n);
      for i:=1 to n do
        begin
          readln(fi,s);
          u:=0;
          v:=maxlongint;
          for j:=1 to length(s) do
            begin
              if s[j]='(' then inc(u) else dec(u);
              v:=min(v,u);
            end;
          a[i]:=v;b[i]:=u;c[i]:=length(s);
        end;
    close(fi);
  End;
 (******************************************************************)
Procedure doicho(var x,y:longint);
  Var
    tg  :longint;
  Begin
    tg:=x;
    x:=y;
    y:=tg;
  End;
 (******************************************************************)
Procedure lam;
  Var
    i,j :longint;
  Begin
    for i:=1 to 10000 do f[i]:=-maxlongint;
    top:=0;
    for i:=1 to n do
      if (b[i]>=0) then
        begin
          inc(top);
          s[top]:=i;
        end;
    for i:=1 to top do
      for j:=i+1 to top do
        if (a[s[j]]>a[s[i]]) or ((a[s[j]]=a[s[i]]) and (b[s[j]]>b[s[i]])) then doicho(s[i],s[j]);
    for i:=1 to top do
      begin
        g:=f;
        for j:=max(-a[s[i]],0) to min(10000,10000-b[s[i]]) do
          f[j+b[s[i]]]:=max(f[j+b[s[i]]],g[j]+c[s[i]]);
      end;
    top:=0;
    for i:=1 to n do
      if (b[i]<0)  then
        begin
          inc(top);
          s[top]:=i;
        end;
    for i:=1 to top do
      for j:=i+1 to top do
        if (a[s[j]]<a[s[i]]) or ((a[s[j]]=a[s[i]]) and (b[s[j]]>b[s[i]])) then doicho(s[i],s[j]);
    for i:=1 to top do
      begin
        g:=f;
        for j:=max(-a[s[i]],0) to 10000 do
          f[j+b[s[i]]]:=max(f[j+b[s[i]]],g[j]+c[s[i]]);
      end;
    write(fo,f[0]);
  end;
 (******************************************************************)
BEGIN
  assign(fo,tfo);rewrite(fo);
    nhap;
    lam;
  close(fo);
END.

