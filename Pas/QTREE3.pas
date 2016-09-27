Uses math;
Const   inp = 'QTREE3.INP';
        out = 'QTREE3.OUT';
        maxn = 100001;

Var     n,q,i,dem1,dem2,vmax,u,v : longint;
        head,p,num,con,t,mau : array [1..maxn] of longint;
        ke,next : array [-maxn..maxn] of longint;
        f : array [1..maxn,0..17] of longint;

procedure dfs(u : longint);
var j,v : longint;
  begin
      inc(dem1); num[u] := dem1;
      con[u] := 1;
      for j := 1 to vmax do
        f[u,j] := f[f[u,j-1],j-1];
      j := head[u];
      while j <> 0 do
        begin
            v := ke[j];
            if num[v]=0 then
              begin
                  p[v] := u; f[v,0] := u;
                  dfs(v);
                  con[u] := con[u]+con[v];
              end;
            j := next[j];
        end;
  end;

procedure update(i,val : longint);
  begin
      while i <= n do
        begin
            inc(t[i],val);
            inc(i,i and (-i));
        end;
  end;

function get(i : longint) : longint;
var s : longint;
  begin
      s := 0;
      while i > 0 do
        begin
            inc(s,t[i]);
            dec(i,i and (-i));
        end;
      exit(s);
  end;

function Qr(u : longint) : longint;
var v,k,x,j : longint;
  begin
      k := get(num[u]);
      if k=0 then exit(-1);
      for j := vmax downto 0 do
        begin
           x := get(num[f[u,j]]);
           if (x>=1) then u := f[u,j];
        end;
      exit(u);
  end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n,q);
     for i := 1 to n-1 do
       begin
           readln(u,v);
           ke[i] := v; next[i] := head[u]; head[u] := i;
           ke[-i] := u; next[-i] := head[v]; head[v] := -i;
       end;
     vmax := round(ln(n)/ln(2));
     p[1] := 1; f[1,0] := 1;
     dfs(1);
     for i := 1 to q do
       begin
           readln(u,v);
           if u = 0 then
             begin
                if mau[v]=0 then
                 begin
                     mau[v] := 1;
                     update(num[v],1); update(num[v]+con[v],-1);
                 end
                else begin
                        mau[v] := 0;
                        update(num[v],-1); update(num[v]+con[v],1);
                     end;
             end
           else writeln(Qr(v));
       end;
end.
