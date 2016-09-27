uses math;
const
        nmax    =       100010;
var
        n,m,top,fron,righ:longint;
        s,head,parent,st,take,pos,qu,have:array[0..nmax] of longint;
        next,ke:array[-nmax..nmax] of longint;
        F,trace:array[0..5010,0..5010] of boolean;
        ans:boolean;
procedure push(u:longint);
begin
        inc(righ);qu[righ]:=u;
end;
procedure pop(var u:longint);
begin
        u:=qu[fron];inc(fron);
end;
procedure doicho(var i,j:longint);
var tg:longint;
begin
        tg:=i;i:=j;j:=tg;
end;
procedure DFS(u:longint);
var i,v,j,uu,t,su,sv,step:longint;
begin
    //    writeln(u,' ');
        i:=head[u];
        s[u]:=1;
        while i<>0 do
          begin
            v:=ke[i];
            if parent[u]<>v then
             begin
               parent[v]:=u;
               DFS(v);
               s[u]:=s[u]+s[v];
             end;
            i:=next[i];
          end;
        if ans then exit;
        top:=0;
        i:=head[u];
        while i<>0 do
          begin
            v:=ke[i];
            if parent[u]<>v then
              begin
                 inc(top);st[top]:=s[v];pos[top]:=v;
              end;
            i:=next[i];
          end;
        if parent[u]<>0 then begin inc(top);st[top]:=n-s[u];pos[top]:=parent[u]; end;
        for i:=1 to top do if st[i]>n div 2 then exit;
        if top<3 then exit;
        if n<=5000 then
          begin
            for i:=0 to top do for j:=0 to n div 2 do F[i][j]:=false;
            F[0][0]:=true;
            for i:=0 to top-1 do for j:=0 to n div 2 do if F[i][j] then
              begin
                F[i+1][j]:=true;trace[i+1][j]:=false;
                if j+st[i+1]<=n div 2 then
                  begin
                    F[i+1][j+st[i+1]]:=true;
                    trace[i+1][j+st[i+1]]:=true;
                  end;
              end;
            for j:=n div 2-1 downto 1 do if F[top][j] then break;
            if F[top][j]=false then exit;
            ans:=true;
            for i:=top downto 1 do
             begin
               take[pos[i]]:=ord(trace[i][j]);
               j:=j-ord(trace[i][j])*st[i];
             end;
            j:=2;
            for i:=1 to top do if take[pos[i]]=0 then
              begin
                take[pos[i]]:=j;
                j:=min(j+1,3);
              end;
            take[u]:=-1;
          end
        else
          begin
            for step:=1 to 10000000 div n do
              begin
                for i:=1 to top do
                  begin
                    j:=random(top)+1;
                    doicho(st[i],st[j]);doicho(pos[i],pos[j]);
                  end;
                uu:=0;v:=0;su:=0;sv:=0;t:=0;
                for i:=1 to top do have[i]:=0;
                for i:=1 to top do
                  begin
                    if uu+st[i]<=n div 2 then begin have[i]:=1;uu:=uu+st[i];inc(su); end
                    else if v+st[i]<=n div 2 then begin have[i]:=2;v:=v+st[i];inc(sv); end
                    else t:=t+st[i];
                  end;
                if t>n div 2 then continue;
                ans:=true;
                if t=0 then if su>=2 then
                  begin
                    for i:=1 to top do if have[i]=1 then begin have[i]:=0;break; end;
                  end else
                  begin
                    for i:=1 to top do if have[i]=2 then begin have[i]:=0;break; end;
                  end;
                for i:=1 to top do take[pos[i]]:=have[i]+1;
                take[u]:=-1;
                exit;
              end;
          end;
end;
procedure process;
var i,j,u,v:longint;
begin
        read(n);
        for i:=1 to n-1 do
          begin
            read(u,v);
            next[i]:=head[u];head[u]:=i;ke[i]:=v;
            next[-i]:=head[v];head[v]:=-i;ke[-i]:=u;
          end;
        ans:=false;
        DFS(1);
        if ans=false then begin writeln(-1);exit; end;
        fron:=1;righ:=0;for i:=1 to n do if take[i]>0 then push(i);
        while fron<=righ do
          begin
            pop(u);
            i:=head[u];while i<>0 do
              begin
                v:=ke[i];
                if take[v]=0 then
                  begin
                    take[v]:=take[u];push(v);
                  end;
                i:=next[i];
              end;
          end;
        for i:=1 to n do if take[i]=-1 then write(0,' ')
        else write(take[i],' ');
end;
procedure make;
var i,j:longint;
begin
        assign(output,'vmoce.inp');rewrite(output);
        randomize;
          n:=3000;
          writeln(n);
          for i:=2 to n do writeln(random(i-1)+1,' ',i);
        close(output);
end;
begin
   //     make;
    //    assign(input,'vmoce.inp');reset(input);
    //    assign(output,'vmoce.out');rewrite(output);
          process;
end.
