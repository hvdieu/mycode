uses math;
const
    inp = '';
    out = '';
    maxn = 1001;

Var
    n,m,k,i,u,v,cnt : longint;
    a : array [1..maxn,1..maxn] of longint;
    mau : array [1..maxn] of longint;
    x,y : array [1..maxn*maxn] of longint;

procedure dfs(u : longint);
    var v : longint;
begin
    mau[u] := cnt;
    for v := 1 to n do
     if (a[u,v]=0) and (mau[v]=0) then dfs(v);
end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(n,m,k);
    for i := 1 to m do
     begin
         readln(u,v);
         a[u][v] := 1; a[v][u] := 1;
         x[i] := u; y[i] := v;
     end;
    for i := 1 to n do if mau[i]=0 then
      begin
          inc(cnt);
          dfs(i);
      end;
    if cnt > k then write(-1)
     else begin
         for i := 1 to m do
          if mau[x[i]]=mau[y[i]] then
            begin
                write(-1);
                halt;
            end;
          for i := 1 to n do write(mau[i],' ');
     end;
end.