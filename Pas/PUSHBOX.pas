Const   maxn = 10001;
        maxm = 50001;

Type    canh = record
        x,y     :       longint;
        end;

Var     n,m,i,u,v,top,left,right,k     :       longint;
        head,queue,trace,d,st    :       array [1..maxn] of longint;
        ke,next :       array [1..maxm] of longint;
        hop,free     :       array [1..maxn] of boolean;
        res     :       int64;

procedure bfs;
var i,j,u,v : longint;
        begin
            left := 0; right := 1;
            fillchar(free,sizeof(free),true);
            queue[1] := 1; free[1] := false;
            trace[1] := 1;
            while left < right do
              begin
                   inc(left); u := queue[left];
                   j := head[u];
                   while j <> 0 do
                    begin
                        v := ke[j];
                        if free[v] then
                          begin
                              free[v] := false;
                              inc(right); queue[right] := v;
                              d[v] := d[u]+1;
                              trace[v] := u;
                              if hop[v] then
                                begin
                                    inc(res,d[v]);
                                    inc(top); st[top] := v;
                                end;
                          end;
                        j := next[j];
                    end;
              end;
        end;

procedure truyvet(u : longint);
var v : longint;
        begin
              v := trace[u];
              repeat
                 writeln(u,' ',v);
                 u := v;
                 v := trace[u];
              until u = 1;
        end;

procedure main;
var i,j : longint;
        begin
             bfs;
             writeln(res);
             for i := 1 to top do truyvet(st[i]);
        end;

begin
     assign(input,'pushbox.inp'); reset(input);
     assign(output,'pushbox.out'); rewrite(output);
     readln(n,m,k);
     for i := 1 to k do
      begin
          read(u); hop[u] := true;
      end;
     for i := 1 to m do
       begin
           read(u,v);
           ke[i] := u; next[i] := head[v]; head[v] := i;
       end;
     main;
end.

