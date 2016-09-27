Uses math;
Const   maxn = 501;
        maxm = 16001;
        maxw = 99999999;

Var     n,m,i,test,st,u,v,l,s   :       longint;
        ke,next,w :       array [-maxm..maxm] of longint;
        free    :       array [0..maxn] of boolean;
        head,d  :       array [0..maxn] of longint;

{**************************************************************************}
Procedure main;
Var i,j,u,v,dem,temp : longint;
        begin
             for i := 0 to n-1 do d[i] := maxw;
             d[s] := 0;
             fillchar(free,sizeof(free),true);
             repeat
                  temp := maxw;
                  u := -1;
                  for i := 0 to n-1 do
                   if free[i] and (d[i] < temp) then
                     begin
                         temp := d[i]; u := i;
                     end;
                  if u = -1 then break;
                  free[u] := false;
                  j := head[u];
                  while j <> 0 do
                    begin
                        v := ke[j];
                        if free[v] and (d[v] > max(d[u],w[j])) then
                           d[v] := max(d[u],w[j]);
                        j := next[j];
                    end;
             until false;
             for i := 0 to n-1 do
             if d[i] < maxw then writeln(d[i])
              else writeln('Impossible');
        end;

{***************************************************************************}
begin
     // assign(input,'asd.inp'); reset(input);
     // assign(output,'asd.out'); rewrite(output);
      readln(test);
      for st := 1 to test do
        begin
            writeln('Case ',st,':');
            readln(n,m);
            fillchar(head,sizeof(head),0);
            for i := 1 to m do
              begin
                  readln(u,v,l);
                  ke[i] := v; w[i] := l; next[i] := head[u]; head[u] := i;
                  ke[-i] := u; w[-i] := l; next[-i] := head[v]; head[v] := -i;
              end;
            readln(s);
            main;
        end;
end.
