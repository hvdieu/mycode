Uses math;

Const   inp = 'HP09TEAM.INP';
        out = 'HP09TEAM.OUT';
        maxn = 501;
        maxm = 250000;
        maxp = 51;
        maxw = 999999999;

Var     p,n,m,nheap   :       longint;
        s       :       array [1..maxp] of longint;
        d,c       :       array [1..maxn,1..maxn] of longint;
        f       :       array [1..maxp,1..maxp,1..maxn] of longint;
        free    :       array [1..maxn] of boolean;

{**************************************************************************}
procedure nhap;
var i,u,v,l : longint;
        begin
            // assign(input,inp); reset(input);
            // assign(output,out); rewrite(output);
             readln(p); readln(n); readln(m);
             for u := 1 to n do
              for v := 1 to n do
               if u = v then c[u,v] := 0 else c[u,v] := maxw;
             for i := 1 to m do
               begin
                   read(u,v,l);
                   c[u,v] := min(c[u,v],l);
                   c[v,u] := min(c[v,u],l);
               end;
             for i := 1 to p do read(s[i]);
        end;
{*************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure Dij(i : longint);
var j,u,v,x,temp : longint;
        begin
             fillchar(Free,sizeof(free),true);
             repeat
                temp := maxw;
                u := -1;
                for v := 1 to n do
                if free[v] and (d[i,v] < temp) then
                   begin
                       temp := d[i,v];
                       u := v;
                   end;
                if (u = -1) then break;
                free[u] := false;
                for v := 1 to n do
                 if free[v] and (d[i,v] > d[i,u] + c[u,v]) then
                  d[i,v] := d[i,u] + c[u,v];
             until false;
        end;
{**************************************************************************}
function tinh(i,j,vt : longint) : longint;
var k,res : longint;
        begin
            if i = j then exit(d[s[i],vt]);
            if j < i then exit(0);
            if f[i,j,vt] <> -1 then exit(f[i,j,vt]);
            res := maxw;
            for k := i to j do
             res := min(res,tinh(i,k-1,s[k]) + d[s[k],vt] + tinh(k+1,j,s[k]));
            f[i,j,vt] := res;
            exit(res);
        end;
{**************************************************************************}
procedure khoitao;
var i,j,k : longint;
        begin
            for i := 1 to n do
              for j := 1 to n do
               if i = j then d[i,j] := 0 else d[i,j] := maxw;

            for i := 1 to p do
             for j := 1 to p do
              for k := 1 to n do f[i,j,k] := -1;
        end;
{***************************************************************************}
procedure main;
var u,i,j : longint;
        begin
             for i := 1 to p do dij(s[i]);
             write(tinh(1,p,1));

        end;
{***************************************************************************}
begin
     nhap;
     khoitao;
     main;
end.