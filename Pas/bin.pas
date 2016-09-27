Const   maxn = 51;

Var     n,i,j,res,u,temp   :       longint;
        a       :       array [1..maxn] of longint;
        dd      :       array [1..maxn] of boolean;

{**************************************************************************}
begin
    assign(input,'bin.inp'); reset(input);
    assign(output,'bin.out'); rewrite(output);
    readln(n);
    for i := 1 to n do read(a[i]);
    fillchar(dd,sizeof(dd),true);
    for i := 1 to n do
      if dd[i] then
        begin
            dd[i] := false;
            temp := 0; u := 0;
            for j := 1 to n do
             if dd[j] and (a[j] > temp) and (a[j]+a[i] <= 300) then
              begin
                  u := j;
                  temp := a[j];
              end;
             inc(res);
             if u <> 0 then dd[u] := false;
        end;
    writeln(res);
end.