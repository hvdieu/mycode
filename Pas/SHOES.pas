uses math;
Const   maxn = 1001;
Type    arr = array [1..maxn] of longint;
Var     n,i,m,res,j     :       longint;
        f,g       :       array [0..maxn,0..maxn] of longint;
        a,b     :       array [1..maxn] of longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint;var b : arr);
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
            sort(l,j,b); sort(i,h,b);
        end;

procedure main;
var i,j : longint;
        begin
              sort(1,n,a);
              sort(1,m,b);
              for i := 0 to n do
                for j := 0 to m do
                 begin
                     f[i,j] := 999999999;
                     g[i,j] := 999999999;
                 end;
              for j := 1 to m do
               begin
                   f[1,j] := abs(a[1]-b[j]);
                   g[1,j] := min(g[1,j-1],f[1,j]);
               end;
              for i := 2 to n do
               for j := 1 to m do
                  begin
                      f[i,j] := g[i-1,j-1] + abs(a[i]-b[j]);
                      g[i,j] := min(g[i,j-1],f[i,j]);
                  end;
              res := maxlongint;
              for i := 1 to m do
               if f[n,i] < res then res := f[n,i];
              writeln(res);
        end;

begin
      assign(input,'SHOES.INP'); reset(input);
      assign(output,'SHOES.OUT'); rewrite(output);
      readln(m,n);
      for i := 1 to m do read(b[i]);
      for i := 1 to n do read(a[i]);
      main;
end.