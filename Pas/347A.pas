Const   maxn = 100;
Var     a       :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        d,c,i,n,min,max,j,t     :       longint;

begin
    // assign(input,'asd.inp'); reset(input);
   //  assign(output,'asd.out'); rewrite(output);
     readln(n);
     min := maxlongint;
     max := -maxlongint;
     for i := 1 to n do
      begin
        read(a[i]);
        if a[i] < min then
          begin
              c := i; min := a[i];
          end;
        if a[i] > max then
          begin
              d := i; max := a[i];
          end;
      end;
    write(a[d],' ');
    fillchar(free,sizeof(free),true);
    free[d] := false; free[c] := false;
    for i := 1 to n-2 do
     begin
         min := maxlongint;
         for j := 1 to n do
         if free[j] and (a[j] < min) then
           begin
              t := j;
              min := a[j];
           end;
         free[t] := false;
         write(a[t],' ');
     end;
    write(a[c]);
end.
