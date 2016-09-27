Program TREE;
const   tfi                     =       'TREE.inp';
        tfo                     =       'TREE.out';
        oo                      =       400001;
var     fi,fo                   :       text;
        n                       :       longint;
        head                    :       array[1..oo] of longint;
        ke                      :       array[1..oo*2] of longint;
        d,c                     :       array[1..oo] of longint;
        dd                      :       array[1..oo] of longint;
        free                    :       array[1..oo] of boolean;
(*****************************)
Procedure input;
var i,j:longint;
begin
        Read(fi,n);
        For i:=1 to n-1 do
         begin
                Read(fi,d[i],c[i]);
                inc(head[d[i]]);
                inc(head[c[i]]);
         end;
        head[n+1]:=(n-1)*2;
        For i:=2 to n do inc(head[i],head[i-1]);
        For i:=1 to n-1 do
         begin
                ke[head[d[i]]]:=c[i];
                ke[head[c[i]]]:=d[i];
                dec(head[d[i]]);
                dec(head[c[i]]);
         end;
end;
(*****************************)
Procedure init;
begin
        fillchar(dd,sizeof(dd),0);
        fillchar(free,n,true);
end;
(*****************************)
Procedure DFS(x:longint);
var i,u,v:longint;
begin
        For i:=head[x]+1 to head[x+1] do
         begin
                v:=ke[i];
                If free[v] then
                 begin
                        free[v]:=false;
                        dd[v]:=dd[x]+1;
                        dfs(v);
                 end;
         end;
end;
(*****************************)
Function gmax(x,y:longint):longint;
begin
        IF x>y then exit(x);
        exit(y);
end;
(*****************************)
Procedure process;
var i,tg,res:longint;
begin
        init;
        free[1]:=false;
        dd[1]:=1;
        DFS(1);
        tg:=-1;
        For i:=1 to n do
         If dd[i]>tg then
          begin
                res:=i;
                tg:=dd[i];
          end;

         init;
         free[res]:=false;
         dd[res]:=1;
         DFS(res);
         tg:=-1;
         For i:=1 to n do
                tg:=gmax(tg,dd[i]);
         WRite(fo,tg,' ');
         res:=0;
         For i:=1 to n do
           If dd[i]=tg then inc(res);
         write(fo,res);
end;
(*****************************)
PRocedure output;
begin
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


