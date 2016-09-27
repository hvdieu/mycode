Const   maxn = 100002;
Var     n,a,b,i,nheap,left,right   :       longint;
        t,p,heap     :       array [0..maxn] of longint;
        res     :       int64;

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
                 if (cha = 0) or (heap[cha] >= heap[con]) then break;
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
                 if (con < nheap) and (heap[con] < heap[con+1]) then inc(con);
                 if (con > nheap) or (heap[cha] >= heap[con]) then break;
                 swap(heap[cha],heap[con]);
                 cha := con;
             until false;
        end;

procedure sort(l,h : longint);
var i,j,k,k1,k2 : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := t[k]; k2 := p[k];
            repeat
                while (t[i] < k1) or ((t[i] = k1) and (p[i] < k2)) do inc(i);
                while (t[j] > k1) or ((t[j] = k1) and (p[j] > k2)) do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(t[i],t[j]);
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
var i,j,x : longint;
        begin
              sort(1,n);
              left := 1;
              for i := 1 to n do
               if t[i] <= a then
                 begin
                     inc(res,p[i]);
                     left := i+1;
                 end
               else break;

              for i := n downto left do
                begin
                     if t[i] > b then push(p[i])
                      else
                        begin
                             while (t[i] < b) and (nheap > 0) do
                               begin
                                   pop;
                                   dec(b);
                               end;
                             if nheap = 0 then b := t[i];
                             push(p[i]);
                        end;
                end;
              while (a < b) and (nheap > 0) do
               begin
                   pop;
                   dec(b);
               end;
              while nheap > 0 do res := res + pop;
              writeln(res);
        end;

begin
      assign(input,'PENALTY.INP'); reset(input);
      assign(output,'PENALTY.OUT'); rewrite(output);
      readln(n,a,b);
      for i := 1 to n do read(t[i],p[i]);
      main;
end.
