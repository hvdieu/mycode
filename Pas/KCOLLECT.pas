Uses math;

Const   inp = 'test.inp';
        out = 'kcollect.out';
        maxn = 101;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);

Var     m,n,dem,count,cl,id,res,top     :       longint;
        a       :       array [0..maxn,0..maxn] of char;
        head    :       array [1..maxn*maxn] of longint;
        ke,next :       array [-4*maxn*maxn..4*maxn*maxn] of longint;
        low,num,lab :       array [0..maxn,0..maxn] of longint;
        qx,qy,f,q,g   :       array [1..maxn*maxn] of longint;
        free    :   array [0..maxn,0..maxn] of boolean;
        dd      :   array [1..maxn*maxn] of boolean;

{***************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
             readln(m,n);
             for i := 1 to m do
              begin
                  for j := 1 to n do read(a[i,j]);
                  readln;
              end;
        end;
{***************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            for i := 1 to m do
             for j := 1 to n do free[i,j] := true;
            fillchar(dd,sizeof(dd),true);
        end;
{***************************************************************************}
procedure dfs(i,j : longint);
var k,u,v : integer;
        begin
            inc(dem); num[i,j] := dem; low[i,j] := dem;
            inc(top); qx[top] := i; qy[top] := j;
            for k := 2 to 3 do
             if free[i+h[k],j+c[k]] and (a[i+h[k],j+c[k]] <> '#') then
              begin
                  u := i+h[k]; v := j+c[k];
                  if num[u,v] = 0 then
                    begin
                        dfs(u,v);
                        low[i,j] := min(low[i,j],low[u,v]);
                    end
                  else low[i,j] := min(low[i,j],num[u,v]);
              end;

             if a[i,j] = 'W' then
              if free[i,j-1] and (a[i,j-1] <> '#') then
                if num[i,j-1] = 0 then
                  begin
                      dfs(i,j-1);
                      low[i,j] := min(low[i,j],low[i,j-1]);
                  end
                else low[i,j] := min(low[i,j],num[i,j-1]);

             if a[i,j] = 'N' then
              if free[i-1,j] and (a[i-1,j] <> '#') then
                if num[i-1,j] = 0 then
                  begin
                      dfs(i-1,j);
                      low[i,j] := min(low[i,j],low[i-1,j]);
                  end
                else low[i,j] := min(low[i,j],num[i-1,j]);

             if low[i,j] = num[i,j] then
               begin
                    inc(count); lab[i,j] := count;
                    repeat
                       u := qx[top]; v := qy[top];
                       free[u,v] := false; lab[u,v] := count;
                       dec(top);
                    until (u = i) and (v = j);
               end;
        end;
{***************************************************************************}
procedure union(u,v : longint);
        begin
            inc(cl);
            ke[cl] := v; next[cl] := head[u]; head[u] := cl;
        end;
{***************************************************************************}
procedure xaydothi;
var i,j,k,x,u,v : longint;
        begin
             for i := 1 to m do
              for j := 1 to n do
               if (num[i,j] = 0) and (a[i,j] <> '#') then
               begin
                 top := 0;
                 dfs(i,j);
               end;
             for i := 1 to m do
              for j := 1 to n do
               if a[i,j] <> '#' then
                 begin
                     if (a[i,j] <> 'W') and (a[i,j] <> 'N')
                      then begin
                             val(a[i,j],x);
                             inc(f[lab[i,j]],x);
                           end;

                     for k := 2 to 3 do
                      if (a[i+h[k],j+c[k]] <> '#') and (lab[i+h[k],j+c[k]] <> 0) then
                        begin
                            u := lab[i,j];
                            v := lab[i+h[k],j+c[k]];
                            if u <> v then union(u,v);
                        end;
                     if a[i,j] = 'N' then
                      if (a[i-1,j] <> '#') and (lab[i-1,j] <> 0) then
                        begin
                            u := lab[i,j];
                            v := lab[i-1,j];
                            if u <> v then union(u,v);
                        end;

                     if a[i,j] = 'W' then
                      if (a[i,j-1] <> '#') and (lab[i,j-1] <> 0) then
                        begin
                            u := lab[i,j];
                            v := lab[i,j-1];
                            if u <> v then union(u,v);
                        end;
                 end;

        end;
{***************************************************************************}
procedure loang(u : longint);
var j,v : longint;
        begin
            dd[u] := false; j := head[u];
            while j <> 0 do
              begin
                  v := ke[j];
                  if dd[v] then loang(v);
                  j := next[j];
              end;
            q[id] := u; dec(id);
        end;
{***************************************************************************}
procedure sorttopo;
var i,j : longint;
        begin
            id := count;
            for i := 1 to count do
             if dd[i] then loang(i);
        end;
{***************************************************************************}
procedure qhd;
var i,j,u,v,vt : longint;
        begin
            for i := 1 to count do
             if q[i] = lab[1,1] then
               begin
                   vt := i;
                   break;
               end;
             fillchar(dd,sizeof(dd),false);
            dd[lab[1,1]] := true; g[lab[1,1]] := f[lab[1,1]];
            for i := vt to count do
              begin
                   u := q[i];
                   if dd[u] then
                     begin
                          j := head[u];
                          while j <> 0 do
                            begin
                                v := ke[j];
                                dd[v] := true;
                                g[v] := max(g[v],g[u] + f[v]);
                                j := next[j];
                            end;
                     end;
              end;
            for i := vt to count do
             if dd[q[i]] and (g[q[i]] > res) then res := g[q[i]];
            writeln(res);
        end;
{***************************************************************************}
procedure main;
var i,j : longint;
        begin
            xaydothi;
            sorttopo;
            qhd;
        end;

{***************************************************************************}
begin
     nhap;
     khoitao;
     main;
end.


