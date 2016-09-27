






              Low[u] := min(Low[u],Low[v]);
              Trace[v] := u;
              Visit(v);
            begin
            end
            Start[u] := true;
          else Low[u] := min(Low[u],Number[v]);
          if Trace[v] = 0 then
          or (Trace[u] <> -1) and (Low[v] >= Number[u]) then
          v := a[k];
          Vis[-k] := false;
        begin
        end;
        if (Trace[u] = -1) and (cc[u] >= 2)
        Trace[i] := -1;
        Visit(i);
      a[-i] := x;
      a[i] := y;
      begin
      end;
      Head[x] := i;
      Head[y] := -i;
      if (u <> -1) and (Low[v] >= Number[v]) then inc(Bridges);
      if (u <> -1) then
      if (u <> -1) then inc(cc[u]);
      if Vis[k] then
      k := Link[k];
      Link[-i] := Head[y];
      Link[i] := Head[x];
      Readln(ip,x,y);
      u := Trace[v];
      u := Trace[v];
      u := Trace[v];
    begin
    begin
    begin
    begin
    begin
    end;
    end;
    end;
    end;
    end;
    if Start[v] then inc(Arri);
    if Trace[i] = 0 then
  a, Link : array[-MaxM..MaxM] of Integer;
  Arri := 0;
  Assign(ip,fi); Reset(ip);
  Assign(op,fo); Rewrite(op);
  Bridges := 0;
  Close(ip);
  Close(op);
  fi = 'graph.inp';
  Fillchar(cc,sizeof(cc),0);
  Fillchar(Head,sizeof(Head),0);
  Fillchar(Start,sizeof(Start),false);
  Fillchar(Vis,sizeof(Vis),true);
  fo = 'graph.out';
  for i := 1 to m do
  for i := 1 to n do
  for v := 1 to n do
  for v := 1 to n do
  for v := 1 to n do
  for v := 1 to n do
  Head, Low, Number, cc, Trace : array[1..MaxN] of Integer;
  i : Integer;
  i, x, y : Integer;
  inc(count);
  Input;
  ip, op : Text;
  k := Head[u];
  k, v : Integer;
  Low[u] := High(Integer);
  MaxM = Round(5E4);
  MaxN = Round(1E4);
  n, m, count, Bridges, Arri : Integer;
  Number[u] := count;
  PrintResult;
  Readln(ip,n,m);
  Solve;
  v, u : Integer;
  Vis, Start : array[-MaxM..MaxM] of Boolean;
  while (k <> 0) do
  Writeln(op,Arri,' ',Bridges);
begin
begin
begin
begin
begin
const
end.
end;
end;
end;
end;
procedure Input;
procedure PrintResult;
procedure Solve;
procedure Visit(u : Integer);
uses math;
var
var
var
var
var
{$MODE OBJFPC}