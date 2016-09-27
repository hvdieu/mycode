Const   maxn = 100001;
Var     head,d    :       array [1..maxn] of longint;
        free    : array [1..maxn] of boolean;
        ke,next,w     :       array [-maxn..maxn] of longint;
        dd      :     array [0..maxn*30,0..1] of longint;
        n,m,x,y,l,count,res,i       :     longint;

procedure dfs(u : longint);
var i,v,j : longint;
        begin
             free[u] := false;
             j := head[u];
             while j <> 0  do
               begin
                   v := ke[j];
                   if free[v] then
                     begin
                       d[v] := d[u] xor w[j];
                       dfs(v);
                     end;
                   j := next[j];
               end;
        end;

function lay(x,i : longint) : longint;
        begin
            lay := (x shr i) and 1;
        end;

function bat(x,i : longint) : longint;
        begin
            bat := x or (1 shl i);
        end;

procedure push(x : longint);
var i,bit,t : longint;
        begin
            t := 0;
            for i := 30 downto 0 do
              begin
                  bit := lay(x,i);
                  if dd[t,bit] = 0 then
                    begin
                        inc(count); dd[t,bit] := count;
                        t := count;
                    end
                  else t := dd[t,bit];
              end;
        end;

procedure main;
var i,j,t,temp,bit : longint;
        begin
            fillchar(free,sizeof(free),true);
            dfs(1);
            for i := 1 to n do push(d[i]);
            for i := 1 to n do
              begin
                  t := 0; temp := 0;
                  for j := 30 downto 0 do
                    begin
                        bit := lay(d[i],j);
                        if dd[t,1-bit] = 0 then
                          begin
                              t := dd[t,bit];
                              if bit = 1 then temp := bat(temp,j);
                          end
                        else
                          begin
                              t := dd[t,1-bit];
                              if bit = 0 then temp := bat(temp,j);
                          end;
                    end;
                  if d[i] xor temp > res then res := d[i] xor temp;
              end;
            write(res);
        end;

begin
     assign(input,'PPTREE.INP'); reset(input);
     assign(output,'PPTREE.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n-1 do
       begin
           readln(x,y,l);
           inc(m);
           ke[m] := y; w[m] := l;
           next[m] := head[x]; head[x] := m;
           ke[-m] := x; w[-m] := l;
           next[-m] := head[y]; head[y] := -m;
       end;
     main;
end.
