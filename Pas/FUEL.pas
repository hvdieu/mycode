Const   maxn = 1001;
        maxm = 10001;
        maxw = 99999999;
        maxc = 100;
Type    canh = record
        x,y,l : longint;
        end;

Var     n,m,q,i,c,s,t,nheap     :       longint;
        p,head       :       array [0..maxn] of longint;
        d,pos       :    array [0..maxn,0..maxc] of longint;
        free    :    array [0..maxn,0..maxc] of boolean;
        heapi,heapj  :  array [1..maxn*maxc] of longint;
        adj,w     :    array [1..2*maxm] of longint;
        e        :    array [1..maxm] of canh;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure update(cha,con : longint);
        begin
            swap(heapi[cha],heapi[con]);
            swap(heapj[cha],heapj[con]);
            pos[heapi[cha],heapj[cha]] := cha;
            pos[heapi[con],heapj[con]] := con;
        end;

procedure upheap(i,j : longint);
var cha,con : longint;
        begin
            con := pos[i,j];
            if con = 0 then
             begin
                 inc(nheap); pos[i,j] := nheap;
                 heapi[nheap] := i; heapj[nheap] := j;
                 con := nheap;
             end;
            repeat
                cha := con div 2;
                if (cha=0) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
                update(cha,con);
                con := cha;
            until false;
        end;

procedure downheap(i,j : longint);
var cha,con : longint;
        begin
            cha := pos[i,j];
            repeat
                con := cha*2;
                if (con<nheap) and (d[heapi[con],heapj[con]] > d[heapi[con+1],heapj[con+1]]) then inc(con);
                if (con>nheap) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
                update(cha,con);
                cha := con;
            until false;
        end;

procedure pop;
        begin
            heapi[1] := heapi[nheap]; heapj[1] := heapj[nheap];
            dec(nheap); pos[heapi[1],heapj[1]] := 1;
            downheap(heapi[1],heapj[1]);
        end;

procedure main;
var i,j,u,v,k,tt,res : longint;
        begin
             for i := 0 to n-1 do
              for j := 0 to c do
               begin
                 d[i,j] := maxw;
                 free[i,j] := true; pos[i,j] := 0;
               end;
             nheap := 0;
             d[s,0] := 0; upheap(s,0);
             repeat
                  if nheap = 0 then break;
                  u := heapi[1]; k := heapj[1];
                  if u = t then break;
                  pop;
                  free[u,k] := false;
                  for i := head[u]+1 to head[u+1] do
                    begin
                        v := adj[i];
                        for tt := w[i]-k to c-k do
                         if free[v,k+tt-w[i]] and (d[v,k+tt-w[i]] > d[u,k] + p[u]*tt) then
                           begin
                               d[v,k+tt-w[i]] := d[u,k] + p[u]*tt;
                               upheap(v,k+tt-w[i]);
                           end;
                    end;
             until false;
             res := maxw;
             for k := 0 to c do
              if d[t,k] < res then res := d[t,k];
             if res = maxw then writeln('Impossible')
              else writeln(res);
        end;



begin
     assign(input,'fuel.inp'); reset(input);
     assign(output,'fuel.out'); rewrite(output);
     readln(n,m);
     for i := 0 to n-1 do read(p[i]);
     for i := 1 to m do with e[i] do
      begin
          read(x,y,l);
          inc(head[x]); inc(head[y]);
      end;
     for i := 1 to n-1 do head[i] := head[i-1] + head[i];
     head[n] := head[n-1];
     for i := 1 to m do with e[i] do
      begin
          adj[head[x]] := y; w[head[x]] := l; dec(head[x]);
          adj[head[y]] := x; w[head[y]] := l; dec(head[y]);
      end;

     readln(q);
     while q > 0 do
       begin
           read(C,s,t);
           dec(q);
           main;
       end;
end.

