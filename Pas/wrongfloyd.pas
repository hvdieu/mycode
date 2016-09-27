Const   maxn = 300;
Var     n,m,n1,n2,x,x1,x2,x3,c,k,i,j     :       longint;
        ok      :       boolean;
        a       :       array [1..maxn,1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        d,kd    :       array [1..maxn] of longint;

procedure dfs(u : longint);
var v : longint;
        begin
            for v := 1 to n do
             if free[v] and (a[u,v] = 1) then
               begin
                   if c < m then
                     begin
                         inc(c);
                         writeln(u,' ',v);
                         a[u,v] := 0;
                         a[v,u] := 0;
                     end;
                   free[v] := false;
                   dfs(v);
               end;

        end;

begin
    // assign(input,'floyd.inp'); reset(input);
   //  assign(output,'floyd.out'); rewrite(output);
     read(n,m,k);
     for i := 1 to k do
      begin
         read(x); inc(n1); d[n1] := x;
         free[x] := true;
      end;

     for i := 1 to n do
      if free[x] = false then
       begin
           inc(n2); kd[n2] := x;
       end;
     if (n=k) or (m = (n*(n-1)) div 2) or (m > (n*(n-1)) div 2 - (k-1)) or (m < n-1) then
      write(-1)
       else
         begin
             for i := 1 to n do
              for j := 1 to n do
               if i <> j then a[i,j] := 1;
             if n2 > 1 then
             begin
             x1 := d[1]; x2 := kd[1]; x3 := kd[2];
             a[x1,x3] := 0; a[x3,x1] := 0;
             for i := 2 to n1 do
               begin
                   a[x3,d[i]] := 0;
                   a[d[i],x3] := 0;
               end;
             end
              else
             begin
                 x1 := d[1]; x2 := kd[1];
                 x3 := d[2];
                 a[x1,x3] := 0; a[x3,x1] := 0;
                 for i := 1 to k do
                  if d[k] <> x1 then
                    begin
                        a[x1,d[i]] := 0;
                        a[d[i],x1] := 0;
                    end;
             end;
         fillchar(free,sizeof(free),true);
         free[1] := false;
         dfs(1);
         if c < m then
           begin
               for i := 1 to n do
               begin
                for j := i+1 to n do
                 if a[i,j] = 1 then
                  begin
                      a[i,j] := 0;
                      a[j,i] := 0;
                      inc(c);
                      writeln(i,' ',j);
                      if c = m then break;
                  end;
                  if c = m then break;
               end;
           end;
         end;

end.