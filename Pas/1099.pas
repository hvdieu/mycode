Const   maxn = 5010;
        maxm = 100010;
        maxw = 999999999;

Var     n,m,i,t,st,nheap,res      :       longint;
        head    :       array [1..maxn] of longint;
        heapi,heapj     :       array [1..2*maxn] of longint;
        d,pos       :       array [1..2,1..maxn] of longint;
        ke,next,w :       array [-maxm..maxm] of longint;
        free    :       array [1..2,1..maxn] of boolean;

{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure upheap(i,j : longint);
var cha,con : longint;
        begin
            con := pos[i,j];
            if con = 0 then
              begin
                  inc(nheap); heapi[nheap] := i; heapj[nheap] := j;
                  pos[i,j] := nheap;
                  con := nheap;
              end;
            repeat
               cha := con div 2;
               if (cha=0) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
               swap(heapi[cha],heapi[con]); swap(heapj[cha],heapj[con]);
               pos[heapi[cha],heapj[cha]] := cha;
               pos[heapi[con],heapj[con]] := con;
               con := cha;
            until false;
        end;
{***************************************************************************}
procedure pop;
var cha,con : longint;
        begin
            heapi[1] := heapi[nheap];  heapj[1] := heapj[nheap];
            pos[heapi[1],heapj[1]] := 1;
            dec(nheap); cha := 1;
            repeat
                con := cha*2;
                if (con < nheap) and (d[heapi[con],heapj[con]] > d[heapi[con+1],heapj[con+1]]) then inc(con);
                if (con > nheap) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
                swap(heapi[cha],heapi[con]); swap(heapj[cha],heapj[con]);
                pos[heapi[cha],heapj[cha]] := cha;
                pos[heapi[con],heapj[con]] := con;
                cha := con;
            until false;
        end;
{***************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
             fillchar(free,sizeof(free),true);
             for i := 1 to n do
               begin
                   d[1,i] := maxw;
                   d[2,i] := maxw;
               end;
             nheap := 0; fillchar(pos,sizeof(pos),0);
             d[1,1] := 0; upheap(1,1);
        end;
{***************************************************************************}
procedure main;
var i,j,u,v,alt,t : longint;
        begin
              repeat
                   t := heapi[1]; u := heapj[1];
                   pop;
                   if (u = n) and (t=2) then
                     begin
                         res := d[t,u];
                         break;
                     end;
                   free[t,u] := false;
                   j := head[u];
                   while j <> 0 do
                     begin
                        v := ke[j];
                        alt := d[t,u] + w[j];
                        if free[1,v] and free[2,v] and (d[1,v] > alt) then
                          begin
                            d[2,v] := d[1,v];
                            upheap(2,v);
                            d[1,v] := alt;
                            upheap(1,v);
                          end
                            else if free[2,v] and (d[1,v] < alt) and (d[2,v] > alt) then
                                begin
                                    d[2,v] := alt;
                                    upheap(2,v);
                                end;
                        j := next[j];
                     end;
              until false;
              writeln(res);
        end;
{***************************************************************************}
procedure nhap;
var i,j,u,v,l : longint;
        begin
            assign(input,'asd.inp'); reset(input);
            assign(output,'asd.out'); rewrite(output);
            readln(t);
            for st := 1 to t do
              begin
                  write('Case ',st,': ');
                  readln(n,m);
                  fillchar(head,sizeof(head),0);
                  for i := 1 to m do
                    begin
                       read(u,v,l);
                       ke[i] := v; next[i] := head[u]; w[i] := l; head[u] := i;
                       ke[-i] := u; next[-i] := head[v]; w[-i] := l; head[v] := -i;
                    end;
                  khoitao;
                  main;
              end;
        end;
{***************************************************************************}
begin
     nhap;
end.