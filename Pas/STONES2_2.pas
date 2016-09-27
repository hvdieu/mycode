Const   maxn = 16;
Var     n,i,k,top,m,res     :       longint;
        a,b,st,l,startof,x     :       array [0..maxn] of longint;
        free    :       array [1..16] of boolean;

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

procedure sub1;
var i,j,dem : longint;
    ok : boolean;
        begin
          for i := 1 to n do
            begin
              read(a[i]);
              ok := true;
              for j := 1 to i-1 do
               if a[i] = a[j] then ok := false;
              if ok then inc(k);
            end;
          fillchar(free,sizeof(free),true);
          for i := 1 to n do
            begin
                 ok := true;
                 for j := 1 to top do
                  if st[j] = a[i] then ok := false;
                 if ok then
                   begin
                       inc(top); b[i] := top;
                       st[top] := a[i];
                   end
                 else for j := 1 to top do
                  if st[j] = a[i] then b[i] := j;
            end;
           for i := 1 to n do a[i] := b[i];
           res := maxlongint;
           ql(1);
           writeln(res);
        end;

begin
     assign(input,'stones2.inp'); reset(input);
     assign(output,'stones2.out'); rewrite(output);
     readln(n);
     if n <= 16 then sub1;
end.