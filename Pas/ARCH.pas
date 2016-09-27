Uses math;

Const   maxn = 300001;

Var     n,dem,res,m       :       longint;
        head,f    :       array [0..maxn] of longint;
        ke,next :       array [-maxn..maxn] of longint;
        free    :       array [1..maxn] of boolean;

{*************************************************************************}
procedure nhap;
var i,u,v : longint;
        begin
             assign(input,'ARCH.INP'); reset(input);
             assign(output,'ARCH.OUT'); rewrite(output);
             readln(n);
             for i := 1 to n-1 do
               begin
                   read(u,v);
                   ke[i] := v; next[i] := head[u]; head[u] := i;
                   ke[-i] := u; next[-i] := head[v]; head[v] := -i;
               end;
        end;
{**************************************************************************}
procedure dfs(u : longint);
var j,v : longint;
        begin
            free[u] := false; inc(dem); inc(f[dem]);
            m := max(m,dem);
            j := head[u];
            while j <> 0 do
              begin
                  v := ke[j];
                  if free[v] then
                  begin
                    dfs(v);
                    dec(dem);
                  end;
                  j := next[j];
              end;
        end;
{**************************************************************************}
function check(k : longint) : boolean;
var i,du : longint;
        begin
            du := 0;
            for i := 1 to m do
             if du+k >= f[i] then du := du+k-f[i]
              else exit(false);
            exit(true);
        end;
{**************************************************************************}
procedure main;
var i,d,c,mid : longint;
        begin
            fillchar(free,sizeof(free),true);
            dem := -1;
            dfs(1);
            d := 0; c := n;
            while d <= c do
              begin
                  mid := (d+c) shr 1;
                  if check(mid) then
                    begin
                        res := mid;
                        c := mid-1;
                    end
                  else d := mid+1;
              end;
            writeln(res);
        end;
{***************************************************************************}
begin
    nhap;
    main;
end.