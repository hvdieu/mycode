{$H+}
Const   maxn = 3001;
Type    arr = array [1..maxn] of longint;
        canh = record
        x,y : longint;
        end;
Var     t,n,top,m       :       longint;
        a,b     :       string;
        e       :       array [1..maxn] of canh;
        free    :       array [1..maxn] of boolean;
        adj     :       array [1..2*maxn] of longint;
        f1,f2,st,head   :       arr;

procedure tao(s : string);
var i,j : longint;
        begin
            n := 1; top := 1; st[1] := 1;
            m := 0;
            fillchar(head,sizeof(head),0);
            for i := 1 to length(s) do
              begin
                  if s[i] = '0' then
                    begin
                        inc(n); inc(top);
                        st[top] := n;
                        inc(m); with e[m] do
                          begin
                              x := st[top-1];
                              y := st[top];
                              inc(head[x]); inc(head[y]);
                          end;
                    end
                  else dec(top);
              end;
            for i := 2 to n do head[i] := head[i-1] + head[i];
            head[n+1] := head[n];
            for i := 1 to m do with e[i] do
              begin
                  adj[head[x]] := y; dec(head[x]);
                  adj[head[y]] := x; dec(head[y]);
              end;
        end;

procedure dfs(u : longint; var f : arr);
var i,v : longint;
        begin
            free[u] := false; f[u] := 1;
            for i := head[u]+1 to head[u+1] do
             begin
                 v := adj[i];
                 if free[v] then
                   begin
                       dfs(v,f);
                       f[u] := f[u] + f[v];
                   end;
             end;
        end;


function check : boolean;
var i,j : longint;
        begin
            tao(a);
            fillchar(free,sizeof(free),true);
            dfs(1,f1);
            tao(b);
            fillchar(free,sizeof(free),true);
            dfs(1,f2);
            sort(1,n,f1); sort(1,n,f2);
            for i := 1 to n do
             if f1[i] <> f2[i] then exit(false);
            exit(true);
        end;

begin
    assign(input,'subway.in'); reset(input);
    assign(output,'subway.out'); rewrite(output);
    readln(t);
    while t > 0 do
      begin
          dec(t);
          readln(a); readln(b);
          if check then writeln('same')
           else writeln('different');
      end;
end.
