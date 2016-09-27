Const   maxn = 500001;
Var     n,i,res,top       :       longint;
        st,a,dem    :       array [0..maxn] of longint;

begin
      assign(input,'PAIRVIS.INP'); reset(input);
      assign(output,'PAIRVIS.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do read(a[i]);
      st[1] := 1; top := 1;
      dem[1] := 1;
      st[0] := 1;
      for i := 2 to n do
        begin
            if a[i] = a[st[top]] then
              begin
                  res := res + dem[top];
                  if top <> 1 then inc(res);
                  inc(dem[top]);
              end
            else if a[i] < a[st[top]] then
              begin
                  inc(res);
                  inc(top);
                  st[top] := i; dem[top] := 1;
              end
            else if a[i] > a[st[top]] then
              begin
                  while (top > 0) and (a[i] > a[st[top]]) do
                   begin
                       res := res + dem[top];
                       dec(top);
                   end;
                  if a[i] = a[st[top]] then
                   begin
                     res := res + dem[top];
                     inc(dem[top]);
                     if top > 1 then inc(res);
                   end
                   else begin
                            if top >= 1 then inc(res);
                            inc(top);
                            st[top] := i; dem[top] := 1;
                        end;
              end;
        end;
      write(res);
end.