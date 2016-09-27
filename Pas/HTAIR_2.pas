Const   maxn = 100001;
        maxm = 10000001;

Var     n,m,i,k,a,b,c,dem,nheap   :       longint;
        head,heap,pos    :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        d       :    array [1..maxn] of int64;
        ke,next    :       array [1..maxm] of longint;
        w       :     array [1..maxm] of int64;
        maxw    :     int64;

procedure add1(a,b,c : longint);
        begin
            inc(dem); ke[dem] := b; next[dem] := head[a];
            w[dem] := c;
            head[a] := dem;
        end;

procedure add2(a,b,c : longint);
var j,v : longint;
        begin
            j := head[a];
            while j <> 0 do
              begin
                  v := ke[j];
                  inc(dem); ke[dem] := v; next[dem] := head[b];
                  w[dem] := w[j] + c;
                  head[b] := dem;
                  j := next[j];
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
                   inc(nheap); heap[nheap] := i;
                   pos[i] := nheap; con := nheap;
               end;

             repeat
                 cha := con div 2;
                 if (cha=0) or (d[heap[cha]] <= d[heap[con]]) then break;
                 swap(heap[cha],heap[con]);
                 pos[heap[cha]] := cha; pos[heap[con]] :=con;
                 con := cha;
             until false;
        end;

function pop : longint;
var cha,con : longint;
        begin
             pop := heap[1]; heap[1] := heap[nheap]; pos[heap[1]] := 1;
             dec(nheap);
             cha := heap[1];

             repeat
                 con := cha*2;
                 if (con<nheap) and (d[heap[con]] > d[heap[con+1]]) then inc(con);
                 if (con>nheap) or (d[heap[cha]] <= d[heap[con]]) then break;
                 swap(heap[cha],heap[con]);
                 pos[heap[cha]] := cha; pos[heap[con]] :=con;
                 con := cha;
             until false;
        end;

procedure main;
var i,j,u,v : longint;
    temp : int64;
    ok : boolean;
        begin
             fillchar(free,sizeof(free),true);
             maxw := 1 shl 50;
             for i := 1 to n do d[i] := maxw;
             d[1] := 0; upheap(1);
             repeat
                if nheap = 0 then break;
                u := pop;
                free[u] := false;
                j := head[u];
                while j <> 0 do
                  begin
                      v := ke[j];
                      if free[v] and (d[v] > d[u] + w[j]) then
                        d[v] := d[u] + w[j];
                      j := next[j];
                  end;
                j := head[u];
                while j <> 0 do
                  begin
                      v := ke[j];
                      if free[v] then upheap(v);
                      j := next[j];
                  end;
             until false;
             for i := 2 to n do
              if d[i] = maxw then writeln(-1)
               else writeln(d[i]);
        end;


begin
      assign(input,'HTAIR.INP'); reset(input);
      assign(output,'HTAIR.OUT'); rewrite(output);
      readln(n,m);
      for i := 1 to m do
        begin
             readln(k,a,b,c);
             if k = 1 then add1(a,b,c)
              else add2(a,b,c);
        end;
     main;
end.