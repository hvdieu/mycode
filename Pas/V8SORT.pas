Const   maxn = 7;
        maxh = 6000;
        maxw = 999999999;
        base = 6543210;
Var     n,i,s,t,res,nheap     :       longint;
        a,b       :       array [1..maxn] of longint;
        c       :       array [1..maxn,1..maxn] of longint;
        heap    :       array [1..maxh] of longint;
        d      :       array [0..base] of longint;
        pos    :       array [0..base] of integer;
        free    :       array [0..base] of boolean;

{**************************************************************************}
procedure nhap;
var i,j,dem : longint;
        begin
            assign(input,'asd.inp'); reset(input);
            assign(output,'asd.out'); rewrite(output);
            i := 0;
            while not seekeoln(input) do
              begin
                  inc(n); read(b[n]);
              end;
            for i := 1 to n do
             for j := 1 to n do read(c[i,j]);
            for i := 1 to n do
              begin
                  dem := 0;
                  for j := 1 to n do
                   if (i <> j) and (b[j] < b[i]) then inc(dem);
                  a[i] := dem;
              end;
        end;
{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure upheap(i : longint);
var cha,con : longint;
        begin
            con := pos[i];
            if con = 0 then
              begin
                  inc(nheap); heap[nheap] := i; pos[i] := nheap;
                  con := nheap;
              end;
            repeat
               cha := con div 2;
               if (cha=0) or (d[heap[cha]] <= d[heap[con]]) then break;
               swap(heap[cha],heap[con]);
               pos[heap[cha]] := cha; pos[heap[con]] := con;
               con := cha;
            until false;
        end;
{***************************************************************************}
function pop : longint;
var cha,con : longint;
        begin
            pop := heap[1]; heap[1] := heap[nheap]; pos[heap[1]] := 1;
            dec(nheap); cha := 1;
            repeat
                con := cha*2;
                if (con < nheap) and (d[heap[con]] > d[heap[con+1]]) then inc(con);
                if (con > nheap) or (d[heap[cha]] <= d[heap[con]]) then break;
                swap(heap[cha],heap[con]);
                pos[heap[cha]] := cha; pos[heap[con]] := con;
                cha := con;
            until false;
        end;
{**************************************************************************}
procedure khoitao;
var i,j,u,temp : longint;
        begin
             for i := 1 to n do s := s*10+a[i];
             for i := 1 to n do
               begin
                   u := 0; temp := maxlongint;
                   for j := 1 to n do
                    if a[j] < temp then
                      begin
                          temp := a[j]; u := j;
                      end;
                   b[i] := a[u]; a[u] := maxlongint;
               end;
             for i := 1 to n do t := t*10+b[i];
             for i := 0 to base do d[i] := maxw;
             d[s] := 0; upheap(s);
        end;
{***************************************************************************}
procedure main;
var i,j,u,v,tt,k : longint;
        begin
             fillchar(free,sizeof(free),true);
             khoitao;
             repeat
                  u := pop;
                  free[u] := false;
                  if u = t then
                    begin
                        res := d[u];
                        exit;
                    end;
                  tt := u;
                  for i := n downto 1 do
                     begin
                         a[i] := tt mod 10;
                         tt := tt div 10;
                     end;
                  for i := 1 to n-1 do
                    for j := i+1 to n do
                      begin
                          tt := 0;
                          swap(a[i],a[j]);
                          for k := 1 to n do tt := tt*10+a[k];
                          swap(a[i],a[j]);
                          if d[tt] > d[u] + c[i,j] then
                            begin
                                d[tt] := d[u] + c[i,j];
                                upheap(tt);
                            end;
                      end;
             until false;
        end;
{***************************************************************************}
begin
     nhap;
     main;
     writeln(res);
end.