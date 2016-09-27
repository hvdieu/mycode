Const   inp = 'QOS.INP';
        out = 'QOS.OUT';
        maxn = 1001;
        maxm = 100001;
        maxw = 999999999;

Var     n,m,t,k,bound,count,s,sl :       longint;
        x,y,l,ke,next,w   :       array [1..maxm] of longint;
        d,head       :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        vt      :       array [1..maxn] of longint;
        check   :       array [1..1000,0..50000] of boolean;
        f       :       array [1..1000,0..50000] of int64;

{***************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n,m,t,k);
            for i := 1 to m do readln(x[i],y[i],l[i]);
        end;
{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure sort(d,c : longint);
var i,j,k,k1,k2 : longint;
        begin
            if d >= c then exit;
            i := d; j := c; k := d+random(c-d+1);
            k1 := x[k]; k2 := y[k];
            repeat
               while (x[i]<k1) or ((x[i]=k1) and (y[i]>k2)) do inc(i);
               while (x[j]>k1) or ((x[j]=k1) and (y[j]<k2)) do dec(j);
               if i <= j then
                begin
                    if i < j then
                     begin
                         swap(x[i],x[j]);
                         swap(y[i],y[j]);
                         swap(l[i],l[j]);
                     end;
                    inc(i); dec(j);
                end;
            until i > j;
            sort(d,j); sort(i,c);
        end;
{***************************************************************************}
procedure dij;
var i,j,temp,u,v : longint;
        begin
            for i := 1 to n do d[i] := maxw;
            d[t] := 0;
            fillchar(free,sizeof(free),true);
            repeat
               u := 0; temp := maxw;
               for i := 1 to n do
                if free[i] and (d[i] < temp) then
                 begin
                     u := i; temp := d[i];
                 end;
               if u = 0 then break;
               free[u] := false; j := head[u];
               while j <> 0 do
                begin
                    v := ke[j];
                    if free[v] and (d[v] > d[u]+w[j]) then d[v] := d[u]+w[j];
                    j := next[j];
                end;
            until false;
        end;
{***************************************************************************}
procedure khoitao;
var i,j,u,v,dd,temp : longint;
        begin
            sort(1,m);
            for i := 1 to m do
             begin
                 u := x[i]; v := y[i]; dd := l[i];
                 ke[i] := u; next[i] := head[v]; w[i] := dd; head[v] := i;
             end;
            dij;
            temp := maxlongint;
            fillchar(head,sizeof(head),0);
            fillchar(w,sizeof(w),0);
            for i := 1 to m do
             begin
                 u := x[i]; v := y[i]; dd := l[i];
                 ke[i] := v; next[i] := head[u]; w[i] := dd; head[u] := i;
                 if dd < temp then temp := dd;
             end;
            bound := d[1] + temp;
        end;
{***************************************************************************}
procedure ghi(sl : longint);
var i,j : longint;
        begin
           writeln(sl);
           for i := 1 to sl do write(vt[i],' ');
           halt;
        end;
{***************************************************************************}
procedure ql(i : longint);
var j,v,u : longint;
        begin
            u := vt[i];
            if u = t then
             begin
                 if s <= bound then inc(count);
                 if count = k then ghi(i);
                 exit;
             end;
            j := head[u];
            while j <> 0 do
             begin
                 v := ke[j];
                 if (s+w[j] <= bound) then
                   begin
                       vt[i+1] := v;
                       s := s+ w[j];
                       ql(i+1);
                       s := s- w[j];
                   end;
                 j := next[j];
             end;
        end;
{***************************************************************************}
procedure sub1;
var i,j,temp,u,v,dd : longint;
        begin
            if d[1] = maxw then
             begin
                 write(-1);
                 exit;
             end;
            vt[1] := 1;
            fillchar(free,sizeof(free),true);
            s := 0;
            ql(1);
            write(-1);
        end;
{***************************************************************************}
function tinh(u,dd : longint) : longint;
var j,v : longint;
    res : int64;
        begin
            if check[u,dd] then exit(f[u,dd]);
            if u = t then
             begin
                 f[u,dd] := 1;
                 check[u,dd] := true;
                 exit(1);
             end;
            j := head[u];
            res := 0;
            while j <> 0 do
             begin
                v := ke[j];
                if free[v] and (dd-w[j] >= 0) and (d[v] <= dd) then
                 begin
                     free[v] := false;
                     res := res + tinh(v,dd-w[j]);
                     if res >= k then break;
                     free[v] := true;
                 end;
                j := next[j];
             end;
            f[u,dd] := res;
            check[u,dd] := true;
            exit(res);
        end;
{***************************************************************************}
procedure truyvet(u,dd : longint);
var j,v : longint;
        begin
            inc(sl); vt[sl] := u;
            if u = t then exit;
            j := head[u];
            while j <> 0 do
             begin
                 v := ke[j];
                 if (d[v] <= dd) and (dd-w[j]>=0) then
                  begin
                      if f[v,dd-w[j]] < k then k := k - f[v,dd-w[j]]
                       else
                        begin
                          truyvet(v,dd-w[j]);
                          exit;
                        end;
                  end;
                 j := next[j];
             end;
        end;
{***************************************************************************}
procedure sub2;
var i,j : longint;
        begin
            if bound >= maxw then
             begin
                 writeln(-1);
                 exit;
             end;
            fillchar(free,sizeof(free),true);
            free[1] := false;
            tinh(1,bound);
            if f[1,bound] < k then
             begin
                 write(-1);
                 exit;
             end;
            fillchar(free,sizeof(free),true);
            truyvet(1,bound);
            ghi(sl);
        end;
{***************************************************************************}
begin
     nhap;
     khoitao;
     if n <= 20 then sub1
      else sub2;
end.

