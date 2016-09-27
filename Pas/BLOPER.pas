Uses math;
Const   inp = 'BLOPER.INP';
        out = 'BLOPER.OUT';

Var     n,s,t,sum,i : longint;
        dd : array [1..501] of boolean;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    read(n,t);
    s := ((1+n)*n) div 2;
    if (t > s) or (t<-s+2) then write('Impossible')
     else
      begin
          if (s-t) mod 2=1 then write('Impossible')
           else
            begin
                t := (s-t) div 2;
                for i := n downto 2 do
                 if t >= i then
                   begin
                       dd[i] := true;
                       t := t-i;
                   end;
                if t > 0 then write('Impossible')
                 else
                  begin
                      write(1);
                      for i := 2 to n do
                      begin
                       if dd[i] then write('-') else write('+');
                       write(i);
                      end;
                  end;
            end;
      end;
end.