uses math;
Const   maxn = 1001;
        maxm = 100001;
        maxw = 999999999;
Type    canh = record
        x,y,l   :       longint;
        end;

Var     m,n,k   :       longint;
        head    :       array [1..maxn] of longint;
        adj,w     :       array [1..2*maxm] of longint;
        d       : array [1..maxn,0..10] of double;
        free    : array [1..maxn,0..10] of boolean;
        e       :       array [1..maxm] of canh;

procedure nhap;
var i,j : longint;
        begin
        //    assign(input,'netaccel.inp'); reset(input);
        //    assign(output,'netaccel.out'); rewrite(output);
            readln(n,m,k);
            for i := 1 to m do
             with e[i] do
               begin
                   readln(x,y,l);
                   inc(head[x]); inc(head[y]);
               end;

            for i := 2 to n do head[i] := head[i-1] + head[i];
            head[n+1] := 2*m;
            for i := 1 to m do with e[i] do
              begin
                  adj[head[x]] := y; w[head[x]] := l; dec(head[x]);
                  adj[head[y]] := x; w[head[y]] := l; dec(head[y]);
              end;
        end;

procedure dij;
var i,j,u,v,s : longint;
    gt : double;
        begin
             fillchar(free,sizeof(free),true);
             for i := 1 to n do
              for j := 0 to k do d[i,j] := maxw;
             d[1,k] := 0;
             repeat
                 gt := maxlongint;
                 for i := 1 to n do
                  for j := 0 to k do
                   if free[i,j] and (d[i,j] < gt) then
                    begin
                        u := i; s := j;
                        gt := d[i,j];
                    end;

                 if ((u = n) and (s = 0)) or (gt = maxlongint) then break;
                 free[u,s] := false;
                 for i := head[u]+1 to head[u+1] do
                   begin
                       v := adj[i];
                       for j := 0 to s do
                         if free[v,s-j] and
                          (d[v,s-j] > d[u,s] + (w[i] / (1 shl j))) then
                              d[v,s-j] := d[u,s] + w[i] / (1 shl j);

                   end;
             until false;
             write(d[n,0]:0:2);
        end;

begin
    nhap;
    dij;
end.
