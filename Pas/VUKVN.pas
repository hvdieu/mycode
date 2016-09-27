Const   maxn = 501;
        maxw = 9999999;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);
Var     m,n,si,sj,ti,tj,left,right,mid     :       longint;
        ok      :       boolean;
        a       :       array [1..maxn,1..maxn] of char;
        qx,qy   :       array [1..maxn*maxn] of longint;
        d       :       array [0..maxn,0..maxn] of longint;
        free    :       array [0..maxn,0..maxn] of boolean;

procedure push(i,j : longint);
        begin
            inc(right); qx[right] := i; qy[right] := j;
        end;

procedure nhap;
var i,j : longint;
        begin
            // assign(input,'asd.inp'); reset(input);
            // assign(output,'asd.out'); rewrite(output);
             readln(m,n);
             for i := 1 to m do
              begin
               for j := 1 to n do
                 begin
                   read(a[i,j]);
                   d[i,j] := maxw;
                   free[i,j] := true;
                   if a[i,j] = '+' then
                     begin
                       push(i,j);
                       free[i,j] := false;
                       d[i,j] := 0;
                     end;
                   if a[i,j] = 'V' then
                     begin
                         si := i; sj := j;
                     end;
                   if a[i,j] = 'J' then
                     begin
                         ti := i; tj := j;
                     end;
                 end; readln;
               end;
        end;

procedure bfs;
var u,v,k : longint;
        begin
            while left < right do
              begin
                  inc(left); u := qx[left]; v := qy[left];
                  for k := 1 to 4 do
                   if free[u+h[k],v+c[k]] then
                     begin
                         free[u+h[k],v+c[k]] := false;
                         push(u+h[k],v+c[k]);
                         d[u+h[k],v+c[k]] := d[u,v]+1;
                     end
                   else if d[u+h[k],v+c[k]] > d[u,v]+1 then
                    d[u+h[k],v+c[k]] := d[u,v]+1;
              end;
        end;

procedure dfs(i,j : longint);
var k : longint;
        begin
             if ok then exit;
             free[i,j] := false;
             if (i=ti) and (j=tj) then ok := true;
             for k := 1 to 4 do
              if free[i+h[k],j+c[k]] and (d[i+h[k],j+c[k]] >= mid) then
               dfs(i+h[k],j+c[k]);
        end;

procedure check;
var i,j : longint;
        begin
             if d[si,sj] < mid then
               begin
                   ok := false;
                   exit;
               end;
             fillchar(free,sizeof(free),false);
             for i := 1 to m do
               for j := 1 to n do free[i,j] := true;

             dfs(si,sj);
        end;

procedure main;
var i,j,dau,cuoi,res : longint;
        begin
             bfs;
             dau := 0; cuoi := 500*500;
             while dau <= cuoi do
               begin
                    mid := (dau+cuoi) shr 1;
                    ok := false;
                    check;
                    if ok then
                      begin
                          res := mid;
                          dau := mid + 1;
                      end
                    else cuoi := mid - 1;
               end;
             write(res);
        end;

begin
     nhap;
     main;
end.