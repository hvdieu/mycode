uses math;
const
        stdin='reform.inp';
        stdout='reform.out';

var
        fi,fo:text;
        res:int64;
        n,m,count,sc,dem:longint;
        head,num,low,p,dd,f:array[1..100000]of longint;
        ke,next,free:array[-200000..200000]of longint;

procedure input;
var i,u,v:longint;
begin
        assign(fi,stdin);reset(fi);
        read(fi,n,m);
        for i:=1 to m do
          begin
            read(fi,u,v);
            ke[i]:=v;
            next[i]:=head[u];
            head[u]:=i;
            ke[-i]:=u;
            next[-i]:=head[v];
            head[v]:=-i;
          end;
        close(fi);
end;

procedure dfs1(u:longint);
var i:longint;
begin
        dd[u]:=dem;
        f[u]:=1;
        inc(count);
        num[u]:=count;
        low[u]:=count;
        i:=head[u];
        while i<>0 do
          begin
            if ke[i]<>p[u] then
              begin
                if num[ke[i]]=0 then
                  begin
                    p[ke[i]]:=u;
                    dfs1(ke[i]);
                    f[u]:=f[u]+f[ke[i]];
                    if low[ke[i]]>=num[ke[i]] then
                      begin
                        inc(sc);
                        free[i]:=1;
                      end;
                  end;
                low[u]:=min(low[u],low[ke[i]]);
              end;
            i:=next[i];
          end;
end;

procedure sub1;
var i,tg:longint;
begin
        res:=m-sc;
        tg:=0;
        for i:=1 to n do
          if dd[i]=1 then inc(tg);
        res:=res*tg*(n-tg);
end;

procedure sub2;
var i,tg,tg1:longint;
begin
        for i:=-m to m do
          if free[i]=1 then res:=res+f[ke[i]]*(n-f[ke[i]])-1;
        tg:=m-sc;
        tg1:=n*(n-1) div 2 - m;
        res:=res+int64(tg)*tg1;
end;

procedure process;
var i:longint;
begin
        for i:=1 to n do
          if num[i]=0 then
            begin
              inc(dem);
              dfs1(i);
            end;
        if dem>2 then exit;
        if dem=2 then sub1 else sub2;
end;

procedure output;
begin
        assign(fo,stdout);rewrite(fo);
        write(fo,res);
        close(fo);
end;

BEGIN
        input;
        process;
        output;
END.