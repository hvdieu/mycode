Uses math;
Const   inp = '';
        out = '';
        maxn = 10001;

Var     n,left,right,res,nheap       :       longint;
        c,t,mx,my,trace,queue,l,r,heap : array [1..maxn] of longint;

{***************************************************************************}
procedure nhap;
var i : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n do readln(c[i],t[i]);
        end;
{***************************************************************************}
{procedure khoitao(x : longint);
var i,j,d : longint;
        begin
            fillchar(mx,sizeof(mx),0); fillchar(my,sizeof(my),0);
            for i := 1 to n do
             begin
                d := x div t[i];
                for j := max(c[i]-d,1) to min(c[i]+d,n) do
                 if my[j]=0 then
                  begin
                     mx[i] := j; my[j] := i; break;
                  end;
             end;
        end;    }
{***************************************************************************}
{procedure push(x : longint);
        begin
            inc(right); queue[right] := x;
        end; }
{***************************************************************************}
{function pop : longint;
        begin
            inc(left); pop := queue[left];
        end;   }
{***************************************************************************}
{function timduongmo(x : longint) : longint;
var i,j,d : longint;
        begin
            left := 0; right := 0;
            fillchar(trace,sizeof(trace),0);
            for i := 1 to n do
             if mx[i]=0 then push(i);
            while left < right do
              begin
                 i := pop; d := x div t[i];
                 for j := max(c[i]-d,1) to min(c[i]+d,n) do
                  if trace[j]=0 then
                   begin
                       trace[j] := i;
                       if my[j]=0 then exit(j);
                       push(my[j]);
                   end;
              end;
            exit(0);
        end;   }
{***************************************************************************}
{procedure morong(f : longint);
var next,x : longint;
        begin
            repeat
              x := trace[f];
              next := mx[x];
              my[f] := x; mx[x] := f;
              f := next;
            until f=0;
        end;     }
{***************************************************************************}
{function check(x : longint) : boolean;
var i,j,dem,f : longint;
        begin
            khoitao(x);
            repeat
                 f := timduongmo(x);
                 if f = 0 then break;
                 morong(f);
            until false;
            dem := 0;
            for i := 1 to n do
             if mx[i]<>0 then inc(dem);
            if dem = n then exit(true)
             else exit(false);
        end;   }
{***************************************************************************}
procedure swap(var xx,yy : longint); inline;
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{**************************************************************************}
procedure sort(d,c : longint);
var i,j,k : longint;
        begin
            if d >= c then exit;
            i := d; j := c; k := l[d+random(c-d+1)];
            repeat
                while l[i] < k do inc(i);
                while l[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then
                       begin
                         swap(l[i],l[j]);
                         swap(r[i],r[j]);
                       end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(d,j); sort(i,c);
        end;
{**************************************************************************}
procedure push(x : longint);
var cha,con : longint;
        begin
            inc(nheap); heap[nheap] := x;
            con := nheap;
            repeat
               cha := con div 2;
               if (cha=0) or (heap[cha]<=heap[con]) then break;
               swap(heap[cha],heap[con]);
               con := cha;
            until false;
        end;
{**************************************************************************}
function pop : longint;
var cha,con : longint;
        begin
            pop := heap[1]; heap[1] := heap[nheap]; dec(nheap); cha := 1;
            repeat
                con := cha*2;
                if (con<nheap) and (heap[con]>heap[con+1]) then inc(con);
                if (con>nheap) or (heap[cha] <= heap[con]) then break;
                swap(heap[cha],heap[con]);
                cha := con;
            until false;
        end;
{**************************************************************************}
function check1(x : longint) : boolean;
var i,j,u : longint;
        begin
            for i := 1 to n do
             begin
                l[i] := max(c[i]-x div t[i],1);
                r[i] := min(c[i]+x div t[i],n);
             end;
            sort(1,n); nheap := 0; j := 1;
            for i := 1 to n do
              begin
                  while (j <= n) and (l[j] = i) do
                    begin
                       push(r[j]);
                       inc(j);
                    end;
                  if nheap = 0 then exit(false);
                  u := pop;
                  if u < i then exit(false);
              end;
            exit(true);
        end;
{***************************************************************************}
procedure main;
var dau,cuoi,mid : longint;
        begin
            dau := 0;cuoi := 100000001;
            while dau <= cuoi do
              begin
                  mid := (dau+cuoi) shr 1;
                  if check1(mid) then
                   begin
                       res := mid;
                       cuoi:=mid-1;
                   end
                  else dau := mid+1;
              end;
            writeln(res);
        end;
{***************************************************************************}
begin
     nhap;
     main;
end.

