Const   maxn = 1000001;
Var     n,i,nheap     :       longint;
        r,p,heap     :       array [1..maxn] of longint;
        time,res     :       int64;

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
                 if (cha = 0) or (heap[cha] <= heap[con]) then break;
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
                 if (con < nheap) and (heap[con] > heap[con+1]) then inc(con);
                 if (con > nheap) or (heap[cha] <= heap[con]) then break;
                 cha := con;
             until false;
        end;

procedure sort(l,h : longint);
var i,j,k : longint;
        begin
             if l >= h then exit;
             i := l; j := h; k := r[l+random(h-l+1)];
             repeat
                while r[i] < k do inc(i);
                while r[j] > k do dec(j);
                if i <= j then
                  begin
                       if i < j then
                        begin
                            swap(r[i],r[j]);
                            swap(p[i],p[j]);
                        end;
                       inc(i); dec(j);
                  end;
             until i > j;
             sort(l,j); sort(i,h);
        end;

procedure push(x : longint);
        begin
             inc(nheap); heap[nheap] := x;
             upheap(nheap);
        end;

function pop : longint;
        begin
             pop := heap[1];
             heap[1] := heap[nheap]; dec(nheap);
             downheap(1);
        end;

procedure main;
var i,j,next,tg : longint;
        begin
              sort(1,n);
              time := r[1]; push(p[1]);
              for i := 2 to n do
                begin
                    tg := r[i] - time;
                    j := pop;
                    while (nheap > 0) and (tg - j >= 0) do
                      begin
                          res := res + time+j;
                          time := time + j;
                          tg := tg - j;
                          j := pop;
                      end;
                    if tg - j >= 0 then res := res + time+j
                     else push(j-tg);
                    time := r[i];
                    push(p[i]);
                end;
              while nheap <> 0 do
                begin
                    j := pop;
                    inc(res,time+j);
                    time := time+j;
                end;
              write(res);
        end;

begin
      assign(input,'pulp.inp'); reset(input);
      assign(output,'pulp.out'); rewrite(output);
      readln(n);
      for i := 1 to n do read(r[i],p[i]);
      main;
end.
