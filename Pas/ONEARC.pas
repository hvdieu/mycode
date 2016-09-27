Uses math;
Const   maxn = 2001;
        maxm = 30001;
Type    canh = record
        x,y     :       longint;
        end;
Var     n,m,i,u,v,dem,top,count,dra,dvao,s,t     :       longint;
        e       :       array [1..maxm] of canh;
        head,num,low,st,lab,ra,vao    :       array [1..maxn] of longint;
        free    :   array [1..maxn] of boolean;
        ke,next :       array [1..maxm] of longint;

procedure dfs(u : longint);
var j,v : longint;
        begin
             inc(dem); num[u] := dem; low[u] := dem;
             inc(top); st[top] := u;
             j := head[u];
             while j <> 0 do
               begin
                   v := ke[j];
                   if free[v] and (num[v] = 0) then
                     begin
                         dfs(v);
                         low[u] := min(low[u],low[v]);
                     end
                   else if free[v] and (num[v] <> 0) then
                     low[u] := min(low[u],num[v]);
                   j := next[j];
               end;

             if low[u] = num[u] then
               begin
                   inc(count);
                   repeat
                      v := st[top]; dec(top);
                      free[v] := false; lab[v] := count;
                   until v = u;
               end;
        end;

procedure main;
var i,j,i1,j1 : longint;
        begin
            fillchar(free,sizeof(free),true);
            dfs(1);
            for i := 1 to m do with e[i] do
              begin
                  if lab[x] <> lab[y] then
                    begin
                        inc(ra[lab[x]]); inc(vao[lab[y]]);
                    end;
              end;
            for i := 1 to count do
              begin
                  if ra[i] = 0 then
                    begin
                        inc(dra); s := i;
                    end;
                  if vao[i] = 0 then
                    begin
                        inc(dvao); t := i;

                    end;
              end;
            if (dra = 1) and (dvao = 1) then
              begin
                  for i := 1 to n do
                   begin
                    if lab[i] = s then i1 := i;
                    if lab[i] = t then j1 := i;
                   end;
                  writeln('YES');
                  writeln(i1,' ',j1);
              end
            else writeln('NO');
        end;

begin
     assign(input,'ONEARC.INP'); reset(input);
     assign(output,'ONEARC.OUT'); rewrite(output);
     readln(n,m);
     for i := 1 to m do
       begin
           readln(u,v);
           ke[i] := v; next[i] := head[u]; head[u] := i;
           with e[i] do
             begin
                 x := u; y := v;
             end;
       end;
     main;
end.


