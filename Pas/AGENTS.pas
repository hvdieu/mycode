Const   maxn = 251;
Type    canh = record
        x,y : longint;
        end;
Var     m,n,i,s,t,oo,res     :       longint;
        head    :       array [1..maxn] of longint;
        e       :       array [1..maxn*maxn] of canh;
        free    :       array [1..maxn,1..maxn] of boolean;
        adj,q1,q2,d     :       array [1..maxn*maxn] of longint;

procedure nhap;
var i : longint;
        begin
            assign(input,'AGENTS.INP'); reset(input);
            assign(output,'AGENTS.OUT'); rewrite(output);
            readln(n,m);
            readln(s,t);
            for i := 1 to m do with e[i] do
              begin
                  readln(x,y);
                  inc(head[x]);
              end;
            for i := 2 to n do head[i] := head[i-1] + head[i];
            head[n+1] := head[n];
            for i := 1 to m do with e[i] do
              begin
                  adj[head[x]] := y; dec(head[x]);
              end;
        end;

procedure bfs;
var left,right,u,v,x,y,j : longint;
        begin
            left := 0;
            right := 1; q1[1] := s; q2[1] := t;
            oo := maxn*maxn;
            fillchar(free,sizeof(free),true);
            free[s,t] := false;
            while left < right do
              begin
                   inc(left); u := q1[left]; v := q2[left];
                   for i := head[u]+1 to head[u+1] do
                    for j := head[v]+1 to head[v+1] do
                      begin
                          x := adj[i]; y := adj[j];
                          if free[x,y] then
                            begin
                                inc(right);
                                q1[right] := x; q2[right] := y;
                                d[right] := d[left]+1;
                                free[x,y] := false;
                                if x = y then
                                 begin
                                     res := d[right];
                                     exit;
                                 end;
                            end;
                      end;
              end;
        end;

begin
     nhap;
     res := -1;
	 bfs;
     write(res);
end.
