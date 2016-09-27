Const   maxn = 101;
        maxw = 99999999;
Var     n,i,j,k       :       integer;
        a       :       array [1..maxn,1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        res,u,v,t,vt,x     :       longint;

begin
    //  assign(input,'TTRIP.INP'); reset(input);
    //  assign(output,'TTRIP.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do
       for j := 1 to n do
         if i = j then a[i,j] := 0
          else a[i,j] := maxw;
      for i := 1 to n do
        for j := 1 to n do
         begin
             read(x);
             if x > 0 then a[i,j] := x;
         end;

      for k := 1 to n do
       for i := 1 to n do
         for j := 1 to n do
          if a[i,j] > a[i,k] + a[k,j] then a[i,j] := a[i,k] + a[k,j];

      fillchar(free,sizeof(free),true);
      u := 1;
      while u <> n do
        begin
            free[u] := false;
            t := maxw;
            vt := 0;
            for i := 1 to n do
              if (i <> u) and (free[i]) and (a[u,i] < t) then
                begin
                    vt := i;
                    t := a[u,i];
                end;
            t := maxw;
            if vt = n then
              for i := 1 to n-1 do
               if (i <> u) and (free[i]) and (a[u,i] < t) then
                 begin
                     vt := i;
                     t := a[u,i];
                 end;
            res := res + a[u,vt];
            u := vt;
        end;
      write(res);
end.

