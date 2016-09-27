{$inline on}
Const   maxn = 100010;

Type    arr     =       array [1..2*maxn] of longint;

Var     n,u,v,i,m,j,x1,y1,l,dem       :       longint;
        res     :       longint;
        x,y,z,id    :       array [1..maxn] of longint;
        t,b     :  array [0..maxn] of longint;

{**************************************************************************}
function max(x,y : longint) : longint; inline;
        begin
            if x >= y then exit(x)
             else exit(y);
        end;
{**************************************************************************}
procedure swap(var xx,yy : longint); inline;
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{**************************************************************************}
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
                      if i < j then
                       begin
                         swap(b[i],b[j]);
                         swap(id[i],id[j]);
                       end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{**************************************************************************}
function find(key : longint) : longint; inline;
var d,c,mid,ans : longint;
        begin
             d := 1; c := m; ans := 0;
             while d <= c do
               begin
                   mid := (d+c) shr 1;
                   if b[mid] = key then
                     begin
                         ans := mid;
                         c := mid-1;
                     end
                   else if b[mid] > key then c := mid-1
                    else d := mid+1;
               end;
             exit(ans);
        end;
{**************************************************************************}
procedure sort2(l,h : longint);
var i,j,k,k1,k2 : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := y[k]; k2 := x[k];
            repeat
                while (y[i] < k1) or ((y[i]=k1) and (x[i] < k2)) do inc(i);
                while (y[j] > k1) or ((y[j]=k1) and (x[j] > k2)) do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(x[i],x[j]);
                            swap(y[i],y[j]);
                            swap(z[i],z[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort2(l,j); sort2(i,h);
        end;
{**************************************************************************}
procedure update(i : longint; val : longint); inline;
        begin
            while i <= m do
              begin
                  t[i] := max(t[i],val);
                  inc(i,i and (-i));
              end;
        end;
{**************************************************************************}
function get(i : longint) : longint; inline;
var ans : longint;
        begin
             ans := 0;
             while i > 0 do
               begin
                   ans := max(ans,t[i]);
                   dec(i,i and (-i));
               end;
             exit(ans);
        end;
{**************************************************************************}
procedure main; inline;
var i,j,alt : longint;
        begin
            sort(1,n);
            b[0] := b[1]-1;
            for i := 1 to n do
               begin
                   if b[i] <> b[i-1] then inc(m);
                   x[id[i]] := m;
               end;
            sort2(1,n);
            for i := 1 to n do
              begin
                  alt := get(x[i]) + z[i];
                  if res < alt then res :=alt;
                  update(x[i],alt);
              end;
            writeln(res);
        end;
{**************************************************************************}
begin
   //  assign(input,'MBUS.IN'); reset(input);
   //  assign(output,'MBUS.OUT'); rewrite(output);
     read(u,v,n);
     for i := 1 to n do
       begin
           read(x1,y1,l);
           if (x1 >= 1) and (x1 <= u) and (y1 >=1) and (y1 <= v) then
           begin
             inc(j);
             x[j] := x1; y[j] := y1; z[j] := l;
             b[j] := x[j];
             id[j] := j;
           end;
       end;
     main;
end.
