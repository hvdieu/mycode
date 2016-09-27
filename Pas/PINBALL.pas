Const   maxn = 10001;
Var     n,i : longint;
        a,p,kq,p1 : array [0..maxn] of longint;
        t       :       array [1..4*maxn] of longint;
        res     :       double;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k1,k2,k : longint;
        begin
            if l >= h then exit;
            k := l + random(h-l+1);
            k1 := a[k]; k2 := p[k];
            i :=l ;j := h;

            repeat
              while (a[i] < k1) or ((a[i] = k1) and (p[i] < k2)) do inc(i);
              while (a[j] > k1) or ((a[j] = k1) and (p[j] > k2)) do dec(j);
              if i <= j then
                begin
                    swap(a[i],a[j]); swap(p[i],p[j]);
                    inc(i); dec(j);
                end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

procedure update(i,lo,hi,u : longint);
var mid : longint;
        begin
            if (lo = u) and (hi = u) then
             begin
                 t[i] := 1; exit;
             end;
            if (lo > u) or (hi < u) then exit;
            mid := (lo+hi) shr 1;
            update(i*2,lo,mid,u); update(i*2+1,mid+1,hi,u);
            t[i] := t[i*2] + t[i*2+1];
        end;

function qr(i,lo,hi,u,v : longint) : longint;
var mid : longint;
        begin
            if (u <= lo) and (hi <= v) then exit(t[i]);
            if (lo > v) or (hi < u) then exit(0);
            mid := (lo+hi) shr 1;
            exit(qr(i*2,lo,mid,u,v) + qr(i*2+1,mid+1,hi,u,v));
        end;

procedure main;
var i,x : longint;
        begin
              a[0] := -1;
              for i := 1 to n do p1[i] := p[i];
              for i := 1 to n do if a[i] = a[i-1] then p[i] := p[i-1];
              for i := 1 to n do
                begin
                    if a[i] = a[i-1] then kq[p1[i]] := kq[p1[i-1]]
                    else
                      begin
                         x := qr(1,1,n,1,p[i]-1);
                         if x = 0 then kq[p1[i]] := p[i]
                          else kq[p1[i]] := p[i] - x;
                         update(1,1,n,p[i]);
                      end;
                end;
              res := 0;
              for i := 1 to n do res := res + kq[i];
              res := res / n;
              write(res:0:2);
        end;

begin
      assign(input,'PINBALL.INP'); reset(input);
      assign(output,'PINBALL.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do
        begin
            read(a[i]); p[i] := i;
        end;

      sort(1,n);
      main;
end.