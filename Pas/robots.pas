Const   inp = 'robots.inp';
        out = 'robots.out';
        maxn = 1000001;
        maxa = 50001;

Type    arr = array [1..maxn] of longint;

Var     n,a,b,res,top,nheap   :       longint;
        x,y     :       array [1..maxn] of longint;
        w,s,heap     :       array [1..maxn] of longint;
        free    :  array [1..maxn] of boolean;

{***************************************************************************}
procedure nhap;
var i,j : longint;
    begin
        assign(input,inp); reset(input);
        assign(output,out); rewrite(output);
        readln(a,b,n);
        for i := 1 to a do read(x[i]);
        for i := 1 to b do read(y[i]);
        for i := 1 to n do
         begin
           read(w[i],s[i]);
         end;
    end;
{***************************************************************************}
procedure swap(var x,y : longint);
var t : longint;
    begin
        t := x; x := y; y := t;
    end;
{***************************************************************************}
procedure sort(l,h : longint);
var i,j,k,k1,k2 : longint;
    begin
        if l >= h then exit;
        i := l; j := h; k := l+random(h-l+1);
        k1 := w[k]; k2 := s[k];
        repeat
            while (w[i]<k1) or ((w[i]=k1) and (s[i]<k2)) do inc(i);
            while (w[j]>k1) or ((w[j]=k1) and (s[j]>k2)) do dec(j);
            if i <= j then
             begin
                 swap(w[i],w[j]); swap(s[i],s[j]);
                 inc(i); dec(j);
             end;
        until i > j;
        sort(l,j); sort(i,h);
    end;
{***************************************************************************}
procedure sort2(l,h : longint;var a : arr);
var i,j,k : longint;
    begin
        if l >= h then exit;
        i := l; j := h; k := a[l+random(h-l+1)];
        repeat
            while a[i]<k do inc(i);
            while a[j]>k do dec(j);
            if i <= j then
             begin
                 swap(a[i],a[j]);
                 inc(i); dec(j);
             end;
        until i > j;
        sort2(l,j,a); sort2(i,h,a);
    end;
{***************************************************************************}
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
{****************************************************************************}
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
{***************************************************************************}
procedure push(x : longint);
    begin
        inc(nheap); heap[nheap] := x; upheap(nheap);
    end;
{***************************************************************************}
function pop : longint;
    begin
        pop := heap[1];
        heap[1] := heap[nheap]; dec(nheap);
        downheap(1);
    end;
{***************************************************************************}
function check(k : longint) : boolean;
var i,j,dem : longint;
    begin
        nheap := 0;
        j := 1;
        for i := 1 to a do
          begin
              while (j<=n) and (x[i]>w[j]) do
                begin
                   push(s[j]); inc(j);
                end;
              dem := k;
              while (nheap>0) and (dem>0) do
               begin
                   pop;
                   dec(dem);
               end;
          end;
        for i := j to n do push(s[i]);
        if nheap=0 then exit(true);
        for i := b downto 1 do
          begin
              if heap[1]>=y[i] then exit(false);
              dem := k;
              while (nheap>0) and (dem>0) do
                begin
                    pop;
                    dec(dem);
                end;
              if nheap=0 then exit(true);
          end;
        if nheap=0 then exit(true) else
        exit(false);
    end;
{**************************************************************************}
procedure main;
var i,j,d,c,mid : longint;
    begin
         sort(1,n);
         sort2(1,a,x); sort2(1,b,y);
         d := 1; c := n; res := -1;
         while d <= c do
          begin
              mid := (d+c) div 2;
              if check(mid) then
                begin
                  res := mid; c := mid-1;
                end
              else d := mid+1;
          end;
         writeln(res);
    end;
{***************************************************************************}
begin
     nhap;
     main;
end.