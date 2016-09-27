Const   maxn = 1001;
        maxm = 100001;
Var     n,m,i,x,y,l,res,temp,mid,dem   :       longint;
        head    :       array [1..maxn] of longint;
        ke,next,w :       array [-maxm..maxm] of longint;
        free    :       array [1..maxn] of boolean;

procedure dfs(u : longint);
var j,v : longint;
        begin
            free[u] := false;
            j := head[u];
            while j <> 0 do
              begin
                  if free[ke[j]] and (w[j] <= mid) then
                    begin
                        inc(dem);
                        dfs(ke[j]);
                    end;
                  j := next[j];
              end;
        end;

function check(x : longint) : boolean;
var i,j : longint;
        begin
            dem := 0;
            fillchar(free,sizeof(free),true);
            dfs(1);
            if dem=n-1 then exit(true);
            exit(false);
        end;

procedure find;
var d,c : longint;
        begin
            d := 0; c := 1000001;
            while d <= c do
              begin
                  mid := (d+c) div 2;
                  temp := 0;
                  if check(mid) then
                    begin
                        res := mid;
                        c := mid-1;
                    end
                  else d := mid+1;
              end;
            writeln(res);
        end;

begin
     assign(input,'HOW.INP'); reset(input);
     assign(output,'HOW.OUT'); rewrite(output);
     readln(n,m);
     for i := 1 to m do
       begin
           readln(x,y,l);
           ke[i] := y; ke[-i] := x; w[i] := l; w[-i] := l;
           next[i] := head[x]; next[-i] := head[y];
           head[x] := i; head[y] := -i;
       end;
     find;
end.