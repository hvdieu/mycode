Const   inp = 'ballgame.out';
        inp2 = 'ballgame.inp';
        out = 'asd.out';

var     i,j,k,n : longint;
        fi,f : text;
        x,y       :       array [1..2000] of longint;
        a,b,c     :       int64;

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
           { if a < 0 then
             begin
                 a:=a*-1; b := b*-1; c := c*-1;
             end;
            if (a<>0) and (b<>0) and (c<>0) then
             begin
                t := gcd(a,abs(b)); t := gcd(t,abs(c));
                a := a div t; b := b div t; c := c div t;
             end;   }

        end;

function check(x,y : longint) : boolean;
var temp : int64;
        begin
            temp := a*x+b*y+c;
            if temp = 0 then exit(true)
             else exit(false);
        end;

begin
     assign(fi,inp); reset(fi);
     assign(f,inp2); reset(f);
     assign(output,out); rewrite(output);
     readln(f,n);
     for i := 1 to 2*n do read(f,x[i],y[i]);
     readln(fi,i,j,k);
     xay(x[i],y[i],x[j],y[j]);
     if check(x[k],y[k]) then write('DUNG')
      else write('SAI');
end.
