Const   maxn = 111;
Var     n,k,res,i,m     :       longint;
        a,startof,l,b       :       array [0..maxn] of longint;
        x     :       array [1..5] of longint;
        free    :       array [1..5] of boolean;


Function Find(i : longint) : longint;
Var dau,cuoi,giua,j : longint;
BEGIN
    dau:=1;cuoi:=m+1;
    repeat
        giua:=(dau+cuoi) div 2;
        j:=startof[giua];
        if b[j] >= b[i] then dau:=giua
             else cuoi:=giua;
      until dau+1=cuoi;
      find:=startof[dau];
END;


procedure xuly;
var i,j,count,kk : longint;
        begin
            fillchar(l,sizeof(l),0);
            fillchar(startof,sizeof(startof),0);
            b[0]:=-maxlongint;
            b[n+1]:=maxlongint;
            l[n+1]:=1;
            startof[1]:=n+1;
            m:=1;

            For i := 1 to n do b[i] := 1000*x[a[i]];
            For i:=n downto 0 do
                BEGIN
                  j:=find(i);
                  kk:=l[j]+1;
                   if kk>m then
                    BEGIN
                      m:=kk;
                      startof[kk]:=i;
                    END
                     else if b[i] > b[startof[kk]] then
                     startof[kk]:=i;
                     l[i]:=kk;
                END;
            if n-m+2 < res then res := n-m+2;
        end;

procedure ql(i : longint);
var j : longint;
        begin
             if i > k then xuly
              else
                begin
                    for j := 1 to k do
                     if free[j] then
                       begin
                          x[i] := j;
                          free[j] := false;
                          ql(i+1);
                          free[j] := true;
                       end;
                end;
        end;

procedure main;
var i,j : longint;
        begin
             fillchar(free,sizeof(free),true);
             res := maxlongint;
             ql(1);
             writeln(res);
        end;

begin
      assign(input,'STONES.INP'); reset(input);
      assign(output,'STONES.OUT'); rewrite(output);
      while not eof(input) do
        begin
            readln(n,k);
            if (n <> 0) and (k <> 0) then
              begin
                  for i := 1 to n do read(a[i]);
                  main;
              end;
        end;
end.
