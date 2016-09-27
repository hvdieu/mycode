uses math;
Const   maxn = 100015;
        inf = 1000000007;
Type    nut = record
        t1,t2,vt : longint;
        end;
        canh = record
        x,y : longint;
        end;
Var     n,q,dem,k     :       longint;
        a,num,pos,head,adj,con       :       array [0..maxn] of longint;
        free    :   array [0..maxn] of boolean;
        e       :       array [1..maxn] of canh;
        t       :       array [1..4*maxn] of nut;
        f       :       array [1..4*maxn] of longint;
        ok      :       boolean;

procedure nhap;
var i,p : longint;
        begin
          //  assign(input,'0.in'); reset(input);
          //  assign(output,'cook.out'); rewrite(output);
            readln(n);
            for i := 1 to n do
             begin
                 read(a[i],p);
                 with e[i] do
                  begin
                      x := p; y := i;
                      inc(head[x]);
                  end;
             end;
            for i := 1 to n do head[i] := head[i-1] + head[i];
            head[n+1] := head[n];
            for i := 1 to n do with e[i] do
             begin
                 adj[head[x]] := y; dec(head[x]);
             end;
        end;

procedure dfs(u : longint);
var i,v : longint;
        begin
             inc(dem); num[u] := dem;
             pos[num[u]] := u;
             for i := head[u]+1 to head[u+1] do
               begin
                   v := adj[i];
                   if free[v] then
                    begin
                        free[v] := false;
                        dfs(v);
                        con[u] := con[u] + con[v];
                    end;
             end;
        end;

procedure down(i,con1,con2 : longint);
        begin
            inc(f[con1],f[i]);
            inc(f[con2],f[i]);
            inc(t[con1].t1,f[i]);
            inc(t[con2].t1,f[i]);
            f[i] := 0;
        end;

procedure khoitao;
var i : longint;
        begin
            fillchar(free,sizeof(free),true);
            free[0] := false;
            for i := 0 to n do con[i] := 1;
            dem := -1;
        end;

procedure gan(i,lo,hi,u,x : longint);
var con1,con2,mid : longint;
        begin
             if (lo > u) or (hi < u) then exit;
             if (lo=u) and (hi=u) then
              begin
                  if (t[i].t1 <= 0) and ok then t[i].t2 := 1;
                  t[i].t1 := x;
                  t[i].vt := u;
                  exit;
              end;
             mid := (lo+hi) shr 1;
             con1 := i*2; con2 := con1 + 1;
             down(i,con1,con2);
             gan(con1,lo,mid,u,x); gan(con2,mid+1,hi,u,x);
             if t[con1].t1 < t[con2].t1 then
               begin
                   t[i].t1 := t[con1].t1;
                   t[i].vt := t[con1].vt;
               end
             else begin
                      t[i].t1 := t[con2].t1;
                      t[i].vt := t[con2].vt;
                  end;
             t[i].t2 := t[con1].t2 + t[con2].t2;
        end;

procedure update(i,lo,hi,u,v,x : longint);
var mid,con1,con2 : longint;
        begin
             if u > v then exit;
             if (lo=u) and (hi=v) then
              begin
                  inc(f[i],x);
                  inc(t[i].t1,x);
                  exit;
              end;
             mid := (lo+hi) shr 1;
             con1 := i*2; con2 := con1 + 1;
             down(i,con1,con2);
             if u <= mid then update(con1,lo,mid,u,min(mid,v),x);
             if v > mid then update(con2,mid+1,hi,max(mid+1,u),v,x);
             if t[con1].t1 < t[con2].t1 then
               begin
                   t[i].t1 := t[con1].t1;
                   t[i].vt := t[con1].vt;
               end
             else begin
                      t[i].t1 := t[con2].t1;
                      t[i].vt := t[con2].vt;
                  end;
        end;

procedure xet;
var con1,con2,mid : longint;
        begin
            while t[1].t1 <= 0 do
              begin
                   gan(1,0,n,t[1].vt,maxlongint);
              end;
        end;

function truyvan(i,lo,hi,u,v : longint) : longint;
var mid,con1,con2 : longint;
        begin
              if (lo >= u) and (hi <= v) then exit(t[i].t2);
              if (lo > v) or (hi < u) then exit(0);
              mid := (lo+hi) shr 1;
              con1 := i*2; con2 := i*2+1;
              exit(truyvan(con1,lo,mid,u,v) + truyvan(con2,mid+1,hi,u,v));
        end;

procedure main;
var i,u,st,kind,x,res : longint;
        begin
            khoitao;
            dfs(0);
            a[0] := inf;
            for u := 0 to n do
              gan(1,0,n,u,a[pos[u]]);
            ok := true;
            readln(q);
            for st := 1 to q do
              begin
                   read(kind);
                   xet;
                   if kind = 1 then
                     begin
                         read(u,x);
                         update(1,0,n,num[u]+1,num[u]+con[u]-1,-x);
                     end
                   else
                     begin
                         read(u);
                         res := truyvan(1,0,n,num[u]+1,num[u]+con[u]-1);
                         res := num[u]+con[u]-1-(num[u]+1)+1 - res;
                         writeln(res);
                         if res = 540 then k := u;
                     end;
              end;
        end;

begin
     nhap;
     main;
end.

