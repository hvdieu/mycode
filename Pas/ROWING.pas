Uses math;
Const   maxn = 4010;
        maxm = 8040051;

Var     n,h,i,c     :       longint;
        x,y     :       array [1..maxn] of int64;
        free       :    array [0..maxn] of boolean;
        d       :  array [0..maxn] of extended;

{************************************************************************}
Function tinh(i,j : longint) : extended;
Begin
      if (i = 0) and (j = n+1) then exit(1 shl 50);
      if (i = 0) then exit(h-y[j]);
      if (j = n+1) then exit(y[i]);
      exit(sqrt(sqr(x[i]-x[j])+sqr(y[i]-y[j])));
End;
{************************************************************************}
Procedure main;
Var i,j,u,v : longint;
    kc,temp : extended;

Begin
      fillchar(free,sizeof(free),true);
      for i := 1 to n+1 do d[i] := 1 shl 50;
      d[0] := 0;
      repeat
          temp := 1 shl 50;
          u := -1;
          for i := 0 to n+1 do
           if free[i] and (d[i] < temp) then
             begin
                 temp := d[i];
                 u := i;
             end;
          if (u = -1) or (u = n+1) then break;
          free[u] := false;
          for v := 1 to n+1 do
           if free[v] then
            begin
                kc := tinh(u,v);
                if d[v] > max(d[u],kc) then d[v] := max(d[u],kc);
            end;
      until false;
      write(trunc(d[n+1]));
End;
{************************************************************************}
Begin
      assign(input,'ROWING.INP'); reset(input);
      assign(output,'ROWING.OUT'); rewrite(output);
      readln(n,h);
      for i := 1 to n do read(x[i],y[i]);
      main;
End.