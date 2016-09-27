Uses math;
Const   inp = 'PERIOD.INP';
        out = 'PERIOD.OUT';
        maxn = 5000001;

Type    arr     =       array [1..2*maxn] of longint;

Var     n,top,bot      :       longint;
        x,p,q,oo,res : int64;
        a,st,pos       :       array [1..2*maxn] of int64;
       // f,t     :       array [1..4*maxn] of int64;

{**************************************************************************}
procedure nhap;
var i : longint;
        begin
           // assign(input,inp); reset(input);
           // assign(output,out); rewrite(output);
            readln(n,x);
            readln(p,q,oo);
        end;
{**************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            for i := 1 to n do
             a[i] := (p*i) mod oo + q;
          //  fillchar(f,sizeof(f),0);
          //  fillchar(t,sizeof(t),0);
        end;
{**************************************************************************}
{procedure sub1;
var i,j : longint;
    dem,temp : int64;
        begin
             res := 99999999999999999;
             for i := 1 to n do
               begin
                    dem := 0; temp := 0;
                   for j := i to n do
                     begin
                         inc(dem);
                         if a[j] + x*dem > temp then temp := a[j]+x*dem;
                     end;
                   for j := 1 to i-1 do
                     begin
                         inc(dem);
                         if a[j]+x*dem > temp then temp := a[j]+x*dem;
                     end;
                   if temp < res then res := temp;
               end;
             writeln(res);
        end;}
{**************************************************************************}
{procedure down(i,con1,con2 : longint);
        begin
              inc(f[con1],f[i]);
              inc(f[con2],f[i]);
              inc(t[con1],f[i]);
              inc(t[con2],f[i]);
              f[i] := 0;
        end; }
{***************************************************************************}
{procedure update(i,lo,hi,u,v : longint; x : int64);
var mid,con1,con2 : longint;
        begin
            if (lo = u) and (hi = v) then
              begin
                    inc(f[i],x);
                    inc(t[i],x);
                    exit;
              end;

            mid := (lo+hi) shr 1;
            con1 := i*2; con2 := con1 + 1;
            down(i,con1,con2);
            if u <= mid then update(con1,lo,mid,u,min(mid,v),x);
            if v > mid then update(con2,mid+1,hi,max(mid+1,u),v,x);
            t[i] := max(t[con1], t[con2]);
        end; }
{***************************************************************************}
{function get(i,lo,hi,u,v : longint) : int64;
var mid,con1,con2 : longint;
    ans : int64;
        begin
             if (lo = u) and (hi = v) then exit(t[i]);

             mid := (lo+hi) shr 1;
             con1 := i*2; con2 := con1 + 1;
             down(i,con1,con2);
             ans := -99999999999999999;
             if u <= mid then ans := max(ans, get(con1,lo,mid,u,min(mid,v)));
             if v > mid then ans := max(ans, get(con2,mid+1,hi,max(mid+1,u),v));
             exit(ans);
        end;}
{***************************************************************************}
{procedure sub2;
var i,j : longint;
    dem,temp : int64;
        begin
              dem := 0; res := 99999999999999999;
              for i := 1 to n do
                begin
                    inc(dem);
                    update(1,1,n,i,i,a[i]+dem*x);
                end;
              res := get(1,1,n,1,n);
              for i := 1 to n-1 do
                begin
                    update(1,1,n,1,n,-x);
                    update(1,1,n,i,i,dem*x);
                    temp := get(1,1,n,1,n);
                    if temp < res then res := temp;
                end;
              writeln(res);
        end; }
{**************************************************************************}
procedure sub3;
var i,j : longint;
        begin
           res := int64(1) shl 60;
           for i := n+1 to 2*n do a[i] := a[i-n];
           for i := 1 to 2*n do a[i] := a[i]+i*x;
           top := 0; bot := 1;
           for i := 1 to n-1 do
             begin
                 while (top >= bot) and (a[i] >= st[top]) do dec(top);
                 inc(top); st[top] := a[i]; pos[top] := i;
             end;
           for i := 1 to n do
             begin
                 while (top >= bot) and (a[i+n-1] >= st[top]) do dec(top);
                 inc(top); st[top] := a[i+n-1]; pos[top] := i+n-1;
                 if st[bot]-x*(i-1) < res then res := st[bot]-x*(i-1);
                 while (top >= bot) and (pos[bot] <= i) do inc(bot);
             end;
           writeln(res);
        end;
{**************************************************************************}
procedure main;
        begin
           // if n <= 1000 then sub1
           //  else if n <= 100000 then sub2
           //   else
             sub3;
        end;
{**************************************************************************}
procedure make;
        begin
            randomize;
            assign(output,inp); rewrite(output);
            n := 500000; x := random(1000000000)+1;
            p := random(1000000000)+1;
            q := random(1000000000)+1;
            oo := random(1000000000)+1;
            writeln(n,' ',x);
            writeln(p,' ',q,' ',oo)
        end;
{**************************************************************************}
begin
    // make;
     nhap;
     khoitao;
     main;
end.
