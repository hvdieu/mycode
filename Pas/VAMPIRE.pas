Const   maxn = 1610;
        maxs = 3610;
        maxm = 10010;
        maxw = 999999999;

Var     n,m,s,nheap,u,v,k,res   :       longint;
        head    :       array [0..maxn] of longint;
        ke,next,w,kind  :       array [-maxm..maxm] of longint;
        heapi,heapj     :       array [1..maxn*maxs] of longint;
        d,pos       :       array [0..maxn,0..maxs] of longint;
        free    :   array [0..maxn,0..maxs] of boolean;

{***************************************************************************}
procedure nhap;
var i,j,u,v,l,k :       longint;
        begin
             assign(input,'VAMPIRE.INP'); reset(input);
             assign(output,'VAMPIRE.OUT'); rewrite(output);
             readln(s);
             readln(n,m);
             for i := 1 to m do
               begin
                   read(u,v,l,k);
                   ke[i] := v; w[i] := l; kind[i] := k; next[i] := head[u]; head[u] := i;
                   ke[-i] := u; w[-i] := l; kind[-i] := k; next[-i] := head[v]; head[v] := -i;
               end;
        end;
{****************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{****************************************************************************}
procedure update(cha,con : longint);
        begin
            swap(heapi[cha],heapi[con]);
            swap(heapj[cha],heapj[con]);
            pos[heapi[cha],heapj[cha]] := cha;
            pos[heapi[con],heapj[con]] := con;
        end;
{****************************************************************************}
procedure upheap(i,j : longint);
var cha,con : longint;
        begin
            con := pos[i,j];
            if con = 0 then
             begin
                 inc(nheap); heapi[nheap] := i; heapj[nheap] := j;
                 pos[i,j] := nheap; con := nheap;
             end;

            repeat
                 cha := con div 2;
                 if (cha=0) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
                 update(cha,con);
                 con := cha;
            until false;
        end;
{****************************************************************************}
procedure downheap(i,j : longint);
var cha,con : longint;
        begin
            cha := pos[i,j];
            repeat
                 con := cha * 2;
                 if (con<nheap) and (d[heapi[con],heapj[con]] > d[heapi[con+1],heapj[con+1]]) then inc(con);
                 if (con>nheap) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
                 update(cha,con);
                 cha := con;
            until false;
        end;
{****************************************************************************}
procedure pop;
        begin
            u := heapi[1]; k := heapj[1];
            heapi[1] := heapi[nheap]; heapj[1] := heapj[nheap];
            pos[heapi[1],heapj[1]] := 1;
            dec(nheap);
            downheap(heapi[1],heapj[1]);
        end;
{****************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
             fillchar(free,sizeof(free),true);
             for i := 0 to n-1 do
              for j := 0 to s do d[i,j] := maxw;
             d[0,s] := 0;
             upheap(0,s);
             res := -1;
        end;
{***************************************************************************}
procedure main;
var i,j,alt : longint;
        begin
             khoitao;
             repeat
                if nheap = 0 then break;
                pop;
                if u = n-1 then
                  begin
                      res := d[u,k];
                      break;
                  end;
                free[u,k] := false;
                j := head[u];
                while j <> 0 do
                  begin
                      v := ke[j];
                      alt := d[u,k] + w[j];
                      if kind[j] = 0 then
                        begin
                            if free[v,k] and (d[v,k] > alt) then
                              begin
                                  d[v,k] := alt;
                                  upheap(v,k);
                              end;
                        end
                      else if (k - w[j] >= 0) and free[v,k-w[j]] and (d[v,k-w[j]] > alt) then
                        begin
                            d[v,k-w[j]] := alt;
                            upheap(v,k-w[j]);
                        end;
                      j := next[j];
                  end;
             until false;
             writeln(res);
        end;
{****************************************************************************}
begin
     nhap;
     main;
end.