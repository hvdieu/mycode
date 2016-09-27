{$inline on}
Const   maxn = 10001;
        maxs = 100010;
        maxk = 51;
        oo = 5000000;
Var     n,k,i,res,maxa   :       longint;
        a,b,c       :       array [1..maxn] of longint;
        t     :       array [0..maxk,0..maxn] of longint;
        f     :       array [0..maxn,0..maxk] of longint;

{***************************************************************************}
procedure update(i,j,val : longint); inline;
        begin
             while j <= maxa do
               begin
                   t[i,j] := t[i,j] + val;
                   if t[i,j] >= oo then dec(t[i,j],oo);
                   inc(j,j and (-j));
               end;
        end;
{***************************************************************************}
function get(i,j : longint) : longint; inline;
var s : longint;
        begin
             s := 0;
             while j > 0 do
               begin
                   s := s + t[i,j];
                   if s >= oo then dec(s,oo);
                   dec(j,j and (-j));
               end;
             exit(s);
        end;
{***************************************************************************}
procedure main; inline;
var i,j,temp : longint;
        begin
              for i := 1 to n do
               begin
                    for j := 2 to k do
                      begin
                          temp := get(j-1,b[i]-1);
                          f[b[i],j] := f[b[i],j] + temp;
                          if f[b[i],j] >= oo then dec(f[b[i],j],oo);
                          update(j,b[i],temp);
                      end;
                    inc(f[b[i],1]);
                    if f[b[i],1] >= oo then dec(f[b[i],1],oo);
                    update(1,b[i],1);
               end;
              for i := 0 to maxa do
              begin
                res := res + f[i,k] mod oo;
                if res >= oo then dec(res,oo);
              end;
              writeln(res);
        end;
{***************************************************************************}
procedure swap(var xx,yy : longint); inline;
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
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
{***************************************************************************}
function find(key : longint) : longint; inline;
var d,c,mid,ans : longint;
        begin
             d := 1; c := n;
             while d <= c do
               begin
                   mid := (d+c) shr 1;
                   if a[mid] = key then
                     begin
                         ans := mid;
                         c := mid-1;
                     end
                   else if a[mid] > key then c := mid-1
                    else d := mid+1;
               end;
             exit(ans);
        end;
{***************************************************************************}
procedure khoitao; inline;
var i,j : longint;
        begin
             sort(1,n);
             for i := 1 to n do
               begin
                   b[i] := find(c[i]);
                   if b[i] > maxa then maxa := b[i];
               end;
        end;
{***************************************************************************}
begin
    // assign(input,'INCVN.INP'); reset(input);
    // assign(output,'INCVN.OUT'); rewrite(output);
     readln(n,k);
     for i := 1 to n do
       begin
         read(a[i]);
         c[i] := a[i];
       end;
     khoitao;
     main;
end.

