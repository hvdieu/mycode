Uses math;
Const   inp = 'snow.inp';
        out = 'snow.out';
        maxn = 100001;

Var     n,x,res,tmp  : longint;
        head,a,b : array [1..maxn] of longint;
        free     : array [1..maxn] of boolean;
        ke,next,w    :         array [-maxn..maxn] of longint;

procedure nhap;
var i,j,u,v,c : longint;
  begin
       assign(input,inp); reset(input);
       assign(output,out); rewrite(output);
       readln(n,x);
       for i := 1 to n-1 do
         begin
           readln(u,v,c);
           ke[i] := v; w[i] := c; next[i] := head[u]; head[u] := i;
           ke[-i] := u; w[-i] := c; next[-i] := head[v]; head[v] := -i;
           res := res + 2*c;
         end;
  end;

procedure dfs(u : longint);
var j,v,max1,max2 : longint;
  begin
       free[u] := false;
       j := head[u]; max1 := 0; max2 := 0;
       while j <> 0 do
         begin
           v := ke[j];
           if free[v] then
             begin
               dfs(v);
               x := a[v]+w[j];
               if x > a[u] then a[u] := x;
               if x > max1 then
                 begin
                   max2 := max1; max1 := x;
                 end
               else if x > max2 then max2 := x;
             end;
           j := next[j];
         end;
       b[u] := max1+max2;
  end;

procedure main;
var i,j,u : longint;
  begin
    fillchar(free,sizeof(free),true);
    dfs(x);
    for u := 1 to n do tmp := max(tmp,b[u]);
    writeln(res-tmp);
  end;

begin
    nhap;
    main;
end.
