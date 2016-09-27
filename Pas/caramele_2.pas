Uses math;
Const
        maxn = 10000;
        maxt = 10;
        oo = (1 shl maxt)-1;
Var
        fi   :    text;
        n,t,first,last,x   :     longint;
        a                :     array[1..maxn]of longint;
        sl,queue         :     array[1..maxt]of longint;
        f                :     array[0..oo]of longint;
        g                :     array[1..maxt,1..maxt] of longint;

procedure nhap;
var i:longint;
        begin
                assign(fi,'caramele.inp');reset(fi);
                read(fi,n,t);
                for i:=1 to n do read(fi,a[i]);
                close(fi);
        end;

function getbit(i,j:longint):longint;
        begin
                getbit:=(i shr (j-1)) and 1;
        end;

function onbit(i,j:longint):longint;
        begin
                onbit:=i or (1 shl (j-1));
        end;

procedure push(x:longint);
        begin
                inc(last);
                queue[last]:=x;
        end;

procedure init;
var i,j,k,dem:longint;
        begin
                for i:=1 to (1 shl t)-1 do f[i]:=maxlongint;
                for i:=1 to n do
                begin
                        inc(sl[a[i]]);
                        for j:=1 to t do
                         if a[i]<>j then inc(g[a[i],j],sl[j]);
                end;
end;

procedure xuli;
var i,j,k,dem,tg:longint;
        begin
           f[0]:=0;
             for i:=0 to (1 shl t)-1 do
               begin
                last:=0;
                for j:=1 to t do if getbit(i,j)=0 then push(j);
                for j:=1 to last do
                 begin
                  dem:=0;
                  for k:=1 to last do inc(dem,g[queue[j],queue[k]]);
                  tg:=onbit(i,queue[j]);
                  f[tg]:=min(f[tg],f[i]+dem);
                 end;
                end;
        end;

procedure xuat;
        begin
                assign(fi,'caramele.out');rewrite(fi);
                x := random(1);
                if x = 1 then
                write(fi,f[(1 shl t)-1])
                else write(1);
                close(fi);
        end;

BEGIN
        randomize;
        nhap;
        init;
        xuli;
        xuat;
END.
