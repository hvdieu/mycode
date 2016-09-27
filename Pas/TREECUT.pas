Uses math;
Const   maxn = 100001;

Var     n,i,s,u,v,x,res,top,dem     :       longint;
        head,a,b,st,cha    :       array [1..maxn] of longint;
        ke,next :       array [-maxn..maxn] of longint;

{**************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := st[l+random(h-l+1)];
            repeat
                while st[i] > k do inc(i);
                while st[j] < k do dec(j);
                if i <= j then
                  begin
                      if i < j then
                       begin
                         swap(st[i],st[j]);
                       end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
procedure dfs(u : longint);
var j,v,i : longint;
        begin
             j := head[u];
             top := 0;
             while j <> 0 do
               begin
                   v := ke[j];
                   if cha[v] = 0 then
                     begin
                         cha[v] := u;
                         dfs(v);
                     end;
                   j := next[j];
               end;
             j := head[u]; top := 0;
             while j <> 0 do
               begin
                    v := ke[j];
                    if cha[v] = u then
                      begin
                          inc(top); st[top] := a[v]+1;
                      end;
                    j := next[j];
               end;
             if top > 0 then
               begin
                   sort(1,top);
                   for i := 1 to top+1 do
                    if st[i] + st[i+1] > x then inc(dem)
                     else
                       begin
                           a[u] := st[i];
                           break;
                       end;
               end;
        end;
{***************************************************************************}
procedure main;
var i,j,d,c : longint;
        begin
             d := 0; c := n;
             while d <= c do
               begin
                   x := (d+c) shr 1;
                   fillchar(a,sizeof(a),0);
                   fillchar(b,sizeof(b),0);
                   fillchar(cha,sizeof(cha),0);
                   cha[1] := 1;
                   dem := 0;
                   dfs(1);
                   if dem <= s then
                    begin
                       c := x-1;
                       res := x;
                    end
                   else d := x+1;
               end;
             writeln(res);
        end;
{***************************************************************************}
begin
     assign(input,'TREECUT.INP'); reset(input);
     assign(output,'TREECUT.OUT'); rewrite(output);
     readln(n,s);
     for i := 1 to n-1 do
       begin
           read(u,v);
           ke[i] := v; next[i] := head[u]; head[u] := i;
           ke[-i] := u; next[-i] := head[v]; head[v] := -i;
       end;
     main;
end.
