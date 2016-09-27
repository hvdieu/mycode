Const
    inp = 'ad.inp';
    out = 'asd.out';
    maxn = 2010;

Var
    n,m,top,i,j,u,v,r1,r2 : longint;
    d : array [1..maxn,1..maxn] of longint;
    d1 : array [1..maxn,1..maxn] of int64;
    x,y,c : array [1..maxn*maxn] of longint;
    root : array [1..maxn] of longint;
    head : array [1..maxn] of longint;
    ke,next,w : array [-maxn..maxn] of longint;
    free : array [1..maxn] of boolean;

procedure swap(var x,y : longint);
    var temp : longint;
begin
    temp := x; x := y; y := temp;
end;

procedure sort(l,h : longint);
    var i,j,k : longint;
begin
    if l >= h then exit;
    i := l; j := h; k := c[l+random(h-l+1)];
    repeat
       while c[i] < k do inc(i);
       while c[j] > k do dec(j);
       if i <= j then
         begin
             swap(x[i],x[j]);
             swap(y[i],y[j]);
             swap(c[i],c[j]);
             inc(i); dec(j);
         end;
    until i > j;
    sort(l,j); sort(i,h);
end;

function getroot(u : longint) : longint;
begin
    if u <> root[u] then root[u] := getroot(root[u]);
    exit(root[u]);
end;

procedure dfs(i,u : longint);
    var j,v : longint;
begin
    free[u] := false;
    j := head[u];
    while j <> 0 do
     begin
         v := ke[j];
         if free[v] then
          begin
              d1[i,v] := d1[i,u]+w[j];
              dfs(i,v);
          end;
         j := next[j];
     end;
end;

procedure main;
    var i,j : longint;
begin
    for i := 1 to n do
     for j := 1 to i-1 do
      if (d[i,j] <> d[j,i]) or ((i=j) and (d[i,j]<>0))
       or ((i<>j) and (d[i,j]=0))then
       begin
           writeln('NO');
           exit;
       end
     else begin
         inc(top); x[top] := i; y[top] := j; c[top] := d[i,j];
     end;
    sort(1,top);
    for i := 1 to n do root[i] := i;
    for i := 1 to top do
     begin
         u := x[i]; v := y[i];
         r1 := getroot(u);
         r2 := getroot(v);
         if r1 <> r2 then
           begin
               root[r1] := root[r2];
               inc(m);
               ke[m] := v; next[m] := head[u]; head[u] := m; w[m] := c[i];
               ke[-m] := u; next[-m] := head[v]; head[v] := -m; w[-m] := c[i];
           end;
     end;
    for i := 1 to n do
    begin
    fillchar(free,sizeof(free),true);
    dfs(i,i);
    end;
    for i := 1 to n do
    for j := 1 to n do
      if d1[i,j] <> d[i,j] then
      begin
          writeln('NO');
          exit;
      end;
    writeln('YES');
end;

begin
   // assign(input,inp) ;reset(input);
   // assign(output,out); rewrite(output);
    readln(n);
    for i := 1 to n do
     for j := 1 to n do read(d[i,j]);
    main;
end.