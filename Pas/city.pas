Const   inp = 'city.inp';
        out = 'city.out';
        maxn = 100001;
        maxw = 999999999;
        oo = 1000000000;
        h : array [1..4] of integer = (-1,0,1,0);
        c : array [1..4] of integer = (0,1,0,-1);

Type    arr     =       array [0..maxn] of longint;

Var     n,m,left,right       :       longint;
        x,y,id     :       array [0..maxn] of longint;
        d,queue,head       :       array [1..maxn] of longint;
        ke,next :     array [1..4*maxn] of longint;
        free    :     array [1..maxn] of boolean;
        res     :     int64;

{***************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n do read(x[i],y[i]);
        end;
{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure sort(l,h : longint; var x,y,id : arr);
var i,j,k,k1,k2 : longint;
        begin
            if l>=h then exit;
            i:=l; j:=h; k:=l+random(h-l+1);
            k1:=x[k]; k2:=y[k];
            repeat
            while (x[i]<k1) or ((x[i]=k1) and (y[i]<k2)) do inc(i);
            while (x[j]>k1) or ((x[j]=k1) and (y[j]>k2)) do dec(j);
            if i <= j then
             begin
                 swap(x[i],x[j]); swap(y[i],y[j]);
                 swap(id[i],id[j]);
                 inc(i); dec(j);
             end;
            until i > j;
            sort(l,j,x,y,id); sort(i,h,x,y,id);
        end;
{***************************************************************************}
procedure sort2(l,h : longint;var x : arr);
var i,j,k,k1,k2 : longint;
        begin
            if l>=h then exit;
            i:=l; j:=h; k:=l+random(h-l+1);
            k1:=x[k]; k2:=y[k];
            repeat
            while (x[i]<k1) do inc(i);
            while (x[j]>k1) do dec(j);
            if i <= j then
             begin
                 swap(x[i],x[j]);
                 inc(i); dec(j);
             end;
            until i > j;
            sort2(l,j,x); sort2(i,h,x);
        end;
{***************************************************************************}
procedure add(u,v : longint);
        begin
            inc(m);
            ke[m] := v; next[m] := head[u]; head[u] := m;
        end;
{***************************************************************************}
procedure khoitao;
var i,j,d : longint;
        begin
            sort(1,n,x,y,id);
            x[0] := maxlongint; y[0] := x[0]; x[n+1] := x[0]; y[n+1]:=y[0];
            m := 0;
            for i := 1 to n do id[i] := i;
            for i := 1 to n do
             begin
                 if (x[i]=x[i-1]) and (y[i]=y[i-1]+1) then add(i,i-1);
                 if (x[i]=x[i+1]) and (y[i]=y[i+1]-1) then add(i,i+1);
             end;
            sort(1,n,y,x,id);
            for i := 1 to n do
             begin
                 if (y[i]=y[i-1]) and (x[i]=x[i-1]+1) then add(id[i],id[i-1]);
                 if (y[i]=y[i+1]) and (x[i]=x[i+1]-1) then add(id[i],id[i+1]);
             end;
        end;
{***************************************************************************}
procedure sub1;
var i,j,k,u,v : longint;
        begin
            khoitao;
            for i := 1 to n do
             begin
                d[i] := 0;
                fillchar(free,sizeof(free),true);
                left := 0; right := 1; queue[1] := i; free[i] := false;
                while left < right do
                 begin
                     inc(left); u := queue[left];
                     j := head[u];
                     while j <> 0 do
                      begin
                          v := ke[j];
                          if free[v] then
                            begin
                                free[v] := false;
                                inc(right); queue[right] := v;
                                d[v] := d[u]+1;
                            end;
                          j := next[j];
                      end;
                 end;
                for j := 1 to n do inc(res,d[j]);
             end;
             writeln((res div 2) mod oo);
        end;
{****************************************************************************}
procedure sub2;
var i,j,tmp : longint;
        begin
            sort2(1,n,x);
            sort2(1,n,y);
            for i := 2 to n do
              begin
                  tmp := x[i]-x[i-1];
                  res := (res + int64(tmp)*((i-1)*(n-i+1))) mod oo;
                  tmp := y[i]-y[i-1];
                  res := (res + int64(tmp)*((i-1)*(n-i+1))) mod oo;
              end;
            writeln(res);
        end;
{***************************************************************************}
begin
    nhap;
    if n <= 2000 then sub1
     else sub2;
end.
