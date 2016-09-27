Const   inp = '';
        out = '';
        maxn = 10001;
        maxm = 200001;
Type    canh = record
        x,y     :       longint;
        end;
Var     fi,fo   :       text;
        n,m     :       longint;
        e       :       array [1..maxm] of canh;
        head    :       array [1..maxn] of longint;
        adj     :       array [1..2*maxm] of longint;

procedure input;
var i : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n,m);
             for i := 1 to m do
              with e[i] do
               begin
                    readln(fi,x,y);
                    inc(head[x]); inc(head[y]);
               end;

             for i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := 2*m;
             for i := 1 to m do
              with e[i] do
                begin
                     adj[head[x]] := y; dec(head[x]);
                     adj[head[y]] := x; dec(head[y]);
                end;
        end;

procedure main;
var i,j,k,t,i1,i2,i3,i4,dem : longint;
        begin
              for i := 1 to n do
               begin
                    for i1 := head[i]+1 to head[i+1]-1 do
                     for i2 := i1+1 to head[i+1] do
                       begin
                            j := adj[i1]; t := adj[i2];
                            dem := 0;
                            for i3 := head[j]+1 to head[j+1] do
                              for i4 := head[t]+1 to head[t+1] do
                               if adj[i3] = adj[i4] then
                                 begin
                                      inc(dem);
                                      if adj[i3] <> i then k := adj[i3];
                                 end;
                            if dem >= 2 then
                              begin
                                   write(fo,i,' ',j,' ',k,' ',t);
                                   close(fi); close(fo);
                                   halt;
                              end;
                       end;
               end;
              writeln(fo,-1);
              close(fi); close(fo);
        end;

begin
      input;
      main;
end.
