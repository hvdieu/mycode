Const   inp = '';
        out = '';
        maxn = 500100;
Var     fi,fo   :       text;
        d       :       array [-1..maxn,0..1] of longint;
        g,f       :       array [0..maxn] of longint;
        count,m,n,res       :       longint;

procedure input;
var i,j,k,s,t : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n,m);
             for i := 1 to n do
               begin
                    read(fi,k);
                    t := 0;
                    for j := 1 to k do
                      begin
                          read(fi,s);
                          if d[t,s] <> 0 then t := d[t,s]
                          else begin
                                   inc(count);
                                   d[t,s] := count;
                                   t := count;
                               end;
                      end;
                    inc(g[t]);
               end;
        end;

procedure dfs(u : longint);
var i,v : longint;
        begin
             if f[u] <> 0 then exit;
             f[u] := g[u];
             for i := 0 to 1 do
                if d[u,i] <> 0 then
                  begin
                      v := d[u,i];
                      dfs(v);
                      f[u] := f[u] + f[v];
                  end;
        end;

Procedure main;
var i,j,st,k,t,s : longint;
        begin
            for st := 1 to m do
              begin
                   read(fi,k);
                   t := 0;
                   res := 0;
                   for i := 1 to k do
                     begin
                          read(fi,s);
                          if d[t,s] <> 0 then
                            begin
                                 t := d[t,s];
                                 if i < k then
                                 res := res + g[t];
                            end
                          else t := -1;
                     end;
                   if t <> -1 then
                     begin
                       dfs(t);
                       res := res + f[t];
                     end;
                   writeln(fo,res);

              end;
            close(fi); close(fo);
        end;

begin
      input;
      main;
end.

