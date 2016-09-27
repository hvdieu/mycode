Const   maxn = 100001;
Var     n,i,x       :       longint;
        dem     :       array [25..100] of longint;
        ok      :       boolean;

begin
    // assign(input,'cinema.inp'); reset(input);
    // assign(output,'cinema.out'); rewrite(output);
     readln(n);
     ok := true;
     for i := 1 to n do
      begin
          read(x);
          if x = 25 then inc(dem[x]);
          if x = 50 then
            begin
                if dem[25] = 0 then
                 begin
                    ok := false;
                    break;
                 end
                else
                 begin
                     inc(dem[50]); dec(dem[25]);
                 end;
            end;
          if x = 100 then
            begin
                if (dem[25] = 0) or ((dem[50]=0) and (dem[25] < 3)) then
                  begin
                      ok := false;
                      break;
                  end;
                if (dem[50] > 0) then
                  begin
                      inc(dem[100]);
                      dec(dem[25]);
                      dec(dem[50]);
                  end
                else dec(dem[25],3);
            end;
      end;
     if ok then write('YES')
      else write('NO');
end.

