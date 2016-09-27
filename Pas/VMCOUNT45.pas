Const   inp = '4.IN';
        out = 'VMCOUNT.OUT';
        m = round(1e9) + 7;
        maxn = 100;
        maxc = 1000;
Var     fi,fo   :       text;
        n,i,j       :       longint;
        c           :       char;
        head        :       array [1..maxn] of longint;
        den     :   array [1..maxn,1..maxn] of integer;
        a       :   array [0..maxn,1..maxn] of char;
        adj     :   array [1..maxc] of longint;
        queue   :       array [1..maxn] of longint;
        x       :       array [0..maxn] of longint;
        d,cx       :       array [1..maxn] of boolean;
        dem     :       longint;

Procedure BFS(u : longint);
Var left,right,px,v   :   longint;
        BEGIN
               left := 0; right := 1;
               fillchar(queue,sizeof(queue),0);
               fillchar(cx, sizeof(cx), true);
               queue[right] := u;
               cx[u] := false;
               While left < right do
                   BEGIN
                       inc(left);
                       px := queue[left];
                       for v := head[px] + 1 to head[px + 1] do
                           BEGIN
                                  if cx[adj[v]] then
                                     BEGIN
                                            cx[ adj[v] ] := false;
                                            den[u, adj[v]] := 1;
                                            inc(right);
                                            queue[right] := adj[v];
                                     END;
                           END;
                   END;
        END;

Procedure Try(i : longint);
Var j,k : longint;
    ok : boolean;
        BEGIN
                 for j := 1 to n do
                   if d[j] and (a[ x[i-1], j] = '1') then
                        BEGIN
                             ok := true;
                             for k := 1 to n do
                               if d[k] and (den[j,k] = 0) then
                                  BEGIN
                                      ok := false;
                                      break;
                                  END;
                               if ok then
                                  BEGIN
                                      d[j] := false;
                                      x[i] := j;
                                      if i = n then inc(dem)
                                      else
                                      Try(i+1);
                                      d[j] := true;
                                  END;

                        END;
        END;


BEGIN
        Assign(fi, inp); reset(fi);
        readln(fi, n);
        for i := 1 to n do
            BEGIN
                   For j := 1 to n do
                      BEGIN
                             read(fi, a[i,j]);
                             if a[i,j] = '1' then
                                     inc(head[i]);
                      END;
                   readln(fi);
            END;
        for i := 2 to n do head[i] := head[i-1] + head[i];
           for i:= 1 to n do
           for j := 1 to n do
             if a[i,j] = '1' then
                BEGIN
                        adj[ head[i] ] := j;
                        dec(head[i]);
                END;
        close(fi);
        fillchar(den, sizeof(den), 0);
        x[0] := 0;
        For i := 1 to n do den[i,i] := 1;
        for i := 1 to n do a[0,i] := '1';
        fillchar(d, sizeof(d), true);
        for i := 1 to n do BFS(i);
        Try(1);
        Assign(fo,out);rewrite(fo);
        write(fo,dem);
        close(fo);

END.
