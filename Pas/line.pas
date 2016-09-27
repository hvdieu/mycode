Const   maxn = 100001;
Var     n,i,dem,p     :       longint;
        a,b,c   :    int64;
        x,y     :       array [1..maxn] of int64;

procedure tao(x1,y1,x2,y2 : int64);
        begin
            a := y2 - y1;
            b := x1 - x2;
            c := y1*(x2-x1) - x1*(y2-y1);
        end;

procedure main;
var i,j,u,v : longint;
        begin
            p := round(n*3/5);
            repeat
                 u := random(n)+1;
                 v := random(n)+1;
                 dem := 0;
                 while v = u do v := random(n)+1;
                 tao(x[u],y[u],x[v],y[v]);
                 for i := 1 to n do
                   if a*x[i]+b*y[i]+c = 0 then inc(dem);
                 if dem >= p then
                   begin
                       writeln(dem);
                       for i := 1 to n do
                        if a*x[i]+b*y[i]+c = 0 then write(i,' ');
                       exit;
                   end;
            until false;
        end;

begin
      randomize;
      assign(input,'LINE.INP'); reset(input);
      assign(output,'LINE.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do readln(x[i],y[i]);
      main;
end.
