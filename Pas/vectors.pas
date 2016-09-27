Uses math;
Const   maxn = 30001;
Type    point = record
        x,y : longint;
        goc : real;
        end;

Var     n,i       :       longint;
        p       :       array [1..2*maxn] of point;
        sx,sy   :       array [0..2*maxn] of int64;
        res     :       int64;

function tinhgoc(x,y : longint) : real;
var o : real;
        begin
            if y = 0 then
             if x >= 0 then exit(0)
              else exit(pi);
            if x = 0 then
             if y >= 0 then exit(pi/2)
              else exit(3*pi/2);
            o := arctan(y/x);
            if (x > 0) and (y > 0) then exit(o);
            if (x < 0) and (y > 0) then exit(pi+o);
            if (x < 0) and (y < 0) then exit(pi+o);
            if (x > 0) and (y < 0) then exit(2*pi+o);
        end;

procedure swap(var xx,yy : point);
var temp : point;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j : longint;
    k : real;
        begin
             if l >= h then exit;
             i := l; j := h;
             k := p[l+random(h-l+1)].goc;
             repeat
                 while p[i].goc < k do inc(i);
                 while p[j].goc > k do dec(j);
                 if i <= j then
                   begin
                       if i < j then swap(p[i],p[j]);
                       inc(i); dec(j);
                   end;
             until i > j;
             sort(l,j); sort(i,h);
        end;

procedure main;
var i,j,d,c,t : longint;
    sum,xx,yy,temp : int64;
        begin
            sort(1,n);
            for i := 1 to n do
              begin
                  sx[i] := sx[i-1] + p[i].x;
                  sy[i] := sy[i-1] + p[i].y;
              end;
            for i := n+1 to n*2 do
              begin
                  sx[i] := sx[i-1] + p[i-n].x;
                  sy[i] := sy[i-1] + p[i-n].y;
              end;
           c := 1;
           for d := 1 to n do
             begin
                 xx := sx[c] - sx[d-1]; yy := sy[c] - sy[d-1];
                 temp := sqr(xx) + sqr(yy);
                 while (sqr(xx) + sqr(yy) >= temp) do
                   begin
                       temp := sqr(xx) + sqr(yy);
                       inc(c);
                       xx := sx[c] - sx[d-1]; yy := sy[c] - sy[d-1];
                       if c - d = n then break;
                   end;
                 dec(c);
                 res := max(res,temp);
             end;
        end;


begin
    // assign(input,'vectors.inp'); reset(input);
    // assign(output,'vectors.out'); rewrite(output);
     readln(n);
     for i := 1 to n do with p[i] do
       begin
         read(x,y);
         goc := tinhgoc(x,y);
       end;
     main;
     write(res);
end.
