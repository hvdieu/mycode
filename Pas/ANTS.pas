Const   maxn = 100001;
        maxx = 1000001;
Var     a,x       :       array [1..maxn] of longint;
        left,right      : array [1..maxn] of int64;
        n,i,k     :       longint;
        res     : int64;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j : longint;
    k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := x[l + random(h-l+1)];
            repeat
               while x[i] < k do inc(i);
               while x[j] > k do dec(j);
               if i <= j then
                 begin
                     if i < j then
                       begin
                           swap(x[i],x[j]);
                           swap(a[i],a[j]);
                       end;
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

procedure dc(var xx,yy : int64);
var temp : int64;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure qsort(l,h : longint);
var i,j : longint;
    k : int64;
        begin
            if l >= h then exit;
            i := l; j := h; k := right[l + random(h-l+1)];
            repeat
               while right[i] < k do inc(i);
               while right[j] > k do dec(j);
               if i <= j then
                 begin
                     if i < j then
                       begin
                           dc(left[i],left[j]);
                           dc(right[i],right[j]);
                       end;
                     inc(i); dec(j);
                 end;
            until i > j;
            qsort(l,j); qsort(i,h);
        end;

function check(key : int64) : boolean;
var i,j,dem : longint;
    last,t   : int64;
         begin
             for i := 1 to n do
               begin
                  t := key div (2*a[i]);
                  left[i] := x[i] - t;
                  right[i] := x[i]+t;
               end;
            qsort(1,n); dem := 0; last := -maxlongint;
            for i := 1 to n do
              begin
                  if (last >= left[i]) and (last <= right[i]) then continue
                   else
                    begin
                        inc(dem);
                        last := right[i];
                    end;
              end;
            if dem <= k then exit(true)
             else exit(false);
         end;

procedure find;
var d,c,mid : int64;
        begin
             d := 0; c := 1000000000000;
             while d <= c do
               begin
                   mid := (d+c) shr 1;
                   if check(mid) then
                     begin
                         res := mid;
                         c := mid-1;
                     end
                   else d := mid + 1;
               end;
        end;

procedure main;
var i,j : longint;
        begin
             sort(1,n);
             find;
             writeln(res);
        end;

begin
      assign(input,'ANTS.INP'); reset(input);
      assign(output,'ANTS.OUT'); rewrite(output);
      readln(n,k);
      for i := 1 to n do read(x[i]);
      for i := 1 to n do read(a[i]);
      main;
end.