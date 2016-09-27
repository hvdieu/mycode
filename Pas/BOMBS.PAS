uses math;
Const   maxn = 100001;
Var     x,y     :       array [1..maxn] of longint;
        n,i,res       :       longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,keyx,keyy,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h;
            k := l + random(h-l+1);
            keyx := abs(x[k]);
            keyy := abs(y[k]);
            repeat
                 while (abs(x[i]) < keyx) or ((abs(x[i]) = keyx) and (abs(y[i]) < keyy)) do inc(i);
                 while (abs(x[j]) > keyx) or ((abs(x[j]) = keyx) and (abs(y[j]) > keyy)) do dec(j);
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

procedure main;
var i,j : longint;
        begin
            sort(1,n);
            for i := 1 to n do
              begin
                  if x[i] <> 0 then inc(res,2);
                  if y[i] <> 0 then inc(res,2);
                  inc(res,2);
              end;
            writeln(res);
            for i := 1 to n do
              begin
                  if x[i] > 0 then writeln(1,' ',x[i],' R')
                   else if x[i] < 0 then writeln(1,' ',abs(x[i]),' L');
                  if y[i] > 0 then writeln(1,' ',y[i],' U')
                   else if y[i] < 0 then writeln(1,' ',abs(y[i]),' D');
                  writeln(2);
                  if x[i] > 0 then writeln(1,' ',x[i],' L')
                   else if x[i] < 0 then writeln(1,' ',abs(x[i]),' R');
                  if y[i] > 0 then writeln(1,' ',y[i],' D')
                   else if y[i] < 0 then writeln(1,' ',abs(y[i]),' U');
                  writeln(3);
              end;
        end;

begin
    // assign(input,'bombs.inp'); reset(input);
   //  assign(output,'bombs.out'); rewrite(output);
     readln(n);
     for i := 1 to n do read(x[i],y[i]);
     main;
end.
