Const   inp = '';
        out = '';
        maxn = 1001;

Var     n,r1,r2,r3       :       longint;
        x1,y1,x2,y2 : array [1..maxn] of longint;
        a1,b1,c1,id : array [1..maxn,1..maxn] of int64;
        ok      :       boolean;
        a,b,c   :       int64;

{***************************************************************************}
procedure nhap;
var i : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n do readln(x1[i],y1[i]);
            for i := 1 to n do readln(x2[i],y2[i]);
        end;
{****************************************************************************}
function gcd(a,b : int64) : int64;
        begin
            if b = 0 then exit(a)
             else exit(gcd(b,a mod b));
        end;
{****************************************************************************}
procedure xay(x1,y1,x2,y2 : longint);
var t : int64;
        begin
            a := y2-y1;
            b := x1-x2;
            c := int64(y1)*(x2-x1)-int64(x1)*(y2-y1);
            if a < 0 then
             begin
                 a:=a*-1; b := b*-1; c := c*-1;
             end;
            if (a<>0) and (b<>0) and (c<>0) then
             begin
                t := gcd(a,abs(b)); t := gcd(t,abs(c));
                a := a div t; b := b div t; c := c div t;
             end;
        end;
{****************************************************************************}
function check(x,y : longint) : boolean;
var temp : int64;
        begin
            temp := a*x+b*y+c;
            if temp = 0 then exit(true)
             else exit(false);
        end;
{****************************************************************************}
procedure sub1;
var i,j,k : longint;
        begin
            ok := false;
            for i := 1 to n-1 do
              for j := i+1 to n do
               begin
                   xay(x1[i],y1[i],x1[j],y1[j]);
                   for k := 1 to n do
                    if check(x2[k],y2[k]) then
                     begin
                         ok := true;
                         r1 := i; r2 := j; r3 := k+n;
                         exit;
                     end;
               end;
            for i := 1 to n-1 do
             for j := i+1 to n do
              begin
                  xay(x2[i],y2[i],x2[j],y2[j]);
                  for k := 1 to n do
                   if check(x1[k],y1[k]) then
                    begin
                        ok := true;
                        r1 := i+n; r2 := j+n; r3 := k;
                        exit;
                    end;
              end;
        end;
{****************************************************************************}
procedure swap(var xx,yy : int64);
var temp : int64;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{****************************************************************************}
procedure sort(l,h,t : longint);
var i,j,k : longint;
    k1,k2,k3 : int64;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := a1[t,k]; k2 := b1[t,k]; k3 := c1[t,k];
            repeat
               while (a1[t,i]<k1) or ((a1[t,i]=k1) and (b1[t,i]<k2)) or ((a1[t,i]=k1) and (b1[t,i]=k2) and (c1[t,i]<k3)) do inc(i);
               while (a1[t,j]>k1) or ((a1[t,j]=k1) and (b1[t,j]>k2)) or ((a1[t,j]=k1) and (b1[t,j]=k2) and (c1[t,j]>k3)) do dec(j);
               if i <= j then
                begin
                    if i < j then
                     begin
                         swap(a1[t,i],a1[t,j]);
                         swap(b1[t,i],b1[t,j]);
                         swap(c1[t,i],c1[t,j]);
                         swap(id[t,i],id[t,j]);
                     end;
                    inc(i); dec(j);
                end;
            until i > j;
            sort(l,j,t); sort(i,h,t);
        end;
{****************************************************************************}
function find(a,b,c : int64; t : longint) : longint;
var ans,l,r,mid : longint;
        begin
            l := 1; r := n; ans := 0;
            while l <= r do
             begin
                 mid := (l+r) div 2;
                 if (a1[t,mid]=a) and (b1[t,mid]=b) and (c1[t,mid]=c) then exit(mid);
                 if (a1[t,mid]>a) then r := mid-1
                 else if (a1[t,mid]<a) then l:=mid+1
                 else if (a1[t,mid]=a) and (b1[t,mid]<b) then l:=mid+1
                 else if (a1[t,mid]=a) and (b1[t,mid]>b) then r:=mid-1
                 else if (a1[t,mid]=a) and (b1[t,mid]=b) and (c1[t,mid]>c) then r:=mid-1
                 else l:=mid+1;
             end;
            exit(0);
        end;
{****************************************************************************}
procedure sub2;
var i,j,k,t : longint;
        begin
            ok := false;
            for i := 1 to n do
             for j := 1 to n do
              begin
                  xay(x1[i],y1[i],x2[j],y2[j]);
                  a1[i,j] := a; b1[i,j] := b; c1[i,j] := c;
                  id[i,j] := j;
              end;
            for i := 1 to n do sort(1,n,i);
            for i := 1 to n-1 do
             for j := i+1 to n do
               begin
                   xay(x1[i],y1[i],x1[j],y1[j]);
                   k := find(a,b,c,i);
                   if k <> 0 then
                    begin
                        ok := true;
                        r1 := i; r2 := j; r3 := id[i,k]+n;
                        exit;
                    end;
                   k := find(a,b,c,j);
                   if k <> 0 then
                    begin
                        ok := true;
                        r1 := i; r2 := j; r3 := id[j,k]+n;
                        exit;
                    end;
               end;

             for i := 1 to n do
             for j := 1 to n do
              begin
                  xay(x2[i],y2[i],x1[j],y1[j]);
                  id[i,j] := j;
                  a1[i,j] := a; b1[i,j] := b; c1[i,j] := c;
              end;
            for i := 1 to n do sort(1,n,i);
            for i := 1 to n-1 do
             for j := i+1 to n do
               begin
                   xay(x2[i],y2[i],x2[j],y2[j]);
                   k := find(a,b,c,i);
                   if k <> 0 then
                    begin
                        ok := true;
                        r1 := i+n; r2 := j+n; r3 := id[i,k];
                        exit;
                    end;
                   k := find(a,b,c,j);
                   if k <> 0 then
                    begin
                        ok := true;
                        r1 := i+n; r2 := j+n; r3 := id[j,k];
                        exit;
                    end;
               end;
        end;
{****************************************************************************}
begin
     nhap;
     if n <= 100 then sub1
      else sub2;
     if ok then writeln(r1,' ',r2,' ',r3)
      else writeln(-1);
end.


