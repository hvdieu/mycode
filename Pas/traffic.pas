Const   maxn = 301;
        maxm = 14001;
        maxw = 999999999;
Var     n,m,s,t,u,v,l,res,nheap     :       longint;
        du      :       array [1..maxn,0..1] of longint;
        free    :   array [1..maxn] of boolean;
        head,d,heap,pos,r,c    :       array [1..maxn] of longint;
        ke,next,w :       array [-maxm..maxm] of longint;
        ch      :       char;

function mau(i,t : longint) : longint;
var x : longint;
        begin
              if t <= r[i] then exit(c[i]);
              x := (t-r[i]) mod (du[i,0] + du[i,1]);
              if (x <= du[i,1-c[i]]) and (x > 0) then exit(1-c[i])
               else exit(c[i]);
        end;

procedure nhap;
var i,j : longint;
        begin
             assign(input,'TRAFFIC.INP'); reset(input);
             assign(output,'TRAFFIC.OUT'); rewrite(output);
             readln(s,t);
             readln(n,m);
             for i := 1 to n do
               begin
                   readln(ch,r[i],du[i,0],du[i,1]);
                   if ch = 'B' then c[i] := 0
                    else c[i] := 1;
               end;
             for i := 1 to m do
               begin
                   readln(u,v,l);
                   ke[i] := v; w[i] := l; next[i] := head[u]; head[u] := i;
                   ke[-i] := u; w[-i] := l; next[-i] := head[v]; head[v] := -i;
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
                   inc(nheap); heap[nheap] := i; pos[i] := nheap;
                   con := nheap;
               end;

             repeat
                  cha := con div 2;
                  if (cha=0) or (d[heap[cha]] <= d[heap[con]]) then break;
                  swap(heap[cha],heap[con]);
                  pos[heap[cha]] := cha; pos[heap[con]] := con;
                  con := cha;
             until false;
        end;

function pop : longint;
var cha,con : longint;
        begin
             pop := heap[1]; heap[1] := heap[nheap];
             pos[heap[1]] := 1; dec(nheap); cha := 1;
             repeat
                 con := cha*2;
                 if (con < nheap) and (d[heap[con]] > d[heap[con+1]]) then inc(con);
                 if (con > nheap) or (d[heap[cha]] <= d[heap[con]]) then break;
                 swap(heap[cha],heap[con]);
                 pos[heap[cha]] := cha; pos[heap[con]] := con;
                 cha := con;
             until false;
        end;

procedure main;
var u,v,i,j,tt : longint;
        begin
              for i := 1 to n do d[i] := maxw;
              d[s] := 0;
              fillchar(free,sizeof(free),true);
              upheap(s);
              repeat
                   if nheap = 0 then break;
                   u := pop;
                   if u = t then
                     begin
                          res := d[u];
                          break;
                     end;
                   free[u] := false;
                   j := head[u];
                   while j <> 0 do
                     begin
                         v := ke[j];
                         if free[v] then
                           begin
                               if mau(u,d[u]+1) = mau(v,d[u]+1) then
                                 begin
                                     if d[v] > d[u] + w[j] then
                                       begin
                                           d[v] := d[u] + w[j];
                                           upheap(v);
                                       end;
                                 end
                               else
                                 begin
                                     tt := 1;
                                     while (tt < 400) and (mau(u,d[u]+tt) <> mau(v,d[u]+tt)) do inc(tt);
                                     if tt < 400 then
                                       begin
                                           if d[v] > d[u] + tt-1 + w[j] then
                                             begin
                                                 d[v] := d[u] + tt-1+w[j];
                                                 upheap(v);
                                             end;
                                       end;

                                 end;
                           end;
                         j := next[j];
                     end;
              until false;
              writeln(res);
        end;

begin
     nhap;
     main;
end.
