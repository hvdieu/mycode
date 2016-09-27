Const   inp = 'MECUNG.INP';
        out = 'MECUNG.OUT';
        maxn = 100001;
        maxm = 200001;

Var     n,m     :       longint;
        head,queue,d,path,pre,color,lop    :       array [0..maxn] of longint;
        ke,next,c       :       array [-maxm..maxm] of longint;
        free    :       array [0..maxn] of boolean;

{***************************************************************************}
procedure nhap;
var i,u,v,l : longint;
        begin
            // assign(input,inp); reset(input);
            // assign(output,out); rewrite(output);
             readln(n,m);
             for i := 1 to m do
               begin
                   read(u,v,l);
                   ke[i] := v; c[i] := l; next[i] := head[u]; head[u] := i;
                   ke[-i] := u; c[-i] := l; next[-i] := head[v]; head[v] := -i;
               end;
        end;
{*************************************************************************}
procedure khoitao;
var i,left,right,u,v,j  :  longint;
        begin
             left := 0; right := 1;
             fillchar(free,sizeof(free),true);
             queue[1] := n; free[n] := false;
             while left < right do
               begin
                   inc(left); u := queue[left];
                   j := head[u];
                   while j <> 0 do
                     begin
                         v := ke[j];
                         if free[v] then
                           begin
                               free[v] := false;
                               d[v] := d[u] + 1;
                               inc(right); queue[right] := v;
                           end;
                         j := next[j];
                     end;
               end;
        end;
{**************************************************************************}
function behon(a,b : longint) : boolean;
        begin
            if (color[pre[a]] < color[pre[b]]) or
             ((color[pre[a]] = color[pre[b]]) and (color[a] <= color[b]))
               then exit(true) else exit(false);
        end;
{***************************************************************************}
procedure bfs;
var i,j,u,v,left,right,dem,temp,z,now,t : longint;
        begin
             fillchar(free,sizeof(free),true);
             left := 0; right := 1;
             queue[1] := 1; free[1] := false;
             color[0] := maxlongint;
             dem := -1;
             while left < right do
               begin
                   inc(left); z := 0;
                   now := left;
                   while (now < right) and (lop[now] = lop[now+1]) do inc(now);
                   for t := left to now do
                     begin
                         u := queue[t];
                         if behon(u,z) then
                           begin
                               temp := color[u];
                               z := u;
                           end;
                     end;
                   inc(dem); path[dem] := temp;
                   for t := left to now do
                     begin
                         u := queue[t];
                         if behon(u,z) then
                           begin
                               j := head[u];
                               while j <> 0 do
                                 begin
                                     v := ke[j];
                                     if (free[v]) and (d[v] = d[u]-1) then
                                       begin
                                          free[v] := false;
                                          inc(right); queue[right] := v;
                                          pre[v] := u; color[v] := c[j];
                                       end
                                     else if (d[v] = d[u]-1) and (color[v] > c[j]) then
                                       begin
                                           color[v] := c[j];
                                           pre[v] := u;
                                       end;
                                     j := next[j];
                                 end;
                           end;
                     end;
                   left := now;
               end;
        end;
{**************************************************************************}
procedure ghikq;
var i : longint;
        begin
            writeln(d[1]);
            for i := 1 to d[1] do write(path[i],' ');
        end;
{**************************************************************************}
procedure main;
var i,j : longint;
        begin
            khoitao;
            bfs;
            ghikq;
        end;
{***************************************************************************}
begin
     nhap;
     main;
end.
