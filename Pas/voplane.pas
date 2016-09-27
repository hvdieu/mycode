Uses math;
Const   inp = 'voplane.inp';
        out = 'voplane.out';
        maxn = 26;

Var     t,n,ntest,res,i,sl,prev     :       longint;
        x,y     :       array [0..maxn] of longint;
        cat,kq     :       array [0..maxn] of longint;
        next    :       array [1..maxn,0..maxn,0..maxn] of longint;
        d,c,dd,vt     :       array [1..maxn] of longint;

{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure sort(l,h : longint);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := x[l+random(h-l+1)];
            repeat
               while x[i] < key do inc(i);
               while x[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then
                     begin
                       swap(x[i],x[j]);
                       swap(y[i],y[j]);
                     end;
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
procedure sort2(dem : longint);
var i,j : longint;
        begin
             fillchar(dd,sizeof(dd),0); j := 0;
             for i := 1 to dem do dd[d[i]] := c[i];
             for i := 1 to n do
              if dd[i] <> 0 then
                begin
                    inc(j); d[j] := i; c[j] := dd[i];
                end;
        end;
{***************************************************************************}
procedure xuly(sl : longint);
var i,j,dem,u,v,last,count : longint;
        begin
            j := 1; dem := 0; cat[sl+1] := n;
            for i := 1 to sl+1 do
              begin
                  u := cat[i-1]+1; v := cat[i];
                  while (j <= n) and (x[j] <= v) do
                    begin
                        if next[y[j],u,v] <> 0 then
                          begin
                             inc(dem);
                             d[dem] := y[j]; c[dem] := next[y[j],u,v];
                          end;
                        inc(j);
                    end;
              end;
            sort2(dem); count := 1; last := c[1]-1;
            for i := 2 to dem do
             if c[i] <= last then last := c[i]-1
              else if d[i] > last then
                begin
                    inc(count);
                    last := c[i]-1;
                end;
            if count + sl < res then res := count+sl;
        end;
{***************************************************************************}
procedure khoitao;
var i,j,u,v,temp,vt : longint;
        begin
            fillchar(next,sizeof(next),0);
            for u := 1 to n-1 do
             for v := u+1 to n do
               begin
                   for i := u to v do
                     begin
                         vt := n+1;
                         for j := u to v do
                          if (y[j] > y[i]) and (y[j] < vt) then vt := y[j];
                         if vt < n+1 then next[y[i],u,v] := vt;
                     end;
               end;
        end;
{***************************************************************************}
function lay(x,i : longint) : integer;
        begin
            lay := (x shr (i-1)) and 1;
        end;
{***************************************************************************}
procedure build(tt : longint);
var i,j,sl : longint;
        begin
            sl := 0;
            if (lay(tt,1)=1) or (lay(tt,n-1)=1) then exit;
            for i := 2 to n-2 do
             if lay(tt,i) = 1 then
              begin
                  inc(sl); cat[sl] := i;
                  if cat[sl]=cat[sl-1]+1 then exit;
              end;
            cat[sl+1] := n;
            if sl < res then xuly(sl);
        end;
{***************************************************************************}
procedure try(i : integer);
var j,gt : longint;
        begin
            if i > n-2 then
             begin
                 xuly(sl);
                 exit;
             end;

            for j := 0 to 1 do
              begin
                  inc(sl,j);
                  if j*prev=1 then
                  begin
                    dec(sl,j);
                    exit;
                  end;
                  if j=1 then cat[sl] := i;
                  gt := prev;
                  prev := j;
                  try(i+1);
                  dec(sl,j);
                  prev := gt;
              end;
        end;
{***************************************************************************}
procedure main;
var i,j,tt : longint;
        begin
            sort(1,n);
            khoitao;
            res := n-1; sl := 0; prev := 0;
            try(2);
            writeln(res);
        end;
{***************************************************************************}
begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(ntest);
     while ntest > 0 do
      begin
        dec(ntest); readln(n);
        for i := 1 to n do readln(x[i],y[i]);
        if n = 1 then writeln(0)
         else if n = 2 then writeln(1)
          else if n = 3 then writeln(2)
           else main;
      end;
end.
