Const   maxn = 22;
        maxw = 999999999;
        h  : array [1..4] of longint = (-1,0,1,0);
        c  : array [1..4] of longint = (0,1,0,-1);

Type    tv = record
        pi,pj,pu,pv : longint;
        end;
Var     m,n,r1,r2     :       longint;
        d,day       :       array [0..maxn,0..maxn,0..maxn,0..maxn] of longint;
        qi,qj,qu,qv : array [1..maxn*maxn*maxn*maxn] of longint;
        free    :       array [0..maxn,0..maxn,0..maxn,0..maxn] of boolean;
        a       :       array [0..maxn,0..maxn] of char;
        si,sj,bi,bj,i,j,right,left : longint;


procedure khoitao;
var i,j,u,v,k : longint;
        begin
              fillchar(free,sizeof(free),true);
              for i := 1 to m do
               for j := 1 to n do
                for u := 1 to m do
                 for v := 1 to n do d[i,j,u,v] := maxw;
              for j := 0 to n+1 do
                begin
                   a[0,j] := '#'; a[m+1,j] := '#';
                end;
              for i := 0 to m+1 do
                begin
                    a[i,0] := '#'; a[i,n+1] := '#';
                end;
              d[si,sj,bi,bj] := 0;
        end;

procedure push(i,j,u,v : longint);
        begin
             free[i,j,u,v] := false;
             inc(right);
             qi[right] := i; qj[right] := j;
             qu[right] := u; qv[right] := v;
        end;

procedure bfs;
var i,j,u,v,k,i1,j1,u1,v1 : longint;
        begin
             left := 0; right := 1;
             qi[1] := si; qj[1] := sj; qu[1] := bi; qv[1] := bj;
             while left < right do
               begin
                   inc(left);
                   i := qi[left]; j := qj[left]; u := qu[left]; v := qv[left];
                   free[i,j,u,v] := false;
                   if a[u,v] = 'T' then
                     begin
                         r1 := d[i,j,u,v];
                         r2 := day[i,j,u,v];
                         exit;
                     end;
                   for k := 1 to 4 do
                     if (a[i+h[k],j+c[k]] <> '#') and ((i+h[k] <> u) or (j+c[k] <> v)) then
                       begin
                             i1 := i+h[k]; j1 := j+c[k];
                             if free[i1,j1,u,v] then
                               begin
                                   push(i1,j1,u,v);
                                   d[i1,j1,u,v] := d[i,j,u,v] + 1;
                                   day[i1,j1,u,v] := day[i,j,u,v];
                               end;
                       end;
                   for k := 1 to 4 do
                     if (i+h[k]=u) and (j+c[k]=v) and (a[u+h[k],v+c[k]]<>'#') then
                       begin
                           i1 := u; j1 := v; u1 := u+h[k]; v1 := v+c[k];
                           if free[i1,j1,u1,v1] then
                             begin
                                 push(i1,j1,u1,v1);
                                 d[i1,j1,u1,v1] := d[i,j,u,v] + 1;
                                 day[i1,j1,u1,v1] := day[i,j,u,v] + 1;
                             end;
                       end;
               end;
        end;

begin
    assign(input,'pushing.in1'); reset(input);
    assign(output,'pushing.out'); rewrite(output);
    readln(m,n);
    r1 := maxw;
    for i := 1 to m do
     begin
          for j := 1 to n do
            begin
                read(a[i,j]);
                if a[i,j] = 'S' then
                  begin
                      si := i; sj := j;
                  end;
                if a[i,j] = 'B' then
                  begin
                      bi := i; bj := j;
                  end;
            end;
          readln;
     end;
    khoitao;
    bfs;
    if r1 = maxw then write('Impossible.')
     else write(r2,' ',r1);
end.
