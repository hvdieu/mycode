Uses math;
Const   maxn = 3001;
Var     n,i,c,j,res,dem,t,sum       :       longint;
        fi      :       text;
        head,a,cha,kq,tong    :       array [1..maxn] of longint;
        ke,next :       array [-maxn..maxn] of longint;
        f       :       array [1..maxn,0..2] of int64;

procedure dfs(u : longint);
var j,sum,temp,t,s,v : longint;
        begin
            j := head[u];
            while j <> 0 do
              begin
                   v := ke[j];
                   if cha[v] = 0 then
                     begin
                         cha[v] := u;
                         dfs(v);
                     end;
                   j := next[j];
              end;
            j := head[u];
            sum := 0; s := 0;
            while j <> 0 do
              begin
                  v := ke[j];
                  if cha[v] = u then
                    begin
                        temp := maxlongint;
                        for t := 0 to 2 do temp := min(temp,f[v,t]);
                        s := s + f[v,0];
                        sum := sum + temp;
                    end;
                  j := next[j];
              end;
            f[u,0] := sum + a[u];
            f[u,1] := s; f[u,2] := maxlongint;
            j := head[u];
            while j <> 0 do
              begin
                   v := ke[j];
                   if cha[v] = u then f[u,2] := min(f[u,2],s - f[v,0] + f[v,1]);
                   j := next[j];
              end;
        end;

procedure truyvet(u,t : longint);
var i,j,v,temp,vt,k : longint;
        begin
            if t = 0 then
              begin
                  inc(dem); kq[dem] := u;
                  j := head[u];
                  while j <> 0 do
                    begin
                        v := ke[j];
                        if cha[v] = u then
                          begin
                              temp := maxlongint;
                              for k := 0 to 2 do
                               if temp > f[v,k] then
                                 begin
                                     temp := f[v,k];
                                     vt := k;
                                 end;
                              truyvet(v,vt);
                          end;
                        j := next[j];
                    end;
              end else

            if t = 1 then
              begin
                 j := head[u];
                 while j <> 0 do
                   begin
                       v := ke[j];
                       if cha[v] = u then truyvet(v,0);
                       j := next[j];
                   end;
              end else

            if t = 2 then
              begin
                 j := head[u];
                 while j <> 0 do
                   begin
                       v := ke[j];
                       if cha[v] = u then
                         begin
                            if f[u,2] = f[u,1] - f[v,0] + f[v,1] then
                             begin
                               vt := v;
                               break;
                             end;
                         end;
                       j := next[j];
                   end;
                 j := head[u];
                 while j <> 0 do
                   begin
                       v := ke[j];
                       if cha[v] = u then
                         begin
                              if v <> vt then truyvet(v,0)
                               else truyvet(v,1);
                         end;
                       j := next[j];
                   end;
              end;

        end;

begin
     assign(input,'DIEPVIEN.INP'); reset(input);
     assign(output,'DIEPVIEN.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n do read(a[i]);
     for i := 2 to n do
       begin
           read(j);
           ke[i] := j; ke[-i] := i;
           next[i] := head[i]; next[-i] := head[j];
           head[i] := i; head[j] := -i;
       end;
     cha[1] := -1;
     dfs(1);
     res := maxlongint;
     for i := 0 to 2 do res := min(res,f[1,i]);
     writeln(res);
     for i := 0 to 2 do if res = f[1,i] then
       begin
         truyvet(1,i);
         break;
       end;
     writeln(dem);
     for i := 1 to dem do write(kq[i],' ');
     {close(output);
     assign(fi,'diepvien.out'); reset(fi);
     sum := 0;
     readln(fi,t); readln(fi,n);
     for i := 1 to n do
       begin
           read(fi,t); sum := sum + a[t];
       end; }
end.

