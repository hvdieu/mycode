{$H+}
Const   maxn = 16001;
        maxw = 999999999;
Var     s       :       array [1..3] of string;
        d,heap,pos       :       array [-maxn..maxn] of longint;
        free    :       array [-maxn..maxn] of boolean;
        c       :       array [1..3] of longint;
        res,nheap     :       longint;
        ok      :       boolean;

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
                    inc(nheap); heap[nheap] := i; con := nheap;
                    pos[i] := nheap;
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
             pop := heap[1];
             heap[1] := heap[nheap]; pos[heap[1]] := 1; dec(nheap);
             cha := 1;
             repeat
               con := cha*2;
               if (con < nheap) and (d[heap[con]] > d[heap[con+1]]) then inc(con);
               if (con > nheap) or (d[heap[cha]] <= d[heap[con]]) then break;
               swap(heap[cha],heap[con]);
               pos[heap[cha]] := cha; pos[heap[con]] := con;
               cha := con;
             until false;
        end;

procedure khoitao;
var i : longint;
        begin
             fillchar(free,sizeof(free),true);
             for i := -maxn to maxn do d[i] := maxw;
             d[0] := 0;
             c[1] := length(s[1]); c[2] := length(s[2]); c[3] := length(s[3]);
             upheap(0);
             res := maxw;
        end;

procedure dij;
var i,j,u,v : longint;
        begin
             repeat
                if nheap = 0 then break;
                u := pop;
                free[u] := false;
                for i := 1 to 3 do
                  begin
                      v := u + c[i];
                      if (v < maxn) and (free[v]) and (d[v] > d[u] + c[i]) then
                        begin
                            d[v] := d[u] + c[i];
                            upheap(v);
                        end;
                      v := u - c[i];
                      if (v > -maxn) and (free[v]) and (d[v] > d[u] + c[i]) then
                        begin
                            d[v] := d[u] + c[i];
                            upheap(v);
                        end;
                  end;
             until false;
        end;

procedure main;
var i,j,x : longint;
        begin
             for i := 1 to 3 do
               begin
                    for j := 1 to c[i] do
                     if s[i][j] = '1' then
                       begin
                           x := (j-1) - (c[i]-j);
                           if res > d[-x]+c[i] then
                             begin
                                 res := d[-x]+c[i];
                                 ok := true;
                             end;
                       end;
               end;
             if res = maxw then write(0)
              else write(res);
        end;


begin
      assign(input,'base3.in'); reset(input);
      assign(output,'base3.out'); rewrite(output);
      readln(s[1]); readln(s[2]); readln(s[3]);
      khoitao;
      dij;
      main;
end.