Const   inp = '';
        out = '';
        maxn = 30001;
        maxm = 100001;
Type    arr     =       array [1..maxn] of longint;
Var     fi,fo   :       text;
        n,m,nheap,dem     :       longint;
        head,d1,d2,heap,kq    :       array [1..maxn] of longint;
        f1,f2   :       array [1..maxn] of longint;
        pos     :       array [1..maxn] of longint;
        adj,cost     :       array [1..2*maxm] of longint;
        x,y,z   :       array [1..maxm] of longint;
        free    :       array [1..maxn] of boolean;

procedure Update(v: longint;Var d : arr);
var
  parent, child: longint;
begin
  child := Pos[v];
  if child = 0 then
    begin
      Inc(nHeap); child := nHeap;
    end;
  parent := child div 2;
  while (parent > 0) and (d[heap[parent]] > d[v]) do
    begin
      heap[child] := heap[parent];
      Pos[heap[child]] := child;
      child := parent;
      parent := child div 2;
    end;
  heap[child] := v;
  Pos[v] := child;
end;

function Pop( Var d : arr): longint;
var
  r, c, v: longint;
begin
  Pop := heap[1];
  v := heap[nHeap];
  Dec(nHeap);
  r := 1;
  while r * 2 <= nHeap do
    begin
      c := r * 2;
      if (c < nHeap) and (d[heap[c + 1]] < d[heap[c]]) then Inc(c);
      if d[v] <= d[heap[c]] then Break;
      heap[r] := heap[c];
      Pos[heap[r]] := r;
      r := c;
    end;
  heap[r] := v;
  Pos[v] := r;
end;

Procedure input;
Var i : longint;
        BEGIN
              Assign(fi,inp) ;reset(fi);
              readln(fi,n,m);
              For i := 1 to m do
                BEGIN
                      readln(fi,x[i],y[i],z[i]);
                      inc(head[x[i]]);
                      inc(head[y[i]]);
                END;
              close(fi);
        END;

Procedure init;
Var i : longint;
        BEGIN
               For i := 2 to n+1 do head[i] := head[i] + head[i-1];
               For i := 1 to m do
                  BEGIN
                        adj[ head[x[i]] ] := y[i];
                        adj[ head[y[i]] ] := x[i];
                        cost[ head[x[i]] ] := z[i];
                        cost[ head[y[i]] ] := z[i];
                        dec(head[x[i]]);
                        dec(head[y[i]]);
                  END;
        END;

Procedure de1;
Var u,v,i : longint;
        BEGIN
             For i := 1 to n do d1[i] := 99999999;
             fillchar(f1,sizeof(f1),0);
             f1[1] := 1;
             d1[1] := 0;
             fillchar(free,sizeof(free),true);
             fillchar(pos,sizeof(pos),0);
             nheap := 0;

             Update(1,d1);
             Repeat
                  u := pop(d1);
                  if u=n then break;
                  free[u] := false;
                  for i := head[u] + 1 to head[u+1] do
                     BEGIN
                           v := adj[i];
                           if free[v] then
                              if (d1[v] > d1[u] + cost[i]) then
                              BEGIN
                                    d1[v] := d1[u] + cost[i];
                                    f1[v] := f1[u];
                                    Update(v,d1);
                              END
                                else if d1[v] = d1[u] + cost[i] then
                                   f1[v] := f1[u] + f1[v];
                     END;
             Until nheap = 0;

        END;


Procedure de2;
Var u,v,i : longint;
        BEGIN
             For i := 1 to n do d2[i] := 99999999;
             fillchar(f2,sizeof(f2),0);
             f2[n] := 1;
             d2[n] := 0;
             fillchar(free,sizeof(free),true);
             fillchar(pos,sizeof(pos),0);
             nheap := 0;

             Update(n,d2);
             Repeat
                   u := pop(d2);
                   if u = 1 then break;
                   free[u] := false;
                   for i := head[u] + 1 to head[u+1] do
                      BEGIN
                             v := adj[i];
                             if free[v] then
                               if (d2[v] > d2[u] + cost[i]) then
                                BEGIN
                                   d2[v] := d2[u] + cost[i];
                                   f2[v] := f2[u];
                                   Update(v,d2);
                                END
                                  else if d2[v] = d2[u] + cost[i] then
                                    f2[v] := f2[v] + f2[u];
                      END;
             Until nheap = 0;
        END;

Procedure main;
Var i,j : longint;
        BEGIN
              de1;
              de2;
              For i := 2 to n-1 do
                 if (f1[i] * f2[i] = f1[n]) and (d1[i] + d2[i] = d1[n]) then continue
                 else
                    BEGIN
                          inc(dem);
                          kq[dem] := i;

                    END;
              Assign(fo,out); rewrite(fo);
              writeln(fo,dem);
              For i := 1 to dem do writeln(fo,kq[i]);
              close(fo);
        END;

BEGIN
       input;
       init;
       main;
END.
