uses math;
Const   inp = '';
        out = '';
        maxn = 400001;

Type    arr     =       array [1..maxn] of longint;

Var     fi,fo   :       text;
        b,a     :       arr;
        n,res       :       longint;

procedure input;
var i,j : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n);
             for i := 1 to n do read(fi,a[i],b[i]);
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
             temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j : longint;
    key : longint;
        begin
             if l >= h then exit;
             i := l; j := h;
             key := a[(l+h) div 2];
             repeat
                 while a[i] < key do inc(i);
                 while a[j] > key do dec(j);
                 if i <= j then
                   begin
                        if i < j then
                          begin
                               swap(a[i],a[j]);
                               swap(b[i],b[j]);
                          end;
                        inc(i); dec(j);
                   end;
             until i > j;
             sort(l,j); sort(i,h);
        end;

function check(k : longint; b : arr) : boolean;
var i,j : longint;
    tmp : longint;
        begin
             for i := 1 to n do b[i] := b[i] - k;
             tmp := 0;
             i := 1; j := 1;
             tmp := b[1];
             for i := 2 to n do
              if tmp >= 0 then
               tmp := max(b[i],tmp + b[i] - (a[i] - a[i-1]))
              else tmp := tmp + b[i] - (a[i] - a[i-1]);
             if tmp < 0 then exit(false)
              else exit(true);

        end;
procedure find;
var d,c,i,mid : longint;
        begin
            d := maxlongint; c := 0;
            sort(1,n);
            for i := 1 to n do
              begin
                  d := min(b[i],d);
                  c := max(b[i],c);
              end;
            while d <= c do
              begin
                   mid := (d+c) div 2;
                   if check(mid,b) then
                     begin
                         res := mid;
                         d := mid + 1;
                     end
                   else c := mid - 1;
              end;
            writeln(fo,res);
            close(fi); close(fo);
        end;

begin
      input;
      find;
end.