Const   maxn = 1000001;
Var     n,i     :       longint;
        a       :       array [1..maxn] of longint;
        res     :       int64;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := a[l+random(h-l+1)];
            repeat
                while a[i] < k do inc(i);
                while a[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then swap(a[i],a[j]);
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;


begin
      assign(input,'DISCOUNT.INP'); reset(input);
      assign(output,'DISCOUNT.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do read(a[i]);
      if n <= 2 then write(0)
       else begin
                sort(1,n);
                i := n-2;
                while i > 0 do
                  begin
                      res := res + a[i];
                      i := i - 3;
                  end;
            end;
     writeln(res);
end.