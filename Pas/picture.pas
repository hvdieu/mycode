uses math;
Const   maxn = 1000001;

Type    arr     =       array [1..maxn] of longint;

Var     a,b     :       array [1..maxn] of longint;
        s       :       array [0..maxn] of qword;
        n,m,max1,max2     :       longint;
        res     :       qword;

{**************************************************************************}
procedure nhap;
var i : longint;
        begin
            assign(input,'PICTURE.INP'); reset(input);
            assign(output,'PICTURE.OUT'); rewrite(output);
            readln(m,n);
            for i := 1 to m do
            begin
              read(a[i]);
              max1 := max(max1,a[i]);
            end;
            for i := 1 to n do
            begin
              read(b[i]);
              max2 := max(max2,b[i]);
            end;
        end;
{**************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{**************************************************************************}
procedure sort(l,h : longint; var k : arr);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := k[l+random(h-l+1)];
            repeat
               while k[i] < key do inc(i);
               while k[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then swap(k[i],k[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j,k); sort(i,h,k);
        end;
{**************************************************************************}
function find(key : longint) : longint;
var d,c,mid,ans : longint;
        begin
            if (key > b[n]) then exit(0);
            d := 1; c := n; ans := 0;
            while d <= c do
              begin
                  mid := (d+c) shr 1;
                  if b[mid] >= key then
                    begin
                        ans := mid;
                        c := mid-1;
                    end
                  else d := mid+1;
              end;
            exit(ans);
        end;
{***************************************************************************}
procedure main;
var i,j,u : longint;
        begin
            if max1 <> max2 then
              begin
                  writeln('NO');
                  exit;
              end;
            sort(1,n,b);
            for i := 1 to n do s[i] := s[i-1] + b[i];
            for i := 1 to m do
              begin
                  u := find(a[i])-1;
                  res := res + s[u] + a[i]*(n-u);
              end;
            writeln(res);
        end;
{***************************************************************************}
begin
    nhap;
    main;
end.
