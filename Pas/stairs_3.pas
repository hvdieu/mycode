Uses math;
Const   maxn = 5001;
Var     n,i    :       longint;
        a,b     :       array [1..maxn] of longint;
        f,g       :       array [0..maxn,0..maxn] of int64;
        res       :       int64;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := b[l+random(h-l+1)];
            repeat
                while b[i] < k do inc(i);
                while b[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then swap(b[i],b[j]);
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

procedure main;
var i,j : longint;
        begin
            sort(1,n);
            for i := 0 to n do
              for j := 0 to n do g[i,j] := 1 shl 62;
            for i := 1 to n do
              begin
                f[1,i] := abs(a[1]-b[i]);
                g[1,i] := min(f[1,i],g[1,i-1]);
              end;
            for i := 2 to n do
              for j := 1 to n do
                begin
                    f[i,j] := g[i-1,j] + abs(a[i]-b[j]);
                    g[i,j] := min(g[i,j-1],f[i,j]);
                end;

            res := 1 shl 62;
            for i := 1 to n do res := min(res,f[n,i]);
            write(res);
        end;

begin
     assign(input,'STAIRS.INP'); reset(input);
     assign(output,'STAIRS.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n do
       begin
          read(a[i]); b[i] := a[i];
       end;
     main;
end.
