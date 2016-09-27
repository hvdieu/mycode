Const   maxn = 1001;
Var     m,n,a,b,t,i,j,k,res,dem,top,bot         :       longint;
        c,minh,minc,maxh,maxc       :         array [1..maxn,1..maxn] of longint;
        st,p      :         array [1..maxn] of longint;

procedure main(a,b : longint);
var i,j : longint;
        begin
             if (a > m) or (b > n) then exit;
             fillchar(maxh,sizeof(maxh),0);
             fillchar(maxc,sizeof(maxc),0);
             fillchar(minh,sizeof(minh),0);
             fillchar(minc,sizeof(minc),0);
             for i := 1 to m do
               begin
                   top := 0; bot := 1;
                   for j := 1 to b-1 do
                     begin
                         while (top >= bot) and (st[top] >= c[i,j]) do dec(top);
                         inc(top);
                         st[top] := c[i,j]; p[top] := j;
                     end;
                   for j := 1 to n-b+1 do
                     begin
                         while (top >= bot) and (st[top] >= c[i,j+b-1]) do dec(top);
                         inc(top); st[top] := c[i,j+b-1]; p[top] := j+b-1;
                         minh[i,j+b-1] := c[i,p[bot]];
                         while (top >= bot) and (p[bot] <= j) do inc(bot);
                     end;
               end;
             for j := b to n do
               begin
                    top := 0; bot := 1;
                    for i := 1 to a-1 do
                      begin
                         while (top>=bot) and (st[top] >= minh[i,j]) do dec(top);
                         inc(top);
                         st[top] := minh[i,j]; p[top] := i;
                      end;
                    for i := 1 to m-a+1 do
                      begin
                          while (top >= bot) and (st[top] >= minh[i+a-1,j]) do dec(top);
                          inc(top); st[top] := minh[i+a-1,j]; p[top] := i+a-1;
                          minc[i+a-1,j] := minh[p[bot],j];
                          while (top >= bot) and (p[bot] <= i) do inc(bot);
                      end;
               end;

             for i := 1 to m do
               begin
                   top := 0; bot := 1;
                   for j := 1 to b-1 do
                     begin
                         while (top >= bot) and (st[top] <= c[i,j]) do dec(top);
                         inc(top);
                         st[top] := c[i,j]; p[top] := j;
                     end;
                   for j := 1 to n-b+1 do
                     begin
                         while (top >= bot) and (st[top] <= c[i,j+b-1]) do dec(top);
                         inc(top); st[top] := c[i,j+b-1]; p[top] := j+b-1;
                         maxh[i,j+b-1] := c[i,p[bot]];
                         while (top >= bot) and (p[bot] <= j) do inc(bot);
                     end;
               end;
             for j := b to n do
               begin
                    top := 0; bot := 1;
                    for i := 1 to a-1 do
                      begin
                         while (top>=bot) and (st[top] <= minh[i,j]) do dec(top);
                         inc(top);
                         st[top] := maxh[i,j]; p[top] := i;
                      end;
                    for i := 1 to m-a+1 do
                      begin
                          while (top >= bot) and (st[top] <= maxh[i+a-1,j]) do dec(top);
                          inc(top); st[top] := maxh[i+a-1,j]; p[top] := i+a-1;
                          maxc[i+a-1,j] := maxh[p[bot],j];
                          while (top >= bot) and (p[bot] <= i) do inc(bot);
                      end;
               end;

            for i := a to m do
             for j := b to n do
               if maxc[i,j]-minc[i,j] < res then
                 begin
                     res := maxc[i,j]-minc[i,j];
                     dem := 1;
                 end
               else if maxc[i,j]-minc[i,j] = res then inc(dem);
        end;

begin
     assign(input,'REC.INP'); reset(input);
     assign(output,'REC.OUT'); rewrite(output);
     readln(m,n,t);
     for i := 1 to m do
       for j := 1 to n do read(c[i,j]);

     while t > 0 do
       begin
           dec(t);
           readln(a,b);
           res := maxlongint; dem := 0;
           main(a,b);
           if a <> b then main(b,a);
           writeln(res,' ',dem);
       end;
end.

