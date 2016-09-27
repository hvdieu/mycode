Uses math;
Const   maxn = 3001;
        maxm = 6001;
        maxw = 9999999;

Var     n,m,maxd     :       longint;
        head,queue,res    :       array [1..maxn] of longint;
        ke,next :       array [-maxm..maxm] of longint;
        d       :       array [1..maxn,1..maxn] of longint;
        free    :       array [1..maxn] of boolean;

{**************************************************************************}
procedure nhap;
var i,j,u,v : longint;
        begin
          //   assign(input,'VOSNET.INP'); reset(input);
          //   assign(output,'VOSNET.OUT'); rewrite(output);
             readln(n,m);
             for i := 1 to m do
               begin
                   read(u,v);
                   ke[i] := v; next[i] := head[u]; head[u] := i;
                   ke[-i] := u; next[-i] := head[v]; head[v] := -i;
               end;
        end;
{**************************************************************************}
procedure bfs(i : longint);
var u,v,j,left,right : longint;
        begin
            left := 0; right := 1;
            fillchar(free,sizeof(free),true);
            queue[1] := i; free[i] := false;
            while left < right do
              begin
                  inc(left); u := queue[left];
                  j := head[u];
                  while j <> 0 do
                    begin
                        v := ke[j];
                        if free[v] then
                          begin
                              inc(right); queue[right] := v; free[v] := false;
                              d[i,v] := d[i,u] + 1;
                              maxd := max(maxd,d[i,v]);
                          end;
                        j := next[j];
                    end;
              end;
        end;
{**************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            for i := 1 to n do
             for j := 1 to n do
              if i = j then d[i,j] := 0 else d[i,j] := maxw;
        end;
{***************************************************************************}
procedure main;
var i,j : longint;
        begin
             for i := 1 to n do bfs(i);
             for i := 1 to n do
              for j := 1 to n do
               if (i <> j) and (d[i,j] < maxw) and (d[i,j] > 1)
                 then inc(res[d[i,j]-1]);
             for i := 1 to maxd-1 do write(res[i] div 2,' ');
             write(0);
        end;
{**************************************************************************}
begin
     nhap;
     khoitao;
     main;
end.