{$inline on}
Const   maxn = 30001;

Var     x,y,res,t,id     :       array [1..maxn] of longint;
        n,i     :       longint;

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
{***************************************************************************}
procedure update(i,val : longint);
        begin
            while i <= n do
              begin
                  t[i] := max(t[i],val);
                  inc(i,i and (-i));
              end;
        end;
{***************************************************************************}
function get(i : longint) : longint;
var s : longint;
        begin
            s := 0;
            while i > 0 do
              begin
                  s := max(s,t[i]);
                  dec(i,i and (-i));
              end;
            exit(s);
        end;
{***************************************************************************}
procedure sort(l,h : longint);
var i,j,k,k1,k2 : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := y[k]; k2 := x[k];
            repeat
                while (y[i] > k1) or ((y[i]=k1) and (x[i] > k2)) do inc(i);
                while (y[j] < k1) or ((y[j]=k1) and (x[j] < k2)) do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(x[i],x[j]);
                            swap(y[i],y[j]);
                            swap(id[i],id[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
procedure main; inline;
var i,j : longint;
        begin
            sort(1,n);

            for i := 1 to n do
              begin
                  j := get(x[i]-1);
                  res[id[i]] := j+1;
                  update(x[i],j+1);
              end;
            for i := 1 to n do writeln(res[i]);
        end;
{***************************************************************************}
begin
   //  assign(input,'SKWLTH.INP'); reset(input);
   //  assign(output,'SKWLTH.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n do
      begin
          read(x[i],y[i]);
          id[i] := i;
      end;
     main;
end.