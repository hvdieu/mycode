Const   inp = 'RECT.IN';
        out = 'RECT.OUT';
        maxn = 10001;

Var     n,m       :       longint;
        a,b,startof,l     :       array [0..maxn+1] of longint;

{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n do
            begin
              read(a[i],b[i]);
              if a[i] > b[i] then swap(a[i],b[i]);
            end;
        end;
{***************************************************************************}
procedure sort(l,h : longint);
var i,j,k,k1,k2 : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := b[k]; k2 :=a[k];
            repeat
                while (b[i]<k1) or ((b[i]=k1) and (a[i]<k2)) do inc(i);
                while (b[j]>k1) or ((b[j]=k1) and (a[j]>k2)) do dec(j);
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
{***************************************************************************}
function find(i : longint) : longint;
var d,c,mid,ans,j : longint;
        begin
            d := 1; c := m;
            while d <= c do
              begin
                  mid := (d+c) shr 1;
                  j := startof[mid];
                  if a[i] >= a[j] then
                   begin
                       ans := mid;
                       d := mid+1;
                   end
                  else c := mid-1;
              end;
            exit(startof[ans]);
        end;
{***************************************************************************}
procedure main;
var i,j,k : longint;
        begin
            sort(1,n);
            a[0] := -maxlongint; a[n+1] := maxlongint;
            m := 1; l[0] := 1; startof[1] := 0;
            for i := 1 to n+1 do
              begin
                  j := find(i);
                  k := l[j]+1;
                  if k > m then
                   begin
                       m := k; startof[k] := i;
                   end
                  else if a[i] < a[startof[k]] then startof[k] := i;
                  l[i] := k;
              end;
            if l[n+1]-2 = n then write(-1)
			 else write(l[n+1]-2);
        end;
{***************************************************************************}
begin
    nhap;
    main;
end.
