Const   inp = '';
        out = '';
        maxn = 1001;
        maxw = 999999999;

Var     n,k,nheap,s     :       longint;
        heap       :       array [1..2*maxn] of longint;
        d,pos,trace      :       array [-maxn..maxn] of longint;
        free    :       array [-maxn..maxn] of boolean;
        res     :       qword;

{**************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n,k);
        end;
{**************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure upheap(i : longint);
var cha,con : longint;
        begin
            con := pos[i];
            if con=0 then
             begin
                inc(nheap); heap[nheap] := i; pos[i] := nheap; con := nheap;
             end;
            repeat
               cha := con div 2;
               if (cha=0) or (d[heap[cha]] <= d[heap[con]]) then break;
               swap(heap[cha],heap[con]);
               pos[heap[cha]] := cha; pos[heap[con]] := con;
               con := cha;
            until false;
        end;
{**************************************************************************}
function pop : longint;
var cha,con : longint;
        begin
            pop := heap[1]; heap[1] := heap[nheap]; pos[heap[1]] := 1;
            dec(nheap); cha := 1;
            repeat
               con := cha*2;
               if (con<nheap) and (d[heap[con]]>d[heap[con+1]]) then inc(con);
               if (con>nheap) or (d[heap[cha]]<=d[heap[con]]) then break;
               swap(heap[cha],heap[con]);
               pos[heap[cha]] := cha; pos[heap[con]] := con;
               cha := con;
            until false;
        end;
{***************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            fillchar(Free,sizeof(free),true);
            for i := -n to n do d[i] := maxw; d[1] := 0;
            upheap(1);
        end;
{***************************************************************************}
procedure main;
var i,j,a,b,c,u,v : longint;
        begin
            repeat
                if nheap=0 then break;
                u := pop; free[u] := false;
                for i := 0 to 17 do
                  if u+1 shl i > n then break
                   else begin
                            v := u+1 shl i;
                            if free[v] and (d[v] > d[u]+1) then
                             begin
                                 d[v] := d[u]+1;
                                 trace[v] := u;
                                 upheap(v);
                             end;
                        end;
                for i := 0 to 17 do
                 if u-1 shl i < 1 then break
                  else begin
                            v := u-1 shl i;
                            if free[v] and (d[v] > d[u]+1) then
                             begin
                                 d[v] := d[u]+1;
                                 trace[v] := u;
                                 upheap(v);
                             end;
                       end;
            until false;
            for i := 1 to n do inc(s,d[i]);
            res := int64(s)*n*n*3;
            writeln(res);
            for i := 1 to k do
             begin
                 readln(a,b,c);
                 writeln(d[a]+d[b]+d[c]);
             end;
            for i := 1 to 150 do
             for j := 1 to 150 do
              for a := 1 to i-1 do
               for b := 1 to j-1 do
                c := c;
        end;
{***************************************************************************}
begin
     nhap;
     khoitao;
     main;
end.
