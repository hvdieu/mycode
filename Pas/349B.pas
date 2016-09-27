uses math;
Var     v,m,scs,thua,vt,i,j       :       longint;
        a       :       array [1..9] of longint;
        kq      :       array [1..1000000] of integer;

begin
   //  assign(input,'fence.inp'); reset(input);
   //  assign(output,'fence.out'); rewrite(output);
     readln(v);
     m := maxlongint;
     for i := 1 to 9 do
       begin
         read(a[i]);
         if a[i] <= m then
          begin
              m := a[i]; vt := i;
          end;
       end;
     if v < m then write(-1)
      else
       begin
           scs := v div m;
           thua := v - m*scs;
           for i := 1 to scs do kq[i] := vt;
           if thua > 0 then
             begin
                 for i := 1 to scs do
                  for j := 9 downto vt+1 do
                   begin
                       if a[j] <= thua+m then
                        begin
                            thua := thua+m - a[j];
                            kq[i] := j;
                            break;
                        end;
                   end;
             end;
           for i := 1 to scs do write(kq[i]);
       end;
end.