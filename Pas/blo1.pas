program blo;
const
        inp='blo.inp';
        oup='blo.ou1';
        maxn=100010;
        maxm=500010;
var
        F:text;
        Ke:array[1..maxm*2] of longint;
        head,count:array[0..maxn] of longint;
        x,y:array[1..maxm] of longint;
        N,m:longint;
        number:longint;
        low,num,pa:array[1..maxn] of longint;
        con,child,res:array [1..maxn] of int64;
(*              *)
function min(x,y:longint):longint;
begin
        if x>y then exit(y) else exit(x);
end;
(*              *)
procedure nhap;
var     i:longint;
begin
        assign(f,inp); reset(f);
        readln(f,n,m);
        for i:=1 to m do
                begin
                        readln(f,X[i],Y[i]);
                        inc(count[x[i]]);
                        inc(count[y[i]]);
                end;
        for i:=1 to n do
                begin
                        head[i]:=head[i-1]+count[i];
                        count[i]:=head[i];
                end;
        for i:=1 to m do
                begin
                        ke[count[x[i]]]:=y[i];
                        ke[count[y[i]]]:=x[i];
                        dec(count[x[i]]);
                        dec(count[y[i]]);
                end;
        close(f);
end;
(*              *)
procedure DFS(x:longint);
var     i:longint;
begin
        inc(number);
        num[x]:=number;
        low[x]:=n+1;
        con[x]:=1;
        for i:=head[x-1]+1 to head[x] do if pa[x]<>ke[i] then
                begin
                        if num[ke[i]]=0 then
                                begin
                                        pa[ke[i]]:=x;
                                        child[x]:=child[x]+1;
                                        DFS(ke[i]);
                                        low[x]:=min(low[x],low[ke[i]]);
                                        con[x]:=con[x]+con[ke[i]];
                                end
                        else    low[x]:=min(low[x],num[ke[i]]);
                end;
end;
(*              *)
procedure init;
var     i,j,u:longint;
        cur,numc:int64;
        Cx:array[1..maxn] of boolean;
begin
        pa[1]:=-1;
        DFS(1);
        res[1]:=2*(n-1);
        cur:=0;
        numc:=0;
        if child[1]>=2 then
                begin
                        for i:=head[0]+1 to head[1] do
                                if pa[ke[i]]=1 then
                                        begin
                                                cur:=cur+con[ke[i]]*numc;
                                                numc:=numc+con[ke[i]];
                                        end;
                        res[1]:=res[1]+2*cur;
                end;
        fillchar(cx,sizeof(cx),true);
        for i:=2 to n do
                begin
                        res[i]:=res[i]+2*(n-1);
                        if (low[i]>=num[pa[i]]) then
                        if cx[pa[i]] then
                                begin
                                        cur:=0;
                                        numc:=0;
                                        u:=pa[i];
                                        for j:=head[u-1]+1 to head[u] do
                                           if (pa[ke[j]]=u) and (low[ke[j]]>=num[u]) then
                                                begin
                                                   cur:=cur+con[ke[j]]*numc;
                                                   numc:=numc+con[ke[j]];
                                                end;
                                        cur:=cur+numc*(n-1-numc);
                                        res[u]:=res[u]+2*cur;
                                        cx[u]:=false;
                                end;
                end;
end;
(*              *)
procedure xuat;
var     i:longint;
begin
        assign(f,oup);  rewrite(f);
        for i:=1 to n do writeln(f,res[i]);
        close(f);
end;
(*              *)
BEGIn
        nhap;
        init;
        xuat;
ENd.
