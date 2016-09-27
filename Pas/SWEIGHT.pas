Uses math;
Const   maxn = 200001;
Var     n,i,res     :       longint;
        a,st,t       :       array [1..maxn] of longint;
        f,g       :  array [1..maxn] of longint;

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
            i := l; j := h; k := st[l+random(h-l+1)];
            repeat
                while st[i] < k do inc(i);
                while st[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then swap(st[i],st[j]);
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{*************************************************************************}
function find(key : longint) : longint;
var d,c,mid,ans : longint;
        begin
             d := 1; c := n; ans := 0;
             while (d <= c) do
               begin
                   mid := (d+c) shr 1;
                   if st[mid] = key then
                     begin
                       ans := mid; c := mid-1;
                     end
                   else if st[mid] > key then c := mid-1
                    else d := mid+1;
               end;
             exit(ans);
        end;
{*************************************************************************}
procedure update(i,val : longint);
        begin
            while (i <= n) do
              begin
                  t[i] := max(t[i],val);
                  inc(i,i and (-i));
              end;
        end;
{*************************************************************************}
function get(i : longint) : longint;
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
{*************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            sort(1,n);
            for i := 1 to n do a[i] := find(a[i]);
            f[n] := 1;
            for i := n-1 downto 1 do
             if a[i] < a[i+1] then f[i] := f[i+1]+1
              else f[i] := 1;
            g[1] := 1;
            for i := 2 to n do
             if a[i] > a[i-1] then g[i] := g[i-1]+1
              else g[i] := 1;
        end;
{*************************************************************************}
procedure main;
var i,j : longint;
        begin
            for i := 1 to n do
              begin
                  res := max(res,f[i] + get(a[i]-1));
                  update(a[i],g[i]);
              end;
            writeln(res);
        end;
{*************************************************************************}
begin
     assign(input,'SWEIGHT.INP'); reset(input);
     assign(output,'SWEIGHT.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n do
       begin
         read(a[i]);
         st[i] := a[i];
       end;
     khoitao;
     main;
end.