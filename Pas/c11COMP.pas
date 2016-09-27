//{$Q-,R-,S-,I-}
{$inline ON}
uses math;
const
        nmax    =       100010;
type
        node = record
          num,gt:longint;
        end;
        arr     =       array[0..nmax] of node;
var
        n,m,k,top,dthoat,dnum,q,dem,res:longint;
        st:Arr;
        kq,num,thoat,d,dist,parent,pa,link,lead,head,ke,next,color,pos,dist_,con,c,lab,point,h,vt:array[0..nmax] of longint;
        free:array[0..nmax] of boolean;
        f:Array[0..nmax,0..17] of longint;
        t:Array[0..4*nmax] of node;
        sl:array[0..1000,0..1000] of longint;
function cha(i,j:longint):boolean;          inline;
begin
        exit((num[i]<=num[j])and(thoat[i]>=thoat[j]));
end;
function LCA(u,v:longint):longint;         inline;
var i,k:longint;
begin
        if cha(u,v) then exit(u);
        for k:=17 downto 0 do
          if cha(f[u][k],v) then i:=f[u][k]
          else u:=f[u][k];
        exit(i);
end;
procedure sort(l,r:longint;var s:arr);     inline;
var i,j:longint;
mid,tg:node;
begin
        i:=l;j:=r;
        mid:=s[l+random(r-l+1)];
        repeat
          while s[i].num<mid.num do inc(i);
          while s[j].num>mid.num do dec(j);
          if i<=j then
            begin
              tg:=s[i];s[i]:=s[j];s[j]:=tg;
              inc(i);dec(j);
            end;
        until i>j;
        if l<j then sort(l,j,s);
        if i<r then sort(i,r,s);
end;
procedure perfect(cur:longint);              inline;
var i,u,v:longint;
j:node;
procedure update(i,lo,hi,u,x:longint);       inline;
var mid:longint;
begin
        if (u<lo)or(hi<u) then exit;
        if lo=hi then
          begin
            t[i].num:=x;
            exit;
          end;
        mid:=(lo+hi)shr 1;
        update(2*i,lo,mid,u,x);
        update(2*i+1,mid+1,hi,u,x);
        if (t[2*i].num>=t[2*i+1].num) then t[i]:=t[2*i]
        else t[i]:=t[2*i+1];
end;
function query(i,lo,hi,u,v:longint):node;           inline;
var mid:longint;
qle,qri,x:node;
begin
        x.num:=0;
        if (v<lo)or(hi<u)  then exit(x);
        if (u<=lo)and(hi<=v) then exit(t[i]);
        mid:=(lo+hi)shr 1;
        qle:=query(2*i,lo,mid,u,v);
        qri:=query(2*i+1,mid+1,hi,u,v);
        if qle.num>=qri.num then x:=qle else x:=qri;
        exit(x);
end;
procedure visit(u:longint);                    inline;
var i,v:longint;
begin
        d[u]:=ord(color[u]=cur);
        i:=head[u];
        while i<>0 do
          begin
            v:=ke[i];
            visit(v);
            d[u]:=d[u]+d[v];
            i:=next[i];
          end;
end;
begin
        top:=0;
        if Color[1]<>cur then begin top:=1;st[top].gt:=1;st[top].num:=num[1]; end;
        i:=lead[cur];
        while i<>0 do
          begin
            inc(top);st[top].gt:=i;st[top].num:=num[i];
            i:=link[i];
          end;
        sort(1,top,st);
        for i:=1 to top do free[st[i].gt]:=false;
        for i:=2 to top do
          begin
            u:=LCA(st[i-1].gt,st[i].gt);
            if free[u] then
              begin
                free[u]:=false;
                inc(top);st[top].gt:=u;st[top].num:=num[u];
              end;
          end;
        sort(1,top,st);
        for i:=1 to top do head[st[i].gt]:=0;
        update(1,1,n,pos[st[1].gt],1);
        for i:=2 to top do
          begin
            j:=query(1,1,n,pos[st[i].gt],n);
            parent[st[i].gt]:=j.gt;
            next[i]:=head[j.gt];head[j.gt]:=i;ke[i]:=st[i].gt;
            update(1,1,n,pos[st[i].gt],1);
          end;
        for i:=1 to top do update(1,1,n,pos[st[i].gt],0);
        visit(1);
        if d[1]<=K then inc(res);
        for i:=2 to top do
          if d[st[i].gt]<=K then
            begin
              u:=parent[st[i].gt];
              v:=st[i].gt;
              repeat
                if u=v then break;
                if point[u]=point[v] then
                  begin
                    inc(h[lab[u]+1]);
                    if con[v]<>1 then dec(h[lab[v]+1]);
                    break;
                  end;
                inc(h[lab[point[v]]]);
                if con[v]<>1 then dec(h[lab[v]+1]);
                v:=pa[point[v]];
              until false;
            end;
        for i:=1 to top do free[st[i].gt]:=true;
end;
procedure DFS(u:longint);
var i,v:longint;
begin
        inc(dnum);num[u]:=dnum;
        vt[dnum]:=u;
        if u<>1 then
          begin
            f[u][0]:=parent[u];
            for i:=1 to 17 do f[u][i]:=f[f[u][i-1],i-1];
          end;
        con[u]:=1;
        i:=head[u];
        while i<>0 do
          begin
            parent[i]:=u;
            DFS(i);
            con[u]:=con[u]+con[i];
            i:=next[i];
          end;
        inc(dthoat);
        thoat[u]:=dthoat;
end;
procedure init(i,lo,hi:longint);
var mid:longint;
begin
        if lo=hi then
          begin
            t[i].num:=0;
            t[i].gt:=st[lo].gt;
            exit;
          end;
        mid:=(lo+hi)shr 1;
        init(2*i,lo,mid);
        init(2*i+1,mid+1,hi);
end;
procedure DFS2(u:longint);
var i,v,vt,maxC:longint;
begin
        free[u]:=false;
        inc(dem);c[dem]:=u;lab[u]:=dem;
        i:=head[u];
        maxC:=0;
        while i<>0 do
          begin
            if maxC<con[i] then
              begin
                maxC:=con[i];
                vt:=i;
              end;
            i:=next[i];
          end;
        if maxC<>0 then DFS2(vt);
end;
procedure count(u:longint);
var i,v,j:longint;
begin
        sl[u][Color[u]]:=1;
        i:=head[u];
        while i<>0 do
          begin
            count(i);
            for j:=1 to m do sl[u][j]:=sl[u][j]+sl[i][j];
            i:=next[i];
          end;
end;
procedure trau;
var i,j:longint;
begin
        count(1);
        for i:=1 to n do for j:=1 to m do
          if (sl[i][j]>=1)and(sl[i][j]<=K) then inc(kq[i]);
end;
procedure progress;
var i,j,u,v:longint;
begin
        read(n,m,k);
        for i:=2 to n do
         begin
           read(u);
           pa[i]:=u;
           next[i]:=head[u];head[u]:=i;
         end;
        for i:=1 to n do
          begin
            read(Color[i]);
            link[i]:=lead[Color[i]];lead[Color[i]]:=i;
          end;
     //   trau;
        for i:=0 to 17 do f[1][i]:=1;
        DFS(1);
        for i:=1 to n do begin st[i].gt:=i;st[i].num:=thoat[i]; end;
        sort(1,n,st);for i:=1 to n do pos[st[i].gt]:=i;init(1,1,n);
        for i:=1 to n do free[i]:=true;
        dem:=0;
        for i:=1 to n do if free[vt[i]] then
          begin
            DFS2(vt[i]);
            for j:=lab[vt[i]] to dem do point[c[j]]:=vt[i];
          end;
        for i:=1 to n do free[i]:=true;
        for i:=1 to m do  if lead[i]<>0 then
          perfect(i);
        i:=1;
        while i<=n do
          begin
            j:=i;u:=0;
            while (j<=n)and(point[c[i]]=point[c[j]]) do
              begin
                u:=u+h[j];
                dist[c[j]]:=u;
                inc(j);
              end;
            i:=j;
          end;
        read(q);
        dist[1]:=res;
        for i:=1 to q do
          begin
            read(u);
            writeln(dist[u]);
          end;
end;
procedure make;
var i,j,u,v:longint;
begin
        assign(output,'c11comp.inp');rewrite(output);
         randomize;
          n:=random(10)+1;
          m:=random(n)+1;
          k:=random(n)+1;
          writeln(n,' ',m,' ',k);
          for i:=1 to m do color[i]:=i;
          for i:=m+1 to n do color[i]:=random(m)+1;
          for i:=1 to 100000 do
            begin
              u:=random(n)+1;
              v:=random(n)+1;
              j:=color[u];color[u]:=color[v];color[v]:=j;
            end;
          for i:=2 to n do writeln(random(i-1)+1);
          for i:=1 to n do write(color[i],' ');
          writeln;
        close(output);
end;
begin
    //    make;
        assign(input,'51.in');reset(input);
        assign(output,'c11comp.out');rewrite(output);
          progress;
        close(input);
        close(output);
end.