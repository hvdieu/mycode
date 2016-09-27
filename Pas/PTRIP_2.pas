Uses math;
Var     mina,maxa,minb,maxb,minc,maxc,i,j,b,d,c,mid,u,v   :  longint;
        res : int64;

begin
      assign(input,'PTRIP.IN'); reset(input);
      assign(output,'PTRIP.OUT'); rewrite(output);
      readln(mina,maxa,minb,maxb,minc,maxc);
      mid := min( trunc(sqrt(maxc)),maxa);
      d := -1; c:= -1;
      if mid <> maxa then
        begin
            d := mid+1;
            c := maxa;
        end;
      for i := mina to mid do
        begin
             u := trunc(minc/i); if minc mod i <> 0 then inc(u);
             v := trunc(maxc/i);

             if u > v then continue else
             if (u < minb) and (v > maxb) then inc(res,maxb-minb+1)
              else if (u >= minb) and (v <= maxb) then inc(res,v-u+1)
               else if (u < minb) and (v >= minb) and (v <= maxb) then inc(res,v-minb+1)
                else if (u >= minb) and (u <= maxb) and ( v > maxb) then inc(res,maxb-u+1);
        end;
     if (d <> -1) and (c <> -1) then
     begin
        mid := min( trunc(sqrt(maxc)),maxb);
        for b := minb to mid do
          begin
               u := trunc(minc/b); if minc mod b <> 0 then inc(u);
               v := trunc(maxc/b);
               if u > v then continue else
               if (u < d) and (v > c) then inc(res,c-d+1)
              else if (u >= d) and (v <= c) then inc(res,v-u+1)
               else if (u < d) and (v >= c) and (v <= c) then inc(res,v-d+1)
                else if (u >= d) and (u <= c) and (v > c) then inc(res,c-u+1);

          end;
     end;
     writeln(res);
end.