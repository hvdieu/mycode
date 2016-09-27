Const   maxn = 300001;
        maxm = 1500;

Type    dt = record
        x1,y1,x2,y2 : longint;
        a,b,c     :       longint;
        end;
        tron = record
        x,y,r   :       longint;
        end;

Var     n,m,i,res     :       longint;
        f       :       array [1..maxn] of dt;
        l       :       array [1..maxm] of tron;

function ucln(a,b : longint) : longint;
        begin
             if b = 0 then exit(a)
              else exit(ucln(b,a mod b));
        end;

procedure swap(var xx,yy : dt);
var temp : dt;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,keya,keyb,keyc,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h;
            k := l + random(h-l+1);
            keya := f[k].a; keyb := f[k].b; keyc := f[k].c;
            repeat
             while (f[i].a < keya) do inc(i);
             while (f[j].a > keya) do dec(j);
             if i <= j then
              begin
                  if i < j then swap(f[i],f[j]);
                  inc(i); dec(j);
              end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

procedure init;
var i,j,temp : longint;
        begin
             for i := 1 to n do with f[i] do
               begin
                   a := y2 - y1;
                   b := x1 - x2;
                   c := y1*x2 - x1*y2;
                   temp := ucln(abs(a),abs(b));
                   temp := ucln(temp,abs(c));
                   if temp <> 0 then
                   begin
                     if (a < 0) then
                       begin
                          a := abs(a) div temp;
                          b := -b;
                          c := -c;
                       end
                     else a := a div temp;
                    if b < 0 then b := -1*(abs(b) div temp)
                     else b := b div temp;
                    if c < 0 then c := -1*(abs(c) div temp)
                     else c := c div temp;
                   end;
               end;
        end;

function kc(x1,y1,x2,y2 : longint) : double;
        begin
            kc := sqrt ( sqr(x1-x2) + sqr(y1-y2) );
        end;

function khacphia(x1,y1,x2,y2,a,b,c : double) : boolean;
var t1,t2 : double;
        begin
            t1 := a*x1 + b*y1 + c;
            t2 := a*x2 + b*y2 + c;
            if t1*t2 <= 0 then exit(true)
             else exit(false);
        end;

function find(a1,b1,c1 : longint) : longint;
var d,c,mid,ans : longint;
        begin
             d := 1; c := n;
             ans := 0;
             while d <= c do
               begin
                   mid := (d+c) div 2;
                   if f[mid].a = a1 then
                     begin
                         ans := mid;
                         c := mid - 1;
                     end
                   else if f[mid].a < a1 then d := mid + 1
                    else c := mid - 1;

               end;
             exit(ans);
        end;


function check(x1,y1,x2,y2 : longint) : longint;
var i,j,temp,vt,t : longint;
    ttx,tty,a1,b1,c1,a2,b2,c2 : longint;
        begin
              ttx := x1+x2; tty := y1+y2;
              a1 := x1 - x2; b1 := y1 - y2; c1 :=  -a1*ttx - b1*tty;
              a1 := 2*a1; b1 := 2*b1;
              a2 := y2-y1; b2 := x1-x2; c2 := y1*x2 - x1*y2;
              temp := ucln(abs(a1),abs(b1));
              temp := ucln(temp,abs(c1));
              if temp <> 0 then
                  begin
                     if (a1 < 0) then
                       begin
                          a1 := abs(a1) div temp;
                          b1 := -b1;
                          c1 := -c1;
                       end
                     else a1 := a1 div temp;
                    if b1 < 0 then b1 := -1*(abs(b1) div temp)
                     else b1 := b1 div temp;
                    if c1 < 0 then c1 := -1*(abs(c1) div temp)
                     else c1 := c1 div temp;
                 end;
              vt := find(a1,b1,c1);
              if vt = 0 then exit(0);
              t := 0;
              for i := vt to n do
                with f[i] do
                 begin
                     if a <> a1 then break;
                     if (a = a1) and (b=b1) and (c=c1)
                      and khacphia(x1,y1,x2,y2,a2,b2,c2) then inc(t);
                 end;
              exit(t);

        end;

procedure main;
var i,j : longint;
        begin
             init;
             for i := 1 to m-1 do
              for j := i+1 to m do
               begin
                if (l[i].r = l[j].r) and
                 (kc(l[i].x,l[i].y,l[j].x,l[j].y) > 2*l[i].r) then
                  res := res + check(l[i].x,l[i].y,l[j].x,l[j].y)
               end;
             write(res);
        end;

begin
   //  assign(input,'owls.inp'); reset(input);
   //  assign(output,'owls.out'); rewrite(output);
     readln(n,m);
     for i := 1 to n do with f[i] do read(x1,y1,x2,y2);
     for i := 1 to m do with l[i] do read(x,y,r);
     main;
end.




































