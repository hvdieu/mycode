Const   inp = 'MINROAD.INP';
        out = 'MINROAD.OUT';
        maxn = 300010;

Var     a,b,n,res   :       longint;
        d,t     :       array [0..maxn] of longint;
        d1,d2   :       array [0..3010] of longint;

{***************************************************************************}
procedure nhap;
var i : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n,a,b);
            for i := 1 to n do readln(d[i],t[i]);
        end;
{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := d[l+random(h-l+1)];
            repeat
               while d[i] < k do inc(i);
               while d[j] > k do dec(j);
               if i <= j then
                 begin
                     if i < j then
                      begin
                          swap(d[i],d[j]);
                          swap(t[i],t[j]);
                      end;
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
procedure khoitao;
var i : longint;
        begin
            for i := 1 to n do
             if t[i]=1 then
               begin
                  d1[i] := d1[i-1]+1;
                  d2[i] := d2[i-1];
               end
             else begin
                     d1[i] := d1[i-1];
                     d2[i] := d2[i-1]+1;
                  end;
        end;
{***************************************************************************}
procedure sub1;
var i,j : longint;
        begin
            khoitao;
            res := maxlongint;
            for i := 1 to n do
             for j := 1 to i do
              if (d1[i]-d1[j-1]>=a) and (d2[i]-d2[j-1]>=b) then
               if d[i]-d[j] < res then res := d[i]-d[j];
            if res = maxlongint then write(-1)
              else writeln(res);
        end;
{***************************************************************************}
procedure sub2;
var i,j,da,db : longint;
        begin
            res := maxlongint;
            i := 1; j := 1; da := 0; db := 0;
            if t[i]=1 then inc(da)
             else inc(db);
            while (i <= j) and (i <= n) and (j <= n) do
             begin
                 if (da>=a) and (db>=b) then
                  begin
                      if res > d[j]-d[i] then res := d[j]-d[i];
                      if t[i]=1 then dec(da)
                       else dec(db);
                      inc(i);
                  end
                 else
                   begin
                       inc(j);
                       if t[j]=1 then inc(da)
                        else inc(db);
                   end;
             end;
            if res = maxlongint then write(-1)
             else writeln(res);
        end;
{****************************************************************************}
begin
     nhap;
     sort(1,n);
     if n <= 3000 then sub1
      else sub2;
end.