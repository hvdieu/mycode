Const   maxn = 51;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);
Var     a       :       array [0..maxn,0..maxn] of longint;
        dem,f     :       array [1..10] of longint;
        ke      :       array [-1..1,-1..1,0..3,0..3] of boolean;
        free    :       array [0..maxn,0..maxn] of boolean;
        dd      :       array [0..3] of boolean;
        qx,qy,s   :       array [1..maxn*maxn] of longint;
        n,i,j,left,right,sum       :       longint;

procedure vuong;
var i,j : longint;
        begin
             for i := 1 to n-1 do
              for j := 1 to n-1 do
               if (a[i,j]=3) and (a[i,j+1]=1) and (a[i+1,j]=0) and (a[i+1,j+1]=2) then
                 begin
                     inc(f[2]);
                     free[i,j] := false;
                     free[i+1,j] := false; free[i,j+1] := false;
                     free[i+1,j+1] := false;
                 end;
        end;

procedure bfs(i,j : longint);
var px,py,k : longint;
        begin
            left := 0; right := 1;
            qx[1] := i; qy[1] := j; s[1] := a[i,j];
            free[i,j] := false;
            while left < right do
              begin
                 inc(left); px := qx[left]; py := qy[left];
                 for k := 1 to 4 do
                  if free[px+h[k],py+c[k]] and ke[h[k],c[k],a[px,py],a[px+h[k],py+c[k]]] then
                    begin
                        inc(right);
                        free[px+h[k],py+c[k]] := false;
                        qx[right] := px+h[k]; qy[right] := py+c[k];
                        s[right] := a[px+h[k],py+c[k]];
                    end;
              end;
        end;

procedure main;
var i,j,k,dem : longint;
        begin
             vuong;
             for i := 1 to n do
               for j := 1 to n do
                 if free[i,j] then
                   begin
                       bfs(i,j);
                       fillchar(dd,sizeof(dd),true);
                       for k := 1 to right do dd[s[k]] := false;
                       dem := 0;
                       for k := 0 to 3 do if dd[k] = false then inc(dem);
                       if dem >= 3 then inc(f[5])
                        else
                          begin
                              if dem = 1 then inc(f[1]);
                              if dem = 2 then
                                begin
                                    if right mod 2 = 1 then inc(f[4])
                                     else
                                      begin
                                          if ((dd[0] = false) and (dd[1] = false))
                                           or ((dd[3] = false) and (dd[2] = false)) then inc(f[3])
                                            else inc(f[1]);
                                      end;
                                end;
                          end;
                   end;
        end;

procedure khoitao;
        begin
           ke[-1,0,0,1] := true; ke[0,1,0,1] := true; ke[0,1,0,2] := true;
           ke[-1,0,0,3] := true;
           ke[0,-1,1,0] := true; ke[1,0,1,0] := true; ke[1,0,1,2] := true;
           ke[0,-1,1,3] := true;
           ke[0,-1,2,0] := true; ke[-1,0,2,1] := true; ke[0,-1,2,3] := true;
           ke[-1,0,2,3] := true;
           ke[1,0,3,0] := true; ke[0,1,3,1] := true; ke[1,0,3,2] := true;
           ke[0,1,3,2] := true;
        end;

begin
      assign(input,'BRICK.INP'); reset(input);
      assign(output,'BRICK.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do
       for j := 1 to n do
         begin
             read(a[i,j]); free[i,j] := true;
         end;
      khoitao;
      main;
      sum := 0;
      for i := 1 to 5 do inc(sum,f[i]);
      writeln(sum);
      for i := 1 to 5 do writeln(f[i]);
end.