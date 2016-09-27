Const   inp = '';
        out = '';
        maxn = 101;
        maxm = 10001;
        maxw = 99999999;

Type    canh = record
        x,y,l,t :       longint;
        end;

Var     fi,fo   :       text;
        e       :       array [1..maxm] of canh;
        d,pos   :       array [1..maxn,0..maxm] of longint;
        heapi,heapj    :       array [1..maxn*maxm] of longint;
        free    :       array [1..maxn,0..maxm] of boolean;
        n,m,k,ntest,nheap,u,ti   :       longint;
        head    :       array [1..maxn] of longint;
        adj,w,c     :       array [1..2*maxm] of longint;

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
                  swap(heapi[cha],heapi[con]);
                  swap(heapj[cha],heapj[con]);
                  pos[heapi[cha],heapj[cha]] := cha;
                  pos[heapi[con],heapj[con]] := con;
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
             swap(heapi[cha],heapi[con]);
             swap(heapj[cha],heapj[con]);
             pos[heapi[cha],heapj[cha]] := cha;
             pos[heapi[con],heapj[con]] := con;
             cha := con;
            until false;
        end;

procedure pop;
        begin
            u := heapi[1]; ti := heapj[1];
            heapi[1] := heapi[nheap]; heapj[1] := heapj[nheap];
            pos[heapi[1],heapj[1]] := 1;
            dec(nheap);
            downheap(heapi[1],heapj[1]);
        end;

procedure main;
var i,j,res,v : longint;
        begin
              for i := 2 to n do head[i] := head[i-1]+head[i];
              head[n+1] := 2*m;
              for i := 1 to m do with e[i] do
               begin
                   adj[head[x]] := y; w[head[x]] := l; c[head[x]] := t;
                   dec(head[x]);
               end;
              nheap := 0;
              fillchar(pos,sizeof(pos),0);
              fillchar(free,sizeof(free),true);
              for i := 1 to n do
               for j := 0 to k do d[i,j] := maxw;
              d[1,k] := 0;
              upheap(1,k);
              repeat
                   if nheap = 0 then break;
                   u := heapi[1]; ti := heapj[1];
                   heapi[1] := heapi[nheap]; heapj[1] := heapj[nheap];
                   pos[heapi[1],heapj[1]] := 1;
                   dec(nheap);
                   downheap(heapi[1],heapj[1]);
                   if u = n then break;
                   free[u,ti] := false;
                   for i := head[u]+1 to head[u+1] do
                    begin
                         v := adj[i];
                         if (ti - c[i] >=0) then
                          if (free[v,ti - c[i]]) and (d[v,ti-c[i]] > d[u,ti] + w[i]) then
                           begin
                               d[v,ti - c[i]] := d[u,ti] + w[i];
                               upheap(v,ti-c[i]);
                           end;
                    end;
              until false;
              res := maxw;
              for i := 0 to k do
               if d[n,i] < res then res := d[n,i];
              if res = maxw then writeln(fo,-1)
               else writeln(fo,res);
        end;

procedure input;
var i : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,ntest);
             while ntest > 0 do
              begin
                 dec(ntest);
                 readln(fi,k); readln(fi,n); readln(fi,m);
                 fillchar(head,sizeof(head),0);
                 for i := 1 to m do with e[i] do
                  begin
                      readln(fi,x,y,l,t);
                      inc(head[x]);
                  end;
                 main;
              end;
             close(fi); close(fo);
        end;

begin
     input;
end.
