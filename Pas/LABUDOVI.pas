Uses math;
Const   inp = '';
        out = '';
        maxn = 1501;
        h : array [1..4] of integer = (-1,0,1,0);
        c : array [1..4] of integer = (0,1,0,-1);

Var     m,n,i,j,x1,y1,x2,y2,left,right,l,r : longint;
        a : array [1..maxn,1..maxn] of char;
        d,b : array [1..maxn,1..maxn] of longint;
        free : array [0..maxn,0..maxn] of boolean;
        qx,qy : array [1..maxn*maxn] of longint;

procedure push(i,j : longint);
  begin
      inc(right); qx[right] := i; qy[right] := j; free[i,j] := false;
  end;

procedure pop(var i,j : longint);
  begin
      inc(left); i := qx[left]; j := qy[left]; free[i,j] := true;
  end;

procedure khoitao;
var i,j,u,v,k : longint;
  begin
      while left < right do
        begin
            pop(i,j);
            free[i,j] := false;
            for k := 1 to 4 do
             begin
                 u := i+h[k]; v := j+c[k];
                 if free[u,v] then
                   begin
                       push(u,v);
                       d[u,v] := d[i,j]+1;
                   end;
             end;
        end;
  end;

procedure push1(u,v : longint);
  begin
      dec(r); qx[r] := u; qy[r] := v; free[u,v] := false;
  end;

procedure pop1(var i,j : longint);
  begin
      dec(l); i := qx[l]; j := qy[l]; free[i,j] := true;
  end;

function check(u,v : longint) : boolean;
  begin
      if (u>0) and (u<=m) and (v>0) and (v<=n) then exit(true)
       else exit(false);
  end;

procedure update(i,j : longint);
var u,v,k,ts : longint;
  begin
     for k := 1 to 4 do
       begin
         u := i+h[k]; v := j+c[k];
         if check(u,v) then
           begin
             ts := max(d[u,v],b[i,j]);
             if free[u,v] and (b[u,v] > ts) then
               begin
                 b[u,v] := ts;
                 if ts<=b[i,j] then push(u,v) else push1(u,v);
               end
             else if b[u,v] > ts then b[u,v] := ts;
           end;
       end;
  end;

procedure bfs;
var i,j,u,v,k,ts : longint;
  begin
      left := 0; right := 0;
      fillchar(qx,sizeof(qx),0);
      fillchar(qy,sizeof(qy),0);
      for i := 1 to m do
       for j := 1 to n do
         begin
            free[i,j] := true;
            b[i,j] := maxlongint;
         end;
      b[x1,y1] := 0;
      l := m*n+1; r := m*n+1;
      push(x1,y1);
      repeat
         if (left=right) and (l=r) then break;
         if left < right then
           begin
              pop(i,j);
              update(i,j);
           end
         else
           begin
               pop1(i,j);
               update(i,j);
           end;
      until false;
      writeln(b[x2,y2]);
  end;

procedure main;
var i,j : longint;
  begin
      khoitao;
      bfs;
  end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(m,n);
     for i := 1 to m do
       begin
          for j := 1 to n do
           begin
               free[i,j] := true;
               read(a[i,j]);
               if a[i,j]='L' then
                begin
                   if (x1=0) then
                    begin
                        x1 := i; y1 := j;
                    end
                   else begin x2 := i; y2 := j; end;
                end;
               if a[i,j]<>'X' then push(i,j);
           end;
          readln;
       end;
     main;
end.
