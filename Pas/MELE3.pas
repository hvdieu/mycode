Uses math;

Const   maxn = 1001;
        maxm = 50001;
        maxw = 999999999;

Var     n,m,nheap,res     :       longint;
        head,d,pos,heap    :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        ke,next :       array [-maxm..maxm] of longint;

{***************************************************************************}
procedure nhap;
var i,u,v : longint;
        begin
          // assign(input,'liftovi.ina'); reset(input);
         //  assign(output,'MELE3.OUT'); rewrite(output);
           readln(n,m);
           for i := 1 to m do
             begin
                 read(u,v);
                 ke[i] := v; next[i] := head[u]; head[u] := i;
                 ke[-i] := u; next[-i] := head[v]; head[v] := -i;
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
             pop := heap[1]; heap[1] := heap[nheap];
             pos[heap[1]] := 1; dec(nheap); cha := 1;
             repeat
                 con := cha*2;
                 if (con < nheap) and (d[heap[con]] > d[heap[con+1]]) then inc(con);
                 if (con > nheap) or (d[heap[cha]] <= d[heap[con]]) then break;
                 swap(heap[cha],heap[con]);
                 pos[heap[cha]] := cha; pos[heap[con]] := con;
                 cha := con;
             until false;
        end;
{****************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            fillchar(free,sizeof(free),true);
            for i := 2 to n do d[i] := maxw;
            upheap(1);
        end;
{***************************************************************************}
function chiphi(time,u,v : longint) : longint;
var temp,tt,x,y,tang : longint;
        begin
            x := u; y := v;
            if x > y then swap(x,y);
            temp := time mod (10*abs(u-v));
            if (temp > 0) and (temp <= 5*abs(u-v)) then tt := 1
             else
               begin
                 tt := 0;
                 temp := abs(temp-5*abs(u-v));
               end;
            if tt = 1 then tang := x+temp div 5
             else tang := y-temp div 5;
            if u < v then
              begin
                  if tt = 1 then exit((y-tang+y-x+y-x)*5)
                   else exit((tang-x+y-x)*5);
              end;

            if u > v then
              begin
                  if tt = 1 then exit((y-tang+y-x)*5)
                   else exit((tang-x+y-x+y-x)*5);
              end;
        end;
{***************************************************************************}
procedure main;
var i,j,u,v,alt : longint;
        begin
             repeat
                  u := pop;
                  if u = n then
                    begin
                        res := d[u];
                        break;
                    end;
                  free[u] := false;
                  j := head[u];
                  while j <> 0 do
                    begin
                        v := ke[j];
                        if free[v] then
                          begin
                              alt := d[u] + chiphi(d[u],u,v);
                              if d[v] > alt then
                                begin
                                    d[v] := alt;
                                    upheap(v);
                                end;
                          end;
                        j := next[j];
                    end;
             until false;
             writeln(res);
        end;
{***************************************************************************}
begin
     nhap;
     khoitao;
     main;
end.
