Const   maxn = 110;
Var     a,r       :       array [1..2*maxn] of integer;
        d       :       array [1..2*maxn] of boolean;
        free    :       array [0..9999] of boolean;
        dem     :       array [10..99] of longint;
        n,i,j,last,res,d1,d2       :       integer;

begin
   //  assign(input,'asd.inp'); reset(input);
   //  assign(output,'asd.out'); rewrite(output);
     readln(n);
     for i := 1 to 2*n do
       begin
         read(a[i]);
         inc(dem[a[i]]);
       end;
     fillchar(d,sizeof(d),true);
     for i := 1 to 2*n do
       if d[i] and (dem[a[i]] = 1) then
         begin
             d[i] := false;
             if d1 <= d2 then
               begin
                   r[i] := 1; last := 1;
                   inc(d1);
               end
             else
               begin
                   r[i] := 2; last := 2;
                   inc(d2);
               end;
             for j := 1 to 2*n do
              if d[j] and (a[i] = a[j]) then
                begin
                    d[j] := false;
                    if d1 <= d2 then
                       begin
                           r[j] := 1;
                           inc(d1);
                       end
                    else begin
                             r[j] := 2;
                             inc(d2);
                         end;
                end;
         end;

     for i := 1 to 2*n do
       if d[i]  then
         begin
             d[i] := false;
             if d1 <= d2 then
               begin
                   r[i] := 1; last := 1;
                   inc(d1);
               end
             else
               begin
                   r[i] := 2; last := 2;
                   inc(d2);
               end;
             for j := 1 to 2*n do
              if d[j] and (a[i] = a[j]) then
                begin
                    d[j] := false;
                    if d1 <= d2 then
                       begin
                           r[j] := 1;
                           inc(d1);
                       end
                    else begin
                             r[j] := 2;
                             inc(d2);
                         end;
                end;
         end;
     for i := 1 to 2*n do
      for j := 1 to 2*n do
       if (r[i] = 1) and (r[j] = 2) then free[a[i]*100+a[j]] := true;
     for i := 1000 to 9999 do if free[i] then inc(res);
     writeln(res);
     for i := 1 to 2*n do write(r[i],' ');

end.
