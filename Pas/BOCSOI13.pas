Const   maxn = 100010;
Var     n,nheap,i       :       longint;
        heap    :       array [1..maxn] of longint;
        res     :       double;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure upheap(i : longint);
var cha,con : longint;
        begin
            con := i;
            repeat
                 cha := con div 2;
                 if (cha=0) or (heap[cha] <= heap[con]) then break;
                 swap(heap[cha],heap[con]);
                 con := cha;
            until false;
        end;

procedure downheap(i : longint);
var cha,con : longint;
        begin
             cha := i;
             repeat
                 con := cha*2;
                 if (con<nheap) and (heap[con+1] < heap[con]) then inc(con);
                 if (con>nheap) or (heap[cha] <= heap[con]) then break;
                 swap(heap[cha],heap[con]);
                 cha := con;
             until false;
        end;

function pop : longint;
        begin
            pop := heap[1];
            heap[1] := heap[nheap]; dec(nheap);
            downheap(1);
        end;

procedure push(s : longint);
        begin
            inc(nheap); heap[nheap] := s;
            upheap(nheap);
        end;

procedure main;
var i,j,u,v : longint;
        begin
            for i := n div 2 downto 1 do
              downheap(i);
            res := 0;
            repeat
                if nheap = 1 then break;
                u := pop; v := pop;
                res := res + (u+v) / 20;
                push(u+v);
            until false;
            write(res:0:2);
        end;

begin
     assign(input,'BOCSOI13.INP'); reset(input);
     assign(output,'BOCSOI13.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n do read(heap[i]);
     nheap := n;
     main;

end.
