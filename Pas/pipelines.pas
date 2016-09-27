Const   maxn = 10001;
        maxm = 50001;
        maxw = 99999999;

Type    canh = record
        x,y,l   :       longint;
        end;

Var     m,n,k,nheap,u,s   :       longint;
        head    :       array [1..maxn] of longint;
        adj,w     :       array [1..2*maxm] of longint;
        heapi,heapj    : array [1..maxn*20] of longint;
        d,pos       : array [1..maxn,0..20] of longint;
        free    : array [1..maxn,0..20] of boolean;
        e       :       array [1..maxm] of canh;

procedure nhap;
var i,j : longint;
        begin
            assign(input,'PIPELINES.INP'); reset(input);
            assign(output,'PIPELINES.OUT'); rewrite(output);
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
                 inc(nheap); heapi[nheap] := i; heapj[nheap] := j;
                 pos[i,j] := nheap; con := nheap;
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
                 con := cha * 2;
                 if (con<nheap) and (d[heapi[con],heapj[con]] > d[heapi[con+1],heapj[con+1]]) then inc(con);
                 if (con>nheap) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
                 update(cha,con);
                 cha := con;
            until false;
        end;

procedure pop;
        begin
            u := heapi[1]; s := heapj[1];
            heapi[1] := heapi[nheap]; heapj[1] := heapj[nheap];
            pos[heapi[1],heapj[1]] := 1;
            dec(nheap);
            downheap(heapi[1],heapj[1]);
        end;

procedure dij;
var i,j,v,t,res     :       longint;
        begin
             fillchar(free,sizeof(free),true);
             for i := 1 to n do
              for j := 0 to k do
               d[i,j] := maxw;
             d[1,k] := 0;
             upheap(1,k);

             repeat
                   if nheap = 0 then break;
                   pop;
                   if (u=n) then
                    begin
                        res := d[u,s];
                        break;
                    end;
                   for i := head[u]+1 to head[u+1] do
                    begin
                       v := adj[i];
                       if free[v,s] and (d[v,s] > d[u,s] + w[i]) then
                        begin
                            d[v,s] := d[u,s] + w[i];
                            upheap(v,s);
                        end;
                       if (s > 0) and free[v,s-1] and (d[v,s-1] > d[u,s]) then
                        begin
                            d[v,s-1] := d[u,s];
                            upheap(v,s-1);
                        end;
                    end;
             until false;
             write(res);
        end;

begin
    nhap;
    dij;
end.

