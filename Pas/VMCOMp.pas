Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        a,head,x,y,t       :       array [1..maxn] of longint;
        adj,e     :       array [1..2*maxn] of longint;
        queue   :       array [1..maxn] of longint;
        ns      :       array [1..maxn] of int64;
        free    :       array [1..maxn] of boolean;
        n,s,k,m,dem       :       longint;

Procedure nhap;
Var i,j,u,v,c    :       longint;
        BEGIN
                Assign(fi,inp); reset(fi);
                readln(fi,n,m,s);
                For i := 1 to m do
                   BEGIN
                       readln(fi,u,v,c);
                       inc( head[ u ]);
                       inc(head[ v ]);
                       x[i] := u;
                       y[i] := v;
                       t[i] := c;
                   END;

                head[n+1] := 2*m;
                close(fi);
                for i := 2 to n do
                 head[i] := head[i-1] + head[i];
                for i := 1 to m do
                 BEGIN

                     adj[ head[x[i]] ] := y[i];
                     e[ head[x[i]] ] := t[i];
                     dec(head[ x[i] ]);

                     adj[ head[y[i]] ]:= x[i];
                     e[ head[y[i]] ] := t[i];
                     dec(head[y[i]]);
                 END;
        END;

Procedure BFS ( u : longint);
Var i,j,left,right,p,v   :   longint;
        BEGIN
            left := 0;
            right := 1;
            queue[right] := u;
            dec(dem);
            free[u] := false;
            While left < right do
                BEGIN
                     inc(left);
                     p := queue[left];
                     for i := head[p] + 1 to head[p+1] do
                        BEGIN
                            v := adj[i];
                            if free[v] then
                                BEGIN
                                    ns[v] := ns[v] - e[i];
                                    if ns[v] < s then
                                        BEGIN
                                            free[v] := false;
                                            inc(right);
                                            queue[right] := v;
                                            dec(dem);
                                        END;
                                END;
                        END;
                END;
        END;

Procedure main;
Var i,j,t   :  longint;
        BEGIN
               fillchar(free,sizeof(free),true);
               for i := 1 to n do
                for j := head[i] + 1 to head[i+1] do
                  BEGIN
                      t := adj[j];
                      ns[i] := ns[i] + e[j];
                  END;
                dem := n;
               for i := 1 to n do
                 if (ns[i] < s) and free[i] then BFS(i);
        END;


Procedure xuat;
Var i : longint;
BEGIN
        Assign(fo,out);rewrite(fo);
        if dem = 0 then write(fo,-1)
        else begin
        writeln(fo,dem);
        For  i := 1 to n do
          if free[i] then write(fo,i,' ');
        end;
        close(fo);
END;
BEGIN
     nhap;
     main;
     xuat;
END.
