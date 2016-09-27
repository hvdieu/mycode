{$H+}
Const   maxn = 300001;
Var     n,m,i,j,top,k,right,dem     :       longint;
        st1,st2 :       array [1..maxn] of char;
        a,t     :       string;
        ok      :       boolean;

begin
     assign(input,'LETTER.INP'); reset(input);
     assign(output,'LETTER.OUT'); rewrite(output);
     readln(a); readln(t);
     m := length(a); n := length(t);
     i := 0; j := n+1;

     repeat

         repeat
            if i+1 = j then break;
            inc(i); inc(top); st1[top] := t[i];
            if top >= m then
              begin

                  ok := true; dem := 0;
                  for k := top-m+1 to top do
                   begin
                       inc(dem);
                       if a[dem] <> st1[k] then
                         begin
                             ok := false;
                             break;
                         end;
                   end;
                 if ok then
                   begin
                      top := top-m;
                      break;
                   end;
              end;
         until false;

        repeat
            if j = i+1 then break;
            dec(j); inc(right); st2[right] := t[j];
            if right >= m then
              begin
                  ok := true; dem := 0;
                  for k := right downto right-m+1 do
                    begin
                        inc(dem);
                        if a[dem] <> st2[k] then
                          begin
                              ok := false; break;
                          end;
                    end;
                  if ok then
                    begin
                        right := right-m;
                        break;
                    end;
              end;
        until false;
     if i+1 = j then break;

     until false;

     while right > 0 do
       begin
           inc(top); st1[top] := st2[right];
           dec(right); ok := true; dem := 0;
           if top >= m then
           begin
           for k := top-m+1 to top do
             begin
                inc(dem);
                if a[dem] <> st1[k] then
                  begin
                      ok := false; break;
                  end;
             end;
           if ok then top := top-m;
           end;
       end;
     for k := 1 to top do write(st1[k]);
end.