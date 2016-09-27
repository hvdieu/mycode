Uses math;
Const   maxn = 50001;
Type    canh = record
        hang,cot : longint;
        end;
Var     a,b,head,mau     :       array [1..maxn] of longint;
        next,ke,w :    array [-maxn..maxn] of longint;
        pos     :       array [1..2,1..100001] of canh;
        free    :      array [1..maxn] of boolean;
        n,i,res,sl,c,dem     :       longint;

procedure add(x,y,ts : longint);
        begin
            inc(c);
            ke[c] := y; ke[-c] := x;
            w[c] := ts; w[-c] := ts;
            next[c] := head[x]; next[-c] := head[y];
            head[x] := c; head[y] := -c;
        end;

procedure khoitao;
var i,j : longint;
        begin
            c := 0;
            for i := 1 to n do
              begin
                 if pos[1,a[i]].hang = 0 then
                   begin
                     pos[1,a[i]].hang := 1;
                     pos[1,a[i]].cot := i;
                   end
                  else
                   begin
                     pos[2,a[i]].hang := 1;
                     pos[2,a[i]].cot := i;
                   end;
                 if pos[1,b[i]].hang = 0 then
                   begin
                     pos[1,b[i]].hang := 2;
                     pos[1,b[i]].cot := i;
                   end
                  else
                   begin
                     pos[2,b[i]].hang := 2;
                     pos[2,b[i]].cot := i;
                   end;
              end;
            for i := 1 to n do
            begin
              if (pos[1,a[i]].hang <> 0) and (pos[2,a[i]].hang <> 0) then
                begin
                    if pos[1,a[i]].hang <> pos[2,a[i]].hang then
                     add(pos[1,a[i]].cot,pos[2,a[i]].cot,0)
                    else add(pos[1,a[i]].cot,pos[2,a[i]].cot,1);
                    pos[1,a[i]].hang := 0; pos[2,a[i]].hang := 0;
                end;
              if (pos[1,b[i]].hang <> 0) and (pos[2,b[i]].hang <> 0) then
                begin
                    if pos[1,b[i]].hang <> pos[2,b[i]].hang then
                     add(pos[1,b[i]].cot,pos[2,b[i]].cot,0)
                      else add(pos[1,b[i]].cot,pos[2,b[i]].cot,1);
                    pos[1,b[i]].hang := 0; pos[2,b[i]].hang := 0;
                end;
            end;
            fillchar(free,sizeof(free),true);
        end;

procedure dfs(u : longint);
var j,v : longint;
        begin
            free[u] := false; inc(sl);
            j := head[u];

            while j <> 0 do
              begin
                  v := ke[j];
                  if free[v] then
                   begin
                       if w[j] = 1 then
                        begin
                            if 1-mau[u] <> 0 then
                              begin
                                 inc(dem);
                                 mau[v] := 1 - mau[u];
                              end;
                        end
                       else begin
                                if mau[v] <> mau[u] then
                                  begin
                                      inc(dem);
                                      mau[v] := mau[u];
                                  end;
                            end;
                       dfs(v);
                   end;
                  j := next[j];
              end;
        end;

begin
      assign(input,'double.inp'); reset(input);
      assign(output,'double.out'); rewrite(output);
      readln(n);
      for i := 1 to n do read(a[i]);
      for i := 1 to n do read(b[i]);
      khoitao;
      for i := 1 to n do
        if free[i] then
          begin
              dem := 1; sl := 0;
              mau[i] := 1;
              dfs(i);
              res := res + min(dem,sl-dem);
          end;
      write(res);
end.