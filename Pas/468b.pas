Uses math;
Const
    inp = '';
    out = '';
    maxn = 100001;

Var
    n,x,y,i,j,top,k,x1,x2,u : longint;
    a,st,sl : array [1..maxn] of longint;
    ok : boolean;

procedure swap(var xx,yy : longint);
    var temp : longint;
begin
    temp := xx; xx := yy; yy := temp;
end;

begin
    assign(input,inp) ;reset(input);
    assign(output,out); rewrite(output);
    readln(n,x,y);
    if n=1 then
      begin
          write('NO');
          halt;
      end;
    for i := 1 to n do read(a[i]);
    top:= 0;
    for i := 1 to n do
     begin
         u := 0;
         for j := 1 to top do
          if a[i]=st[j] then u:= j;
         if u=0then
           begin
               inc(top); st[top] := a[i];
               sl[top] := 1;
           end
         else inc(sl[u]);
         if top > 4 then
          begin
              writeln('NO');
              halt;
          end;
     end;
    if top=1 then
      begin
          if (x-st[1]=st[1]) and (y-st[1]=st[1]) then
            begin
                writeln('YES');
                for i := 1 to n do write(i mod 2,' ');
                halt;
            end;
          writeln('NO');
      end;
    if top=2 then
      begin
          if (x=y) and (sl[1]>0) and (sl[2]>0) then
            begin
                writeln('YES');
                for i := 1 to n do
                 if a[i]=st[1] then
                   begin
                       if sl[1]=1 then write(1,' ')
                        else write(0,' ');
                       dec(sl[1]);
                   end
                 else begin
                     if sl[2]=1 then write(1,' ')
                      else write(0,' ');
                      dec(sl[2]);
                 end;
                halt;
            end;
          if (x-st[1]=st[1]) and (y-st[2]=st[2]) then
            begin
                writeln('YES');
                for i := 1 to n do
                 if a[i]=st[1] then write(0,' ') else write(1,' ');
                halt;
            end;
          if (x-st[2]=st[2]) and (y-st[1]=st[1]) then
            begin
                writeln('YES');
                for i := 1 to n do
                 if a[i]=st[2] then write(0,' ') else write(1,' ');
                halt;
            end;
          if (st[1]+st[2]=x) and (st[1]*2=y) and (sl[1]>1) then
            begin
               writeln('YES');
               for i := 1 to n do
                if (a[i]=st[1]) then
                  begin
                      if sl[1]=1 then write(1,' ')
                       else write(0,' ');
                      dec(sl[1]);
                  end
                else write(0,' ');
                halt;
            end;
          if (st[1]+st[2]=x) and (st[2]*2=y) and (sl[2]>1) then
            begin
               writeln('YES');
               for i := 1 to n do
                if (a[i]=st[2]) then
                  begin
                      if sl[2]=1 then write(1,' ')
                       else write(0,' ');
                      dec(sl[2]);
                  end
                else write(0,' ');
                halt;
            end;
          swap(x,y);
          if (st[1]+st[2]=x) and (st[1]*2=y) and (sl[1]>1) then
            begin
               writeln('YES');
               for i := 1 to n do
                if (a[i]=st[1]) then
                  begin
                      if sl[1]=1 then write(0,' ')
                       else write(1,' ');
                      dec(sl[1]);
                  end
                else write(1,' ');
                halt;
            end;
          if (st[1]+st[2]=x) and (st[2]*2=y) and (sl[2]>1) then
            begin
               writeln('YES');
               for i := 1 to n do
                if (a[i]=st[2]) then
                  begin
                      if sl[2]=1 then write(0,' ')
                       else write(1,' ');
                      dec(sl[2]);
                  end
                else write(1,' ');
                halt;
            end;
          writeln('NO');
      end;
    if top=3 then
      begin
          for i := 1 to 3 do
           for j := i+1 to 3 do
             begin
                 x1 := 0; x2 := 0;
                 for k := 1 to 3 do
                  if (k=i) or (k=j) then inc(x1,st[k])
                   else inc(x2,st[k]);
                 if (x=x1) and (y-x2=x2) then
                   begin
                     writeln('YES');
                     for k := 1 to n do
                     if (a[k]=st[i]) or (a[k]=st[j]) then write(0,' ') else write(1,' ');
                    halt;
                   end;
                 if (x-x2=x2) and (y=x1) then
                  begin
                      writeln('YES');
                      for k := 1 to n do
                       if (a[k]=st[i]) or (a[k]=st[j]) then write(1,' ') else write(0,' ');
                      halt;
                  end
                 else if (x=x1) and (x2+st[i]=y) and (sl[i]>1)then
                   begin
                      writeln('YES');
                      for k := 1 to n do
                       if (a[k]=st[i]) then
                         begin
                             if sl[i]=1 then write(1,' ')
                              else write(0,' ');
                             dec(sl[i]);
                         end
                       else if (a[k]=st[j]) then write(0,' ')
                        else write(1,' ');
                      halt;
                   end
                 else if (x=x1) and (x2+st[j]=y) and (sl[j]>1) then
                   begin
                      writeln('YES');
                      for k := 1 to n do
                       if (a[k]=st[j]) then
                         begin
                             if sl[j]=1 then write(1,' ')
                              else write(0,' ');
                             dec(sl[j]);
                         end
                       else if (a[k]=st[i]) then write(0,' ')
                        else write(1,' ');
                      halt;
                   end
                 else if (y=x1) and (x2+st[i]=x) and (sl[i]>1) then
                   begin
                      writeln('YES');
                      for k := 1 to n do
                       if (a[k]=st[i]) then
                         begin
                             if sl[i]=1 then write(0,' ')
                              else write(1,' ');
                             dec(sl[i]);
                         end
                       else if (a[k]=st[j]) then write(1,' ')
                        else write(0,' ');
                      halt;
                   end
                 else if (y=x1) and (x2+st[j]=x) and (sl[j]>1) then
                   begin
                      writeln('YES');
                      for k := 1 to n do
                       if (a[k]=st[j]) then
                         begin
                             if sl[j]=1 then write(0,' ')
                              else write(1,' ');
                             dec(sl[j]);
                         end
                       else if (a[k]=st[i]) then write(1,' ')
                        else write(0,' ');
                      halt;
                   end;
             end;
           write('NO');
      end;
    if top=4 then
      begin
          for i := 1 to 4 do
           for j := i+1 to 4 do
             begin
                x1 := 0; x2 := 0;
                for k := 1 to 4 do
                 if (k=i) or (k=j) then inc(x1,st[k])
                  else inc(x2,st[k]);
                if ((x1=x) and (x2=y))  then
                  begin
                      writeln('YES');
                      for k := 1 to n do
                       if (a[k]=st[i]) or (a[k]=st[j]) then write(0,' ') else write(1,' ');
                      halt;
                  end
                else if (x1=y) and (x2=x) then
                  begin
                      writeln('YES');
                      for k := 1 to n do
                       if (a[k]=st[i]) or (a[k]=st[j]) then write(1,' ') else write(0,' ');
                      halt;
                  end;
             end;
           writeln('NO');
      end;
end.