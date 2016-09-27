{$H+}
Uses math;
Const   maxn = 15001;
Var     n,m,x,dem,c,i,kq1,kq2     :       longint;
        head,ncon,con1,con2    :       array [1..maxn] of longint;
        f,g       :       array [1..maxn,0..2] of longint;
        s      :       string;

procedure init(u : longint);
        begin
             inc(i);
             val(s[i],x);
             if x = 1 then
               begin
                   inc(dem);
                   ncon[u] :=1 ;
                   con1[u] := dem;
                   init(dem);
               end;
             if x = 2 then
               begin
                   ncon[u] := 2;
                   inc(dem); con1[u] := dem;
                   init(dem);
                   inc(dem);
                   con2[u] := dem;
                   init(dem);
               end;
        end;

procedure dfs(u : longint);
var j : longint;
        begin
            f[u,0] := 1; g[u,0] := 1;
            if con1[u] <> 0 then dfs(con1[u]);
            if con2[u] <> 0 then dfs(con2[u]);
            if ncon[u] > 0 then
             begin
                 if ncon[u] = 1 then
                   begin
                       f[u,0] := max(f[con1[u],1]+1,f[con1[u],2]+1);
                       f[u,1] := max(f[con1[u],0],f[con1[u],2]);
                       f[u,2] := max(f[con1[u],0],f[con1[u],1]);
                       g[u,0] := min(g[con1[u],1]+1,g[con1[u],2]+1);
                       g[u,1] := min(g[con1[u],0],g[con1[u],2]);
                       g[u,2] := min(g[con1[u],0],g[con1[u],1]);
                   end;
                 if ncon[u] = 2 then
                   begin
                       f[u,0] := max(f[con1[u],1]+f[con2[u],2]+1,f[con1[u],2]+f[con2[u],1]+1);
                       f[u,1] := max(f[con1[u],0]+f[con2[u],2],f[con1[u],2]+f[con2[u],0]);
                       f[u,2] := max(f[con1[u],0]+f[con2[u],1],f[con1[u],1]+f[con2[u],0]);
                       g[u,0] := min(g[con1[u],1]+g[con2[u],2]+1,g[con1[u],2]+g[con2[u],1]+1);
                       g[u,1] := min(g[con1[u],0]+g[con2[u],2],g[con1[u],2]+g[con2[u],0]);
                       g[u,2] := min(g[con1[u],0]+g[con2[u],1],g[con1[u],1]+g[con2[u],0]);
                   end;
             end;
        end;

procedure main;
var j : longint;
        begin
             dem := 1; i := 0;
             init(1);
             dfs(1);
             kq1 := 0; kq2 := maxlongint;
             for i := 0 to 2 do
               begin
                   kq1 := max(kq1,f[1,i]);
                   kq2 := min(kq2,g[1,i]);
               end;
             write(kq1,' ',kq2);
        end;

begin
      assign(input,'TRO.INP'); reset(input);
      assign(output,'TRO.OUT'); rewrite(output);
      readln(s);
      main;

end.