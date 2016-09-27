Const    inp = '';
         out = '';
         maxn = 2000;
Var      fi,fo  :       text;
         a      :       array [1..maxn,1..maxn] of boolean;
         free   :       array [1..maxn] of boolean;
         number,low     :       array [1..maxn] of integer;
         lab    :       array [1..maxn] of integer;
         cx     :       array [1..maxn] of boolean;
         stack  :       array [1..maxn] of integer;
         n,m,i,j,u,v,dem,count,last,k        :       longint;
{*       *      *       *   *       *}
Procedure Visit(u : integer);
Var v,k : integer;
BEGIN
    inc(count);
    number[u]:=count;
    low[u]:=number[u];
    inc(last);
    stack[last]:=u;
    for v:=1 to n do
     BEGIN
      if (free[v]) and (a[u,v]) then
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
            lab[u]:=dem;
            repeat
              BEGIN
                  v:=stack[last];
                  dec(last);
                  free[v]:=false;
                  lab[v]:=dem;
              END;
                until u=v;
        END;
END;
{*      *       *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,m);
    fillchar(free,sizeof(free),true);
    fillchar(number,sizeof(number),0);
    fillchar(a,sizeof(a),false);
    fillchar(cx,sizeof(cx),true);
    count:=0;
    dem:=0;
    last:=0;
    For i:=1 to m do
      BEGIN
          readln(fi,u,v);
          a[u,v]:=true;
      END;
    close(fi);
    For u:=1 to n do
      if number[u]=0 then visit(u);
    For u:=1 to n do
       For v:=1 to n do
         BEGIN
             if (lab[u] <> lab[v]) and (cx[ lab[v] ]) and a[u,v] then

                 BEGIN
                     dec(dem);
                     cx[ lab[v] ] := false;
                 END;
         END;
    Assign(fo,out);rewrite(fo);
    write(fo,dem);
    close(fo);
END.
