Uses math;
Const
    inp = '';
    out = '';
    maxn = 100001;

Var
    i,n,ntest,dem,u,v : longint;
    x,y : array [1..maxn] of longint;
    a,b,c : int64;

procedure xay(x1,y1,x2,y2 : longint);
var t : int64;
        begin
            a := y2-y1;
            b := x1-x2;
            c := int64(y1)*(x2-x1)-int64(x1)*(y2-y1);
        end;

begin
    assign(input,inp) ;reset(input);
    assign(output,out) ;rewrite(output);
    readln(ntest);
    while ntest > 0 do
      begin
          readln(n);
          dec(ntest);
          for i := 1 to n do readln(x[i],y[i]);
          repeat
            u := random(n)+1;
            v := random(n)+1;
            while v = u do v := random(n)+1;
            xay(x[u],y[u],x[v],y[v]);
            dem := 0;
            for i := 1 to n do
             if a*x[i]+b*y[i]+c=0 then inc(dem);
            if dem/n>=0.6 then
              begin
                  writeln(dem);
                  for i := 1 to n do
                   if a*x[i]+b*y[i]+c=0 then write(i,' ');
                  writeln;
                  break;
              end;
          until false;
      end;
end.