uses math;
const
 tfi='tribe.inp';
 tfo='tribe.ou1';

type
 arr=array[-100000..100000] of longint;
 arr1=array[0..100000] of boolean;

var
 fi,fo:text;
 f,g,ke,next,head,s1,pos,dd,dad:arr;
 n,top1,top2,res:longint;
 free:arr1;

procedure nhap;
 var i,u,v:longint;
 begin
     read(fi,n);
     for i:=1 to n-1 do
      begin
          read(fi,u,v);
          ke[i]:=v;
          next[i]:=head[u];
          head[u]:=i;
          ke[-i]:=u;
          next[-i]:=head[v];
          head[v]:=-i;
      end;
 end;

procedure doicho(var x,y:longint);
 var tg:longint;
 begin
     tg:=x;
     x:=y;
     y:=tg;
 end;

procedure qs(l,r:longint);
 var i,j,k:longint;
 begin
     i:=l;
     j:=r;
     k:=s1[l+random(r-l+1)];
     repeat
      while s1[i]<k do inc(i);
      while s1[j]>k do dec(j);
      if i<=j then
        begin
            doicho(s1[i],s1[j]);
            doicho(pos[i],pos[j]);
            inc(i);
            dec(j);
        end;
     until i>j;
     if i<=r then qs(i,r);
     if l<=j then qs(l,j);
 end;

procedure dfs1(u:longint);
 var i,j,v,top,h:longint;
 begin
     top:=0;
     j:=head[u];
     free[u]:=true;
     while j<>0 do
      begin
          v:=ke[j];
          if dad[v]=0 then dad[v]:=u;
          if free[v]=false then
            dfs1(v);
          j:=next[j];
      end;
     j:=head[u];
     while j<>0 do
      begin
          v:=ke[j];
          inc(top);
          s1[top]:=f[v];
          j:=next[j];
      end;
     qs(1,top);h:=1;
     for i:=1 to top do
      begin
          if s1[i]>=h then inc(h)
          else continue;
      end;
     f[u]:=h;
     res:=max(res,h);
 end;

procedure dfs2(u,z:longint);
 var i,j,v,top,h,k:longint;
 begin
     top:=1;
     s1[top]:=z;
     j:=head[u];
     free[u]:=true;
     while j<>0 do
      begin
          v:=ke[j];
          if v<>dad[u] then
           begin
            inc(top);
            s1[top]:=f[v];
            pos[top]:=v;
           end;
          j:=next[j];
      end;
     qs(1,top);h:=1;
     for i:=1 to top do
      begin
          inc(dd[s1[i]]);
          if s1[i]>=h then inc(h)
          else continue;
      end;
     f[u]:=h;
     res:=max(res,h);
     for i:=1 to top do
      if h=top+1 then g[pos[i]]:=h-1
      else
      begin
       g[pos[i]]:=0;
         for k:=top downto i do
           if dd[s1[k]]>1 then
            begin
                g[pos[i]]:=h;
                break;
            end;
          if g[pos[i]]=0 then g[pos[i]]:=h-1;
      end;
    for i:=1 to top do
     dd[s1[i]]:=0;
     j:=head[u];
     while j<>0 do
      begin
          v:=ke[j];
          if free[v]=false then dfs2(v,g[v]);
          j:=next[j];
      end;
 end;

procedure process;
 begin
     dad[1]:=1;dfs1(1);
     fillchar(free,sizeoF(free),false);
     dfs2(1,0);
     write(fo,res);
 end;

BEGIN
    assign(fi,tfi);reset(fi);
    assign(fo,tfo);rewrite(fo);
     nhap;
     process;
    close(fi);close(fo);
END.
