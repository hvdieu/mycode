{$MODE OBJFBC}
Const    inp = '';
         out = '';
         maxn = 100010;
Var      fi,fo  :       text;
         head,adj,a,b      :       array [1..maxn] of longint;
         free   :       array [1..maxn] of boolean;
         number,low     :       array [1..maxn] of longint;
         stack  :       array [1..maxn] of longint;
         n,m,i,j,u,dem,count,last        :       longint;
{*       *      *       *   *       *}
Function min(xx,yy : longint) : longint;
BEGIN
    if xx > yy then min := yy
      else min := xx;
END;
{*      *       *       *       *       *}
Procedure Visit(u : longint);
Var v,k : longint;
BEGIN
    inc(count);
    number[u]:=count;
    low[u]:=number[u];
    inc(last);
    stack[last]:=u;
    for k:=head[u] + 1 to head[u+1] do
     BEGIN
      v:=adj[k];
      if free[v] then
        if number[v] <> 0 then
          BEGIN
              if low[u] > number[v] then low[u]:=number[v];
          END
            else
              BEGIN
                  Visit(v);
                  if low[u] > low[v] then low[u]:=low[v];
              END;
      END;
      if low[u]=number[u] then
        BEGIN
            inc(dem);
            repeat
              BEGIN
                  v:=stack[last];
                  dec(last);
                  free[v]:=false;
              END
                until u=v;
        END;
END;
{*      *       *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,m);
    fillchar(free,sizeof(free),true);
    fillchar(number,sizeof(number),0);
    fillchar(head,sizeof(head),0);
    fillchar(adj,sizeof(adj),0);
    count:=0;
    dem:=0;
    last:=0;
    For i:=1 to m do
      BEGIN
          readln(fi,a[i],b[i]);
          inc(head[ a[i] ]);
      END;
    For i:=2 to n do
      head[i]:=head[i-1] + head[i];

    head[n+1]:=m;
    For i:=1 to m do
      BEGIN
          adj[ head[ a[i] ] ] := b[i];
          dec(head[a[i]]);
      END;
    close(fi);
    For u:=1 to n do
      if number[u]=0 then visit(u);
    Assign(fo,out);rewrite(fo);
    write(fo,dem);
    close(fo);
END.
