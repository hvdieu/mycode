Const   inp = 'NETWORK.INP';
        out = 'NETWORK.OUT';
        maxn = 2001;

Type    canh    = record
        x,y : longint;
        end;

Var     n,m,dem1,dem2     :       longint;
        head,num,thoat,cha,ts,queue    :       array [1..maxn] of longint;
        ke,next,w :       array [-maxn..maxn] of longint;
        free    : array [1..maxn] of boolean;
        e       : array [1..maxn] of canh;

{**************************************************************************}
procedure nhap;
var i,u,v,l : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n,m);
            for i := 1 to n-1 do
              begin
                  readln(u,v,l);
                  with e[i] do
                    begin
                        x := u; y := v;
                    end;
                  ke[i] := v; w[i] := l; next[i] := head[u]; head[u] := i;
                  ke[-i] := u; w[-i] := l; next[-i] := head[v]; head[v] := -i;
              end;
        end;
{**************************************************************************}
procedure dfs(u : longint);
var j,v : longint;
        begin
            inc(dem1); num[u] := dem1;
            j := head[u]; free[u] := false;
            while j <> 0 do
              begin
                  v := ke[j];
                  if cha[v] = 0 then
                   begin
                      cha[v] := u;
                      ts[v] := w[j];
                      dfs(v);
                   end;
                  j := next[j];
              end;
            inc(dem2); thoat[u] := dem2;
        end;
{**************************************************************************}
function check(u,v : longint) : boolean;
        begin
            if (num[u] <= num[v]) and (thoat[u] >= thoat[v]) then exit(true)
             else exit(false);
        end;
{**************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            dem1 := 0; dem2 := 0;
            cha[1] := 1;
            dfs(1);
        end;
{**************************************************************************}
procedure PQueries(u,v,c : longint);
var i,j,res : longint;
        begin
            res := 0;
            if u = v then
              begin
                  writeln(0);
                  exit;
              end;
            if check(u,v) then
              begin
                  while v <> u do
                    begin
                        if ts[v] <= c then inc(res);
                        v := cha[v];
                    end;
                  writeln(res); exit;
              end;
            if check(v,u) then
              begin
                  while u <> v do
                    begin
                        if ts[u] <= c then inc(res);
                        u := cha[u];
                    end;
                  writeln(res); exit;
              end;
            i := u;
            while check(i,v) = false do
              begin
                  if ts[i] <= c then inc(res);
                  i := cha[i];
              end;
            while check(v,u) = false do
              begin
                  if ts[v] <= c then inc(res);
                  v := cha[v];
              end;
            writeln(Res);
        end;
{**************************************************************************}
procedure TQueries(k,c : longint);
var left,right,u,v,j,res : longint;
        begin
             fillchar(free,sizeof(free),true);
             res := 0;
             left := 0; right := 1;
             queue[1] := e[k].y; free[e[k].y] := false;
             while left < right do
               begin
                   inc(left); u := queue[left];
                   j := head[u];
                   while j <> 0 do
                     begin
                         v := ke[j];
                         if free[v] and (v <> e[k].x) then
                           begin
                               free[v] := false;
                               if w[j] <= c then inc(res);
                               inc(right); queue[right] := v;
                           end;
                         j := next[j];
                     end;
               end;
             writeln(res);
        end;
{**************************************************************************}
procedure main;
var i,j,u,v,c,k : longint;
    ch : char;
        begin
             khoitao;
             for i := 1 to m do
               begin
                   read(ch);
                   if ch = 'P' then
                     begin
                         readln(u,v,c);
                         PQueries(u,v,c);
                     end
                   else
                     begin
                         readln(k,c);
                         TQueries(k,c);
                     end;
               end;
        end;
{**************************************************************************}
begin
     nhap;
     main;
end.