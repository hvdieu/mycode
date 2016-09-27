Uses math;
Const   inp = '';
        out = '';
        maxn = 5001;
        maxm = 100001;
        maxw = 999999999;

Var     m,n,k,left,right,res   :       longint;
        head,queue    :       array [0..maxn] of longint;
        ke,next :       array [1..maxm] of longint;
        d       :       array [0..8,0..maxn] of longint;
        free    :       array [0..maxn] of boolean;
        f       :       array [0..256,0..8] of longint;

{**************************************************************************}
procedure nhap;
var i,u,v : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n,k,m);
            for i := 1 to m do
             begin
                 readln(u,v);
                 ke[i] := v; next[i] := head[u]; head[u] := i;
             end;
        end;
{**************************************************************************}
procedure bfs(i : longint);
var j,u,v : longint;
        begin
            fillchar(free,sizeof(free),true); free[i] := false;
            left := 0; right := 1; queue[1] := i;
            while left < right do
             begin
                 inc(left); u := queue[left]; j := head[u];
                 while j <> 0 do
                  begin
                     v := ke[j];
                     if free[v] then
                      begin
                          free[v] := false; inc(right); queue[right] := v;
                          d[i,v] := d[i,u] + 1;
                      end;
                     j := next[j];
                  end;
             end;
        end;
{**************************************************************************}
procedure main;
var i,j,tt,x : longint;
        begin
             for i := 0 to k-1 do
              for j := 0 to n-1 do
               if i=j then d[i,j] := 0 else d[i,j] := maxw;
             for i := 0 to k-1 do bfs(i);
             for i := 0 to 1 shl k-1 do
              for j := 0 to k-1 do f[i,j] := maxw;
             for i := 0 to k-1 do
              f[1 shl i,i] := d[0,i];
             for tt := 1 to 1 shl k-1 do
              for i := 0 to k-1 do
               if f[tt,i] < maxw then
                begin
                   for j := 0 to k-1 do
                    if (i<>j) and ((tt shr j) and 1=0) then
                      begin
                          x := tt or (1 shl j);
                          f[x,j] := min(f[x,j],f[tt,i] + d[i,j]);
                      end;
                end;
             res := maxw;
             for i := 0 to k-1 do
              res := min(res,f[1 shl k-1,i]+d[i,0]);
             writeln(res);
        end;
{**************************************************************************}
begin
    nhap;
    main;
end.
