Uses math;
Const   inp = '';
        out = '';
        maxn = 10001;

Var     n,p,vmax,dem1,dem2,top,m,q : longint;
        k,res : qword;
        head,cha,thoat,num,st,dd : array [1..maxn] of longint;
        g,d,d1 : array [1..maxn] of qword;
        free : array [1..maxn] of boolean;
        ke,next,w : array [-maxn..maxn] of longint;
        f : array [1..maxn,0..15] of longint;

function max(xx,yy : qword) : qword;
  begin
      if xx > yy then exit(xx) else exit(yy);
  end;

function min(xx,yy : qword) : qword;
  begin
      if xx < yy then exit(xx) else exit(yy);
  end;

procedure nhap;
var i,j,u,v,l : longint;
  begin
      assign(input,inp); reset(input);
      assign(output,out); rewrite(output);
      readln(n,p);
      for i := 1 to n-1 do
        begin
            readln(u,v,l);
            ke[i] := v; next[i] := head[u]; w[i] := l; head[u] := i;
            ke[-i] := u; next[-i] := head[v]; w[-i] := l; head[v] := -i;
        end;
      vmax := round(ln(n)/ln(2))+1;
  end;

procedure dfs(u : longint);
var j,v : longint;
  begin
      inc(dem1); num[u] := dem1;
      k := max(k,d[u]);
      for j := 1 to vmax do f[u,j] := f[f[u,j-1],j-1];
      j := head[u];
      while j <> 0 do
        begin
            v := ke[j];
            if num[v]=0 then
            begin
              cha[v] := u;
              d[v] := d[u]+w[j];
              f[v,0] := u;
              dfs(v);
            end;
            j := next[j];
        end;
      inc(dem2); thoat[u] := dem2;
  end;

procedure loang(u,l : longint);
var j,v : longint;
  begin
      if d[u] > l then
        begin
            inc(top); st[top] := u;
            exit;
        end;
      free[u] := false; j := head[u];
      while j <> 0 do
        begin
            v := ke[j];
            if free[v] then
              begin
                  d[v] := d[u]+w[j];
                  loang(v,l);
              end;
            j := next[j];
        end;
  end;

function pa(u,v : longint) : boolean;
  begin
      if (num[u]<=num[v]) and (thoat[u]>=thoat[v]) then exit(true)
       else exit(false);
  end;

function lca(u,v : longint) : longint;
var j : longint;
  begin
      if pa(u,v) then exit(u);
      if pa(v,u) then exit(v);
      for j := vmax downto 0 do
        if pa(f[u,j],v)=false then u := f[u,j];
      exit(cha[u]);
  end;

procedure dfs1(u : longint);
var j,v : longint;
  begin
      free[u] := false; dd[u] := 1;
      j := head[u]; g[u] := 0;
      while j <> 0 do
        begin
            v := ke[j];
            if free[v] and (cha[u]<>v) then
              begin
                  d[v] := d[u]+w[j];
                  dfs1(v);
                  g[u] := max(g[u],g[v]+w[j]);
              end;
            j := next[j];
        end;
  end;

function check(l : longint) : boolean;
var i,j,dem,u,ts,v : longint; temp : qword;
  begin
      top := 0;
      fillchar(free,sizeof(free),true);
      fillchar(d,sizeof(d),0);
      loang(p,l);
      if top=0 then exit(true);
      q := st[1];
      for i := 2 to top do
        begin
            q := lca(q,st[i]);
            if q=p then exit(false);
        end;
      fillchar(g,sizeof(g),0);
      fillchar(free,sizeof(free),true);
      fillchar(d,sizeof(d),0);
      fillchar(dd,sizeof(dd),0);
      dfs1(q);
      j := head[q]; temp := 0; dem := 0; ts := 0;
      if g[q]<=l then exit(true);
      u := q;
      repeat
         q := u; temp := temp+ts;
         if temp > l then exit(false);
         if g[q]<=l then exit(true);
         j := head[q]; dem := 0;
         while j <> 0 do
           begin
              v := ke[j];
              if (cha[v]=q) then
                begin
                    if (g[v]+w[j]>l) and (dd[v]=1) then
                      begin
                         if dem=1 then exit(false);
                         inc(dem); u := v; ts := w[j];
                      end
                    else if dd[v]=1 then temp := max(temp,g[v]+w[j]);
                end;
              j := next[j];
           end;
      until false;
  end;

procedure main;
var i,j : longint;
    ok : boolean;
    left,right,l : qword;
  begin
      cha[p] := p; f[p,0] := p;
      dfs(p);
      left := 0; right := k;
      ok := check(16);
      while left <= right do
        begin
            l := (left+right) shr 1;
            if check(l) then
              begin
                  res := l;
                  right := l-1;
              end
            else left := l+1;
        end;
      writeln(k-res);
  end;

procedure dfs2(u : longint);
var j,v : longint;
  begin
      free[u] := false;
      j := head[u];
      while j <> 0 do
        begin
            v := ke[j];
            if free[v] then
              begin
                  d1[v] := d1[u]+w[j];
                  dfs2(v);
              end;
            j := next[j];
        end;
  end;

procedure trau;
var i,j,temp : longint;
  begin
     cha[p] := p; f[p,0] := p;
     dfs(p);
     res := k;
     for i := 1 to n do
      if p<>i then
        begin
           fillchar(free,sizeof(free),true);
           fillchar(d1,sizeof(d1),0);
           dfs2(i);
           temp := 0;
           for j := 1 to n do
            temp := max(temp,min(d[j],d1[j]));
           res := min(res,temp);
        end;
      writeln(k-res);
  end;

begin
    nhap;
    main;
   // trau;
end.




