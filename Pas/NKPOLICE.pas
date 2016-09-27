Const   inp = '';
        out = '';
        maxn = 100001;
        maxm = 500001;
Var     fi,fo   :       text;
        n,m,dem1,dem2   :       longint;
        head,low,num,cha,thoat,ncon  :       array [1..maxn] of longint;
        khop    :       array [1..maxn] of boolean;
        adj     :       array [1..2*maxm] of longint;
        x,y     :       array [1..maxm] of longint;
        a,b,c,g1,g2,q : longint;
        ok      :       boolean;

Procedure input;
Var i,j : longint;
        BEGIN
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n,m);
             for i := 1 to m do
               begin
                    readln(fi,x[i],y[i]);
                    inc(head[x[i]]);
                    inc(head[y[i]]);
               end;
             for i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := 2*m;
             for i := 1 to m do
               begin
                   adj[head[x[i]]] := y[i];
                   dec(head[x[i]]);
                   adj[head[y[i]]] := x[i];
                   dec(head[y[i]]);
               end;
        END;

Procedure DFS(u : longint);
Var i,v : longint;
        BEGIN
              inc(dem1); num[u] := dem1;
              low[u] := num[u];
              for i := head[u] + 1 to head[u+1] do
                begin
                    v := adj[i];
                    if cha[v] = 0 then
                      begin
                          cha[v] := u;
                          inc(ncon[u]);
                          DFS(v);
                          if low[u] > low[v] then low[u] := low[v];
                      end
                       else if (cha[u] <> v) and (cha[v] <> u) then
                         if low[u] > num[v] then low[u] := num[v];
                end;
              inc(dem2); thoat[u] := dem2;
        END;

Function check(u,v : longint) : boolean;
        BEGIN
              if (num[u] <= num[v]) and (thoat[u] >= thoat[v]) then exit(true)
                else exit(false);
        END;

Procedure swap(var xx,yy : longint);
Var temp   :  longint;
        BEGIN
            temp := xx; xx := yy; yy := temp;
        END;

Procedure th1(u : longint);
Var i,j,v,e,f : longint;
        BEGIN
            ok := false;
            e := a; f := b;
            For i := head[u] + 1 to head[u+1] do
              begin
                   v := adj[i];
                   if (cha[v] = u) then
                      begin
                           if check(v,a) then e := v;
                           if check(v,b) then f := v;
                      end;
              end;
            if e = f then
               begin
                    writeln(fo,'yes');
                    exit;
               end;
            if (low[e] < num[u]) and (low[f] < num[u]) then
               begin
                   writeln(fo,'yes');
                   exit;
               end;
            writeln(fo,'no');
        END;

Procedure th2(u : longint);
Var i,j,v,e : longint;
        BEGIN
              if (not check(u,a)) and (not check(u,b)) then
                begin
                     writeln(fo,'yes');
                     exit;
                end;
              if check(u,a) then swap(a,b);
              e := b;
              for i := head[u] +1 to head[u+1] do
                begin
                      v := adj[i];
                      if (cha[v] = u) and check(v,b) then e := v;
                end;
              if low[e] < num[u] then
                begin
                    writeln(fo,'yes');
                    exit;
                end;
              writeln(fo,'no');
        END;

Procedure xuly;
var ok : boolean;
        BEGIN
             if (cha[g1] = g2) and (low[g1] >= num[g1]) then
               begin
                   if (check(g1,a) = check(g1,b))
                      then writeln(fo,'yes')
                      else writeln(fo,'no');
                   exit;
               end;
             if (cha[g2] = g1) and (low[g2] >= num[g2]) then
               begin
                   if check(g2,a) = check(g2,b) then writeln(fo,'yes')
                    else writeln(fo,'no');
                   exit;
               end;
             writeln(fo,'yes');
             exit;
        END;

Procedure main;
Var i,j,u,v,k : longint;
        BEGIN
              for u := 1 to n do
                if cha[u] = 0 then
                  begin
                       cha[u] := -1;
                       DFS(u);
                  end;
              for v := 1 to n do
                 begin
                      u := cha[v];
                      if (u<>-1) and (low[v] >= num[u]) then
                        if (cha[u] <> -1) or (ncon[u] >= 2)
                           then khop[u] := true;
                 end;
              readln(fi,q);
              for i := 1 to q do
                begin
                     read(fi,k);
                     if k = 1 then
                        begin
                             readln(fi,a,b,g1,g2);
                             xuly;
                        end
                     else if k = 2 then
                        begin
                             readln(fi,a,b,u);
                             if khop[u] then
                               begin
                               if check(u,a) and check(u,b) then th1(u)
                                 else th2(u);
                               end
                             else writeln(fo,'yes');
                        end;
                end;
              close(fi); close(fo);
        END;

BEGIN
      input;
      main;
END.
