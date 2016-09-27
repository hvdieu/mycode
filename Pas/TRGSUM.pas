Const   inp = '';
        out = '';
        maxn = 5000001;
        maxa = 1000000;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        s       :       array [0..maxn] of int64;
        f       :       array [0..maxa] of int64;
        res     :       int64;
        n,k     :       longint;

procedure input;
var i : longint;
        begin
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,n,k);
              for i := 1 to n do
               begin
                  read(fi,a[i]);
                  a[i] := a[i] mod k;
               end;
        end;

procedure swap(var xx,yy : int64);
var temp : longint;
        begin
             temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,key : longint;
        begin
              if l >= h then exit;
              i := l; j := h;
              key := s[(l+h) div 2];
              repeat
                   while s[i] < key do inc(i);
                   while s[j] > key do dec(j);
                   if i <= j then
                     begin
                          if i < j then swap(s[i],s[j]);
                          inc(i); dec(j);
                     end;
              until i > j;
              sort(l,j); sort(i,h);
        end;

procedure sub1;
var i,j : longint;
    dem : int64;
        begin
             s[0] := 0;
             for i := 1 to n do
               begin
                     s[i] := int64(s[i-1] + a[i]) mod k;
               end;
             sort(1,n);
             res := 0;
             i := 1; dem := 1;
             while i <= n do
               begin
                   while (i < n) and (s[i] = s[i+1]) do
                     begin
                          inc(dem);
                          inc(i);
                     end;
                   if s[i] = 0 then
                      res := res + dem + ((dem-1)*dem) div 2
                   else res := res + ((dem-1)*dem) div 2;
                   inc(i); dem := 1;
               end;
             writeln(fo,res);
        end;

procedure sub2;
var i : longint;
        begin
              s[0] := 0;
              for i := 1 to n do
               begin
                     s[i] := int64(s[i-1] + a[i]) mod k;
                     inc(f[s[i]]);
               end;
              res := 0;
              for i := 0 to k-1 do
               if i = 0 then res := res + f[i] + int64(((f[i]-1)*f[i])) div 2
                else res := res + int64((f[i]*(f[i]-1))) div 2;
              writeln(fo,res);

        end;

procedure main;
var i : longint;
        begin
              if n <= 100000 then sub1
                else sub2;
              close(fi); close(fo);
        end;

begin
      input;
      main;
end.

