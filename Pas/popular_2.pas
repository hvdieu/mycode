Program POPULAR;
const   tfi                     =       'POPULAR.inp';
        tfo                     =       'POPULAR.out';
        oo                      =       150010;
        ooo                     =       300010;
        oo1                     =       701;
        ooo1                    =       1100;
var     fi,fo                   :       text;
        n,m                     :       longint;
        head                    :       array[1..oo] of longint;
        ke                      :       array[1..ooo] of longint;
        d,c                     :       array[1..ooo] of longint;
        sl,sl1                  :       array[1..oo] of longint;
        free                    :       array[1..oo] of boolean;
        L                       :       array[1..oo1] of boolean;
        vao1                    :       array[1..oo] of longint;
        ra,vao                  :       array[1..oo1] of longint;
        dem                     :       longint;
        last,first              :       longint;
        q                       :       array[1..oo] of longint;
(*****************************)
Procedure input;
var i,j:longint;
        u,v:longint;
begin
        Read(fi,n,m);
        For i:=1 to m do
         begin
                Read(fi,u,v);
                d[i]:=u;
                c[i]:=v;
                inc(head[u]);
         end;
        head[n+1]:=m;
        for i:=2 to n do inc(head[i],head[i-1]);
        For i:=1 to m do
         begin
                ke[head[d[i]]]:=c[i];
                dec(head[d[i]]);
         end;
end;
(*****************************)
Procedure BFS(u:longint);
var i,v:longint;
begin
        For i:=head[u]+1 to head[u+1] do
         begin
                v:=ke[i];
                If L[v] then
                 begin
                        L[v]:=false;
                        BFS(v);
                 end;
         end;
end;
(*****************************)
PRocedure xuli;
var i,j:longint;
        luu:array[1..oo1] of longint;
        res:longint;
begin
        res:=0;
        fillchar(ra,sizeof(ra),0);
        fillchar(vao,sizeof(vao),0);
        For i:=1 to n do
         begin
                Fillchar(l,n,true);
                L[i]:=false;
                BFS(i);
                for j:=1 to n do
                  If (i<>j) and (l[j]=false) then
                   begin
                        inc(ra[i]);
                        inc(vao[j]);
                   end;
         end;
        For i:=1 to n do
         If ra[i]+vao[i]>=n-1 then
          begin
                inc(res);
                luu[res]:=i;
          end;
         writeln(fo,res);
         For i:=1 to res do write(fo,luu[i],' ');
end;
(*****************************)
PRocedure push(X:longint);
begin
        inc(last);
        q[last]:=x;
end;
(*****************************)
Function pop:longint;
begin
        pop:=q[first];
        inc(first);
end;
(*****************************)
Procedure BFS1;
var i,u,v:longint;
begin
        While first<=last do
         begin
                u:=pop;
                For i:=head[u]+1 to head[u+1] do
                 begin
                        v:=ke[i];
                        inc(sl1[v],sl1[u]+1);
                        If free[v] then
                         begin
                                free[v]:=false;
                                push(v);
                         end;
                 end;
         end;
end;
(*****************************)
PRocedure DFS(u:longint);
var i,v:longint;
begin
        For i:=head[u]+1 to head[u+1] do
         begin
                v:=ke[i];
                inc(sl[u]);
                If free[v] then
                 begin
                        free[v]:=false;
                        dfs(v);
                        inc(sl[u],sl[v]);
                 end
                else
                    begin
                        inc(sl[u],sl[v]);
                    end;
         end;
end;
(*****************************)
Procedure init;
begin
        fillchar(sl,sizeof(sl),0);
        fillchar(sl1,sizeof(sl1),0);
        fillchar(free,sizeof(free),true);
end;
(*****************************)
Procedure process;
var i:longint;
        res:longint;
        luu:array[1..oo] of longint;
begin
        init;
        last:=0;
        first:=1;
        For i:=1 to n do
         begin
                If free[i] then
                 begin
                        push(i);
                        dem:=0;
                        free[i]:=false;
                        DFS(i);
                 end;
         end;
        fillchar(free,sizeof(free),true);
        BFS1;
       res:=0;
       For i:=1 to n do
        If sl[i]+sl1[i]>=n-1 then
                begin
                        inc(res);
                        luu[res]:=i;
                end;
        writeln(fo,res);
        For i:=1 to res do write(fo,luu[i],' ');
end;
(*****************************)
PRocedure output;
begin
        If (n<=700) and (m<=1100) then xuli
         else
                process;
end;
(*****************************)
begin
        assign(Fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                input;
                output;
        close(fi);close(fo);
end.
