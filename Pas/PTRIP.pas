
Var     mina,maxa,minb,maxb,minc,maxc,d,c,vt,a : longint;
        i,j,u,v     :       longint;
        res     :       int64;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

begin
      assign(input,'PTRIP.IN'); reset(input);
      assign(output,'PTRIP.OUT'); rewrite(output);
      readln(mina,maxa,minb,maxb,minc,maxc);
      if maxb - minb + 1 < maxa-mina+1 then
        begin
            swap(mina,minb);
            swap(maxa,maxb);
        end;
      for a := mina to maxa do
        begin
            u := minc div a; v := maxc div a;
            if minc mod a <> 0 then inc(u);
            if (u >= minb) and (v <= maxb) then res := res + v-u+1
             else if (u <= minb) and (v >= maxb) then res := res + maxb-minb+1
              else if (u <= minb) and (v > minb) and (v <= maxb) then
               res := res + v-minb+1
              else if (u >= minb) and (u <= minb) and (v >= maxb) then
               res := res + maxb-u+1;
        end;
      writeln(res);
end.
