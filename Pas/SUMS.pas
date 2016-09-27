Const   inp = '';
        out = '';
        maxn = 5001;
        maxa = 50001;
        maxw = 99999999;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        heap    :       array [1..maxa] of longint;
        pos,d     :       array [0..maxa] of longint;
        free    :       array [0..maxa] of boolean;
        n,m,nheap     :       longint;

procedure input;
var i,j : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n);
             for i := 1 to n do readln(fi,a[i]);
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
                   pos[heap[cha]] := cha; pos[heap[con]] := con;
                   con := cha;
             until false;
        end;

procedure downheap(i : longint);
var cha,con : longint;
        begin
             cha := pos[i];
             repeat
                   con := cha*2;
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
var u,v,i,x : longint;
        begin
             fillchar(free,sizeof(free),true);
             d[0] := 0;
             for i := 1 to a[1]-1 do d[i] := maxw;
             upheap(0);
             repeat
                 if nheap = 0 then break;
                 u := pop;
                 free[u] := false;
                 for i := 2 to n do
                   begin
                        v := (u + a[i] mod a[1]) mod a[1];
                        if d[v] > d[u] + a[i] then
                          begin
                              d[v] := d[u] + a[i];
                              upheap(v);
                          end;
                   end;
             until false;
        end;

procedure main;
var i,k,x : longint;
        begin
             Dij;
             readln(fi,m);
             for i := 1 to m do
               begin
                    readln(fi,x);
                    k := x mod a[1];
                    if (x < d[k]) or (d[k] = maxw) then writeln(fo,'NIE')
                     else writeln(fo,'TAK');
               end;
             close(fi); close(fo);
        end;

begin
      input;
      main;
end.



