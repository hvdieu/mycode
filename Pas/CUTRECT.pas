Const   inp = 'CUTRECT.INP';
        out = 'CUTRECT.OUT';
        maxn = 501;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);

Var     m,n,u,v,nheap     :       longint;
        a       :       array [1..maxn,1..maxn,1..4] of int64;
        heapi,heapj     :       array [1..maxn*maxn] of longint;
        pos   :       array [1..maxn,1..maxn] of longint;
        d       :     array [1..maxn,1..maxn] of int64;
        free    :       array [0..maxn,0..maxn] of boolean;
        res,maxw     :       int64;

{*************************************************************************}
procedure nhap;
var i,j,k,x : longint;
        begin
           // assign(input,inp); reset(input);
          //  assign(output,out); rewrite(output);
            readln(m,n);
            inc(m); inc(n);
            maxw := 999999999999999;
            for i := 1 to m-1 do
              begin
                  for j := 2 to n-1 do
                    begin
                        read(x);
                        a[i,j,3] := x;
                        a[i+1,j,1] := x;
                    end;
              end;
            for i := 2 to m-1 do
              begin
                  for j := 1 to n-1 do
                   begin
                       read(x);
                       a[i,j,2] := x; a[i,j+1,4] := x;
                   end;
              end;
        end;
{**************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure update(cha,con : longint);
        begin
            swap(heapi[cha],heapi[con]);
            swap(heapj[cha],heapj[con]);
            pos[heapi[cha],heapj[cha]] := cha;
            pos[heapi[con],heapj[con]] := con;
        end;
{***************************************************************************}
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
{*****************************************************************************}
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
{******************************************************************************}
procedure pop;
        begin
            u := heapi[1]; v := heapj[1];
            heapi[1] := heapi[nheap]; heapj[1] := heapj[nheap];
            pos[heapi[1],heapj[1]] := 1;
            dec(nheap);
            downheap(heapi[1],heapj[1]);
        end;
{****************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
             for i := 1 to m-1 do
               begin
                  a[i,1,3] := maxw; a[i,n,3] := maxw;
                  a[i+1,1,1] := maxw; a[i+1,n,1] := maxw;
               end;
             for j := 1 to n-1 do
               begin
                   a[1,j,2] := maxw; a[1,j+1,4] := maxw;
                   a[m,j,2] := maxw; a[m,j+1,4] := maxw;
               end;
             for i := 1 to m do
              for j := 1 to n do
               begin
                   free[i,j] := true;
                   d[i,j] := maxw;
               end;
             for j := 2 to n-1 do
               begin
                   d[1,j] := 0; upheap(1,j);
               end;
             for i := 2 to m-1 do
               begin
                   d[i,n] := 0; upheap(i,n);
               end;
        end;
{****************************************************************************}
procedure main;
var i,j,k : longint;
        begin
            if (m=2) and (n=2) then
              begin
                  write(-1);
                  exit;
              end;
            khoitao;
            repeat
                if nheap = 0 then break;
                pop;
                if (u = m) or (v = 1) then
                  begin
                      res := d[u,v];
                      break;
                  end;
                free[u,v] := false;
                for k := 1 to 4 do
                 if free[u+h[k],v+c[k]] then
                  begin
                      if d[u+h[k],v+c[k]] > d[u,v] + a[u,v,k] then
                        begin
                            d[u+h[k],v+c[k]] := d[u,v] + a[u,v,k];
                            upheap(u+h[k],v+c[k]);
                        end;
                  end;
            until false;
            writeln(res);
        end;
{****************************************************************************}
begin
     nhap;
     main;
end.
