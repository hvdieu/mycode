Uses math;
Const   inp = '';
        out = '';
        maxn = 1001;

Var     n,d,m     :       longint;
        l,r       :       array [1..maxn] of longint;
        b,id      :       array [0..2*maxn] of longint;
        f       : array [1..maxn,0..2*maxn] of longint;

{*************************************************************************}
procedure nhap;
var i,x : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n,d);
            for i := 1 to n do
             begin
               read(x); l[i] := x-d; r[i] := x+d;
               inc(m); b[m] := l[i]; id[m] := i;
               inc(m); b[m] := r[i]; id[m] := i+n;
             end;
        end;
{*************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{*************************************************************************}
procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i :=l; j := h; k := b[l+random(h-l+1)];
            repeat
               while b[i]<k do inc(i);
               while b[j]>k do dec(j);
               if i<=j then
                begin
                    if i<j then
                     begin
                        swap(b[i],b[j]);
                        swap(id[i],id[j]);
                     end;
                    inc(i); dec(j);
                end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            sort(1,m);
            d := 0; b[0] := -maxlongint;
            for i := 1 to m do
             begin
                 if b[i]<>b[i-1] then inc(d);
                 if id[i]<=n then l[id[i]] := d
                  else r[id[i]-n] := d;
             end;
        end;
{***************************************************************************}
procedure main;
var i,j : longint;
        begin
            for j := 1 to d do
             if (j>=l[1]) and (j<=r[1]) then f[1,j] := 1
              else f[1,j] := 0;
            for i := 2 to n do
             for j := 1 to d do
              if (j>=l[i]) and (j<=r[i]) then f[i,j] := max(f[i-1,j]+1,f[i,j-1])
               else f[i,j] := max(f[i-1,j],f[i,j-1]);
            writeln(f[n,d]);
        end;
{***************************************************************************}
begin
     nhap;
     khoitao;
     main;
end.