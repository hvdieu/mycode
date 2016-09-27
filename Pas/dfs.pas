Const   inp = 'dfs.inp';
        out = 'dfs.out';
        maxn = 301;
Var     fi,fo   :       text;
        st      :       array [1..2*maxn] of longint;
        pos,dem,a     :       array [1..maxn] of longint;
        f       :       array [0..maxn,0..maxn] of boolean;
        top,n,l,res :       longint;

procedure main;
var i,j,u : longint;
        begin
            assign(fi,inp); reset(fi);
            assign(fo,out); rewrite(fo);
            readln(fi,n,l);
            for i := 1 to l do
              begin
                   readln(fi,a[i]);
                   inc(dem[a[i]]);
              end;
            for i := 1 to l do
              begin
                   u := a[i];
                   dec(dem[u]);
                   if pos[u] = 0 then
                     begin
                         inc(top);
                         st[top] := u;
                         pos[u] := top;
                         if top > 1 then
                         begin
                            inc(res);
                            f[st[top-1],st[top]] := true;
                         end;
                         if dem[u] = 0 then
                         begin
                            dec(top);
                            pos[u] := 0;
                         end;
                     end
                   else
                     begin
                          while top <> pos[u] do
                            begin
                                pos[st[top]] := 0;
                                dec(top);
                            end;
                          if dem[u] = 0 then
                           begin
                             dec(top);
                             pos[u] := 0;
                           end;
                     end;
              end;
            writeln(fo,res);
            for i := 1 to n do
              for j := 1 to n do
               if f[i,j] then writeln(fo,i,' ',j);
            close(fi); close(fo);
        end;

begin
     main;
end.

