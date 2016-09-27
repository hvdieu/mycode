Const   maxn = 200001;
        maxm = 500001;
        maxw = 999999999;
Var     n,m,x,y,l,nheap,i     :       longint;
        head    :       array [1..maxn] of longint;
        d,pos       :       array [1..maxn,0..1] of longint;
        free    :   array [1..maxn,0..1] of boolean;
        heapi,heapj :       array [1..2*maxn] of longint;
        ke,w,next    :       array [-maxm..maxm] of longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
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
                 swap(heapi[cha],heapi[con]); swap(heapj[cha],heapj[con]);
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
                 swap(heapi[cha],heapi[con]); swap(heapj[cha],heapj[con]);
                 pos[heapi[cha],heapj[cha]] := cha;
                 pos[heapi[con],heapj[con]] := con;
                cha := con;
             until false;
        end;

procedure pop;
        begin
               heapi[1] := heapi[nheap]; heapj[1] := heapj[nheap];
               pos[heapi[1],heapj[1]] := 1; dec(nheap);
               downheap(heapi[1],heapj[1]);
        end;

procedure dij;
var i,j,u,v,u1,v1 : longint;
        begin
            fillchar(free,sizeof(free),true);
            for i := 1 to n do
             for j := 0 to 1 do d[i,j] := maxw;

            d[1,0] := 0;
            upheap(1,0);
            repeat
               if nheap = 0 then break;
               u := heapi[1]; v := heapj[1]; free[u,v] := false;
               pop;
               j := head[u];
               while j <> 0 do
                 begin
                     u1 := ke[j]; v1 := (d[u,v] + w[j]) mod 2;
                     if free[u1,v1] and (d[u,v] + w[j] < d[u1,v1]) then
                       begin
                           d[u1,v1] := d[u,v] + w[j];
                           upheap(u1,v1);
                       end;
                     j := next[j];
                 end;
            until false;
            if d[n,1] = maxw then writeln(0)
             else writeln(d[n,1]);
        end;

begin
      assign(input,'bug.inp'); reset(input);
      assign(output,'bug.out'); rewrite(output);
      readln(n,m);
      for i := 1 to m do
        begin
            readln(x,y,l);
            ke[i] := y; ke[-i] := x; w[i] := l; w[-i] := l;
            next[i] := head[x]; next[-i] := head[y];
            head[x] := i; head[y] := -i;
        end;
      Dij;
end.
