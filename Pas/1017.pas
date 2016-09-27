Uses math;
Const   maxn = 201;

Type    arr = array [1..maxn] of longint;

Var     a,y       :       array [1..maxn] of longint;
        t,st,w,k,n,i,x      :       longint;
        f       :       array [0..maxn,0..maxn] of longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint; var k : arr);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := k[l+random(h-l+1)];
            repeat
               while k[i] < key do inc(i);
               while k[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then swap(k[i],k[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j,k); sort(i,h,k);
        end;

procedure main;
var i,j,vt,now : longint;
        begin
             fillchar(f,sizeof(f),0);
             sort(1,n,y);
             a[1] := 1;
             for i := 2 to n do
              begin
                  now := i;
                  while (now > 0) and (y[i] - y[now] <= w) do dec(now);
                  a[i] := i - now
              end;
             f[1,1] := 1;
             for i := 2 to n do
               for j := 1 to min(i,k) do
                 f[i,j] := max(f[i-1,j],f[i-a[i],j-1]+a[i]);
             writeln(f[n,k]);
        end;

begin
      assign(input,'1017.inp'); reset(input);
      assign(output,'13.out'); rewrite(output);
      readln(t);
      for st := 1 to t do
        begin
            write('Case ',st,': ');
            readln(n,w,k);
            if k >= n then writeln(n)
            else begin
                   for i := 1 to n do read(x,y[i]);
                   main;
                 end;
        end;
end.