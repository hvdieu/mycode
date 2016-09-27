Const   maxn = 10001;
        maxm = 50001;
        maxw = 999999999;

Var     n,m,s,t,p,ntest,test,res,rear,front,mid,nheap       :       longint;
        head,d,heap,pos    :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        ke,next,w       :       array [1..maxm] of longint;

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
{****************************************************************************}
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
{***************************************************************************}
function Dij(x : longint) : boolean;
var i,j,u,v : longint;
        begin
             fillchar(pos,sizeof(pos),0);
             for i := 1 to n do d[i] := maxw;
             fillchar(Free,sizeof(Free),true);
             nheap := 1; heap[1] := 1; pos[1] := 1;
             d[s] := 0;
             repeat
                 if nheap = 0 then break;
                 u := pop;
                 free[u] := false; j := head[u];
                 while j <> 0 do
                   begin
                       v := ke[j];
                       if free[v] and (w[j] <= x) and (d[v] > d[u] + w[j]) then
                         begin
                             d[v] := d[u] + w[j];
                             upheap(v);
                         end;
                       j := next[j];
                   end;
             until false;
             if d[t] <= p then exit(true)
              else exit(false);
        end;
{***************************************************************************}
procedure main;
        begin
                rear := 0; front := p;
                res := -1;
                while rear <= front do
                  begin
                      mid := (rear+front) shr 1;
                      if Dij(mid) then
                        begin
                            res := mid;
                            front := mid - 1;
                        end
                      else rear := mid + 1;
                  end;
                writeln(res);
        end;
{***************************************************************************}
procedure nhap;
var i,u,v,l : longint;
        begin
             assign(input,'asd.inp'); reset(input);
             assign(output,'asd.out'); rewrite(output);
             readln(ntest);
             for test := 1 to ntest do
               begin
                   write('Case ',test,': ');
                   readln(n,m,s,t,p);
                   fillchar(head,sizeof(head),0);
                   for i := 1 to m do
                     begin
                         read(u,v,l);
                         ke[i] := v; w[i] := l; next[i] := head[u]; head[u] := i;
                     end;
                   main;
               end;
        end;
{***************************************************************************}
begin
      nhap;
end.