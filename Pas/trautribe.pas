Uses math;
Const
    inp = 'tribe.inp';
    out = 'tribe.out';
    maxn = 15;

Var
    n,res,sh,i,u,v : longint;
    b : array [1..maxn,1..maxn] of longint;
    a : array [1..maxn,1..maxn] of boolean;
    m,kq,x : array [1..maxn] of longint;
    free : array [1..maxn] of boolean;

function check(u,j : longint) : boolean;
    var i : longint;
begin
    for i := 1 to m[j] do
     if a[u,b[j,i]] then exit(false);
    exit(true);
end;

procedure xuly;
    var i,j : longint;
        ok : boolean;
begin
    sh := 0;
    fillchar(m,sizeof(m),0);
    fillchar(b,sizeof(b),0);
    for i := 1 to n do
      begin
         ok := false;
         for j := 1 to sh do
         begin
         if check(x[i],j) then
           begin
              ok := true;
              inc(m[j]); b[j,m[j]] := x[i];
              break;
           end;
         end;
         if ok = false then
           begin
               inc(sh); b[sh,1] := x[i]; m[sh] := 1;
           end;
      end;
    if res < sh then
      begin
          res := sh;
          kq := x;
      end;
end;

procedure try(i : longint);
    var j,v : longint;
begin
    if i > n then
      begin
          xuly;
          exit;
      end;
    for j := 1 to n do
     if free[j] then
       begin
           x[i] := j;
           free[j] := false;
           try(i+1);
           free[j] := true;
       end;
end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(n);
    fillchar(free,sizeof(free),true);
    for i := 1 to n-1 do
      begin
          read(u,v);
          a[u,v] := true; a[v,u] := true;
      end;
    try(1);
    writeln(res);
    for i := 1 to n do write(kq[i],' ');
end.
