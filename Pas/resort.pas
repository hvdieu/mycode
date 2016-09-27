Const   maxn = 100001;
Type    canh = record
        x,y : longint;
        end;
Var     n,dem,res,k       :       longint;
        head,sc,kq,st,a    :       array [1..maxn] of longint;
        e       :       array [1..maxn] of canh;
        free    :       array [1..maxn] of boolean;
        adj     :       array [1..2*maxn] of longint;
        hotel   :       array [1..maxn] of boolean;

procedure nhap;
var i,j : longint;
        begin
            assign(input,'resort.inp'); reset(input);
            assign(output,'resort.out'); rewrite(output);
            readln(n);
            for i := 1 to n do
             begin
                 read(j);
                 if j = 1 then hotel[i] := true;
             end;
            readln;
            for i := 1 to n do
              begin
                  read(a[i]);
                  if a[i] <> 0 then
                   begin
                       inc(head[i]);
                       inc(sc[a[i]]); inc(sc[i]);
                       inc(dem);
                       with e[dem] do
                        begin
                            x := i; y := a[i];
                        end;
                   end;
              end;
            for i := 2 to n do head[i] := head[i-1] + head[i];
            head[n+1] := head[n];
            for i := 1 to dem do with e[i] do
             begin
                 adj[head[x]] := y; dec(head[x]);
             end;
        end;

procedure dfs(u : longint);
var i,v,j : longint;
        begin
            free[u] := false;
            inc(k);
            st[k] := u;
            for i := head[u]+1 to head[u+1] do
             begin
                 v := adj[i];
                 if free[v] and (sc[v] < 3) and (hotel[v] = false) then
                  begin
                    dfs(v);
                    dec(k);
                  end;
             end;
            if k > res then
            begin
               res := k;
               for j := 1 to k do kq[j] := st[j];
            end;
        end;

procedure main;
var i,j : longint;
        begin
             for i := 1 to n do
              if hotel[i] and (sc[i] < 3) then
               begin
                   fillchar(free,sizeof(free),true);
                   k := 0;
                   dfs(i);
               end;
             writeln(res);
             for i := res downto 1 do write(kq[i],' ');
        end;

begin
    nhap;
    main;
end.
