Const   inp = 'sum1a.in';
        out = 'sum.out';
        maxn = 5001;
        maxa = 50000;
        maxm = 10000;
        maxw = 999999999;
Type    canh = record
        x,y,l  :     longint;
        end;
Var     fi,fo  :    text;
        n,m,dem,nheap    :    longint;
        a      :    array [1..maxn] of longint;
        head,d,pos,heap      :    array [0..maxa] of longint;
        free                 :    array [0..maxa] of boolean;
        adj,w         :    array [1..maxm] of longint;
        e           :    array [1..maxm] of canh;

procedure input;
var i,j : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n);
             for i := 1 to n do readln(fi,a[i]);
        end;

procedure init;
var i,j,u,v,k : longint;
        begin
             for i := 2 to n do
               begin
                   k := a[i] mod a[1];
                   if k = 0 then k := a[1];
                   u := 0;
                   repeat
                       v := u + k;
                       if v < a[1] then
                        begin
                            inc(dem);
                            with e[dem] do
                              begin
                                  x := u; y := v;
                                  inc(head[x]);
                                  l := a[i];
                              end;
                        end
                       else break;
                       inc(u);
                   until false;
               end;
             for i := 1 to a[1]-1 do head[i] := head[i-1] + head[i];
             head[a[1]] := dem;
             for i := 1 to dem do
               with e[i] do
                 begin
                     adj[head[x]] := y; w[head[x]] := l;
                     dec(head[x]);
                 end;
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
             temp := xx; xx := yy; yy := temp;
        end;

procedure upheap(i : longint);
var cha,con : longint;
        begin
             con := pos[i];
             if con = 0 then
              begin
                  inc(nheap); heap[nheap] := 0;
                  pos[i] := nheap; con := nheap;
              end;
             repeat
                   cha := con div 2;
                   if (cha=0) or (d[heap[cha]] <= d[heap[con]]) then break;
                   swap(heap[cha],heap[con]);
                   pos[heap[cha]] := cha; pos[heap[con]] := con;
                   con := cha;
             until false;
        end;

procedure downheap(i : longint);
var cha,con : longint;
        begin
             cha := pos[i];
             repeat
                   con := cha shr 1;
                   if (con<nheap) and (d[heap[con]] > d[heap[con+1]]) then inc(con);
                   if (con>nheap) or (d[heap[cha]] <= d[heap[con]]) then break;
                   swap(heap[cha],heap[con]);
                   pos[heap[cha]] := cha; pos[heap[con]] := con;
                   cha := con;
             until false;
        end;

function pop : longint;
         begin
              pop := heap[1];
              heap[1] := heap[nheap];
              pos[heap[1]] := 1;
              dec(nheap);
              downheap(heap[1]);
         end;

procedure Dij;
var u,v,i,st : longint;
        begin
             upheap(0);
             fillchar(free,sizeof(free),true);
             for i := 1 to a[1]-1 do d[i] := maxw;
             for st := 0 to a[1]-1 do
               begin
                   u := pop;
                   free[u] := false;
                   for i := head[u]+1 to head[u+1] do
                     begin
                         v := adj[i];
                         if free[v] and (d[v] > d[u] + w[i]) then
                          begin
                              d[v] := d[u] + w[i];
                              upheap(v);
                          end;
                     end;
               end;

        end;

procedure main;
var i,k,t : longint;
        begin
              d[0] := 0;
              init;
              Dij;
              readln(fi,m);
              for i := 1 to m do
                begin
                     readln(fi,t);
                     k := t mod a[1];
                     if t < d[k] then writeln(fo,'NIE')
                      else writeln(fo,'TAK');
                end;
              close(fi); close(fo);
        end;

begin
     input;
     main;
end.
