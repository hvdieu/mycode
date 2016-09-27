Uses math;

Const   maxn = 500001;

Type    canh = record
        x,y : longint;
        end;

Var     head,num,con        :       array [1..maxn] of longint;
        adj     :       array [1..2*maxn] of longint;
        e       :       array [1..maxn] of canh;
        t1,t2,b1               :       array [1..4*maxn] of longint;
        free              :       array [1..maxn] of boolean;
        n,q,i,dem,kind,u,tden,ttrang               :       longint;
        res,time     :       longint;

procedure dfs(u : longint);
var i : longint;
        begin
             free[u] := false; inc(dem); num[u] := dem;
             for i := head[u]+1 to head[u+1] do
              if free[adj[i]] then
               begin
                   dfs(adj[i]);
                   con[u] := con[u] + con[adj[i]];
               end;
        end;

procedure down1(i,con1,con2 : longint);
        begin
          if b1[i] <> 0 then
            begin
                t1[con1] := b1[i]; t1[con2] := b1[i];
                b1[con1] := b1[i]; b1[con2] := b1[i];
                b1[i] := 0;
            end;
        end;

procedure den(i,lo,hi,u,v,x : longint);
var mid,con1,con2 : longint;
        begin
             if (lo = u) and (v = hi) then
               begin
                   b1[i] := x;
                   t1[i] := x;
                   exit;
               end;
             mid := (lo+hi) shr 1; con1 := i*2; con2 := i*2+1;
             down1(i,con1,con2);
             if u <= mid then den(i*2,lo,mid,u,min(mid,v),x);
             if v > mid then den(i*2+1,mid+1,hi,max(mid+1,u),v,x);
        end;

procedure trang(i,lo,hi,u,x : longint);
var mid,con1,con2 : longint;
        begin
            if (u > hi) or (u < lo) then exit;
            if (lo=u) and (hi=u) then
              begin
                  t2[i] := x;
                  exit;
              end;
            mid := (lo+hi) shr 1; con1 := i*2; con2 := i*2+1;
            trang(i*2,lo,mid,u,x); trang(i*2+1,mid+1,hi,u,x);
            t2[i] := max(t2[con1],t2[con2]);
        end;

function qrtrang(i,lo,hi,u,v : longint) : longint;
var mid,con1,con2 : longint;
        begin
            if (lo > v) or (hi < u) then exit(-maxlongint);
            if (u <= lo) and (hi <= v) then exit(t2[i]);
            mid := (lo+hi) shr 1; con1 := i*2; con2 := i*2+1;
            exit(max( qrtrang(con1,lo,mid,u,v), qrtrang(con2,mid+1,hi,u,v)));
        end;

procedure qrden(i,lo,hi,u : longint);
var mid : longint;
        begin
            if (lo > u) or (hi < u) then exit;
            if (u=lo) and (u=hi) then
              begin
                  tden := t1[i];
                  exit;
              end;
            mid := (lo+hi) shr 1;
            down1(i,i*2,i*2+1);
            qrden(i*2,lo,mid,u); qrden(i*2+1,mid+1,hi,u);
        end;

begin
    // assign(input,'asd.inp'); reset(input);
    // assign(output,'asd.out'); rewrite(output);
     readln(n);
     for i := 1 to n-1 do with e[i] do
      begin
          read(x,y);
          inc(head[x]); inc(head[y]);
      end;
     for i := 2 to n do head[i] := head[i-1] + head[i];
     head[n+1] := head[n];
     for i := 1 to n-1 do with e[i] do
      begin
         adj[head[x]] := y; dec(head[x]); adj[head[y]] := x; dec(head[y]);
      end;
     fillchar(free,sizeof(free),true);
     for i := 1 to n do con[i] := 1;
     dfs(1);
     readln(q);
     while q > 0 do
       begin
           read(kind,u);
           dec(q);
           inc(time);
           res := maxlongint;
           if kind = 1 then den(1,1,n,num[u],num[u]+con[u]-1,time);
           if kind = 2 then trang(1,1,n,num[u],time);
           if kind = 3 then
             begin
                  ttrang := qrtrang(1,1,n,num[u],num[u]+con[u]-1);
                  qrden(1,1,n,num[u]);
                  if ttrang >= tden then writeln(0)
                   else writeln(1);
             end;
       end;
end.

