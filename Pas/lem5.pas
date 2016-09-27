{$inline on}
Const    maxn = 100010;
         maxd = 101;
Var      n,i,d,res  :       longint;
         a,id   :       array [1..maxn] of longint;
         f      :       array [0..maxn,1..maxd] of longint;

{***************************************************************************}
procedure swap(var xx,yy : longint); inline;
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure sort(l,h : longint);
var i,j,k,k1,k2 : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := a[k]; k2 := id[k];
            repeat
                while (a[i] < k1) or ((a[i]=k1) and (id[i]<k2)) do inc(i);
                while (a[j] > k1) or ((a[j]=k1) and (id[j]>k2)) do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(a[i],a[j]);
                            swap(id[i],id[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
function find(i,key : longint) : longint; inline;
var d,c,mid,ans : longint;
        begin
             if i = 1 then exit(0);
             d := 1; c := i-1; ans := 0;
             while d <= c do
               begin
                   mid := (d+c) shr 1;
                   if a[mid] = key then
                     begin
                         if id[mid] < id[i] then
                           begin
                               ans := mid;
                               d := mid+1;
                           end
                         else c := mid-1;
                     end
                   else if a[mid] > key then c := mid-1
                    else d := mid+1;
               end;
             exit(ans);
        end;
{***************************************************************************}
procedure main; inline;
var i,j,d : longint;
        begin
             sort(1,n);
             for i := 1 to n do
              for d := 1 to 100 do
               begin
                  j := find(i,a[i]-d);
                  f[i,d] := f[j,d]+1;
               end;
             for i := 1 to n do
              for d := 1 to 100 do
               if f[i,d] > res then res := f[i,d];
             writeln(res);
        end;
{***************************************************************************}
begin
    //  assign(input,'LEM5.INP'); reset(input);
    //  assign(output,'LEM5.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do
        begin
            read(a[i]);
            id[i] := i;
        end;
      main;
end.
