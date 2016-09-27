Program bocsoi113;
const   tfi                     =       'BOCSOI113.inp';
        tfo                     =       'BOCSOI113.out';
        oo                      =       100010;
var     fi,fo                   :       text;
        heap                    :       array[1..oo] of longint;
        n                       :       longint;
        a                       :       array[1..oo] of longint;
        res                     :       real;
        nheap                   :       longint;
(*****************************)
Procedure input;
var i,j:longint;
begin
        read(Fi,n);
        For i:=1 to n do Read(fi,a[i]);
end;
(*****************************)
Procedure upheap(x:longint);
var cha,key:longint;
begin
        key:=heap[x];
        cha:=x div 2;
        While cha>0 do
         begin
                If heap[cha] <= key then break;
                heap[x]:=heap[cha];
                x:=cha;
                cha:=x div 2;
         end;
        heap[x]:=key;
end;
(*****************************)
Procedure downheap(x:longint);
var son,key:longint;
begin
        son:=x * 2;
        key:=heap[x];
        While son<=nheap do
         begin
                If (son<nheap) and (heap[son]>heap[son+1]) then inc(son);
                If heap[son] >= key then break;
                heap[x]:=heap[son];
                x:=son;
                son:=x*2;
         end;
        heap[x]:=key;
end;
(*****************************)
Procedure push(x:longint);
begin
        inc(nheap);
        heap[nheap]:=x;
        upheap(nheap);
end;
(*****************************)
Function pop:longint;
begin
        pop:=heap[1];
        heap[1]:=heap[nheap];
        dec(nheap);
        downheap(1);
end;
(*****************************)
Procedure process;
var i,j,u,v,tg:longint;
begin
        For i:=1 to n do push(a[i]);
        res:=0;
        While nheap>=2 do
         begin
                u:=pop;
                v:=pop;
                res:=res+((u+v)*5)/100;
                tg:=u+v;
                push(tg);
         end;
end;
(*****************************)
PRocedure output;
begin
        process;
        writeln(fo,res:0:2);
end;
(*****************************)
begin
        assign(Fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                input;
                output;
        close(fi);close(fo);
end.


