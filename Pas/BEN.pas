Uses math;
Const   maxn = 1510;
        h       :       array [1..4] of integer = (0,1,0,-1);
        c       :       array [1..4] of integer = (1,0,-1,0);
Var     n,m,i,j,dem     :    longint;
        a       :   array [1..maxn,1..maxn] of longint;
        free,den    :   array [0..maxn,0..maxn] of boolean;
        kq      :   array [1..2*maxn] of longint;
        qx,qy,d   :   array [1..maxn*maxn] of longint;

procedure dfs(i,j : longint);
var k : longint;
        begin
            free[i,j] := false; den[i,j] := true;
            for k := 3 to 4 do
             if free[i+h[k],j+c[k]] then dfs(i+h[k],j+c[k]);
        end;

procedure bfs;
var i,t,left,right,px,py,k,temp : longint;
        begin
            fillchar(free,sizeof(free),false);
            for i := 1 to m do
             for j := 1 to n do free[i,j] := true;
            left := 0; right := 1;
            qx[1] := 1; qy[1] := 1;
            free[1,1] := false;
            while left < right do
              begin
                  inc(left);
                  t := left;
                  while (t < right) and (d[t] = d[t+1]) do inc(t);
                  temp := maxlongint;
                  for i := left to t do
                    begin
                        px := qx[i]; py := qy[i];
                        if den[px,py] and (a[px,py] < temp) then temp := a[px,py];
                    end;
                  for i := left to t do
                    begin
                        px := qx[i]; py := qy[i];
                        if den[px,py] and (a[px,py] = temp) then
                          begin
                              for k := 1 to 2 do
                               if free[px+h[k],py+c[k]] then
                                begin
                                    inc(right); qx[right] := px+h[k];
                                    qy[right] := py+c[k];
                                    d[right] := d[left] + 1;
                                    free[px+h[k],py+c[k]] := false;
                                end;
                          end;
                    end;
                  inc(dem); kq[dem] := temp;
                  left := t;
              end;
        end;

procedure main;
var i,j : longint;
        begin
            fillchar(free,sizeof(free),false);
            for i := 1 to m do
              for j := 1 to n do free[i,j] := true;
            dfs(m,n);
            bfs;
            for i := 1 to dem do write(kq[i],' ');
        end;

begin
     assign(input,'BEN.INP'); reset(input);
     assign(output,'BEN.OUT'); rewrite(output);
     readln(m,n);
     for i := 1 to m do
       for j := 1 to n do read(a[i,j]);

     main;


end.