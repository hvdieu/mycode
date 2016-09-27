Uses math;
Const   maxn = 20001;
        maxm = 50001;

Var     n,m,ntest,test,dem,count,top,count_in,count_out     :       longint;
        head,low,num,lab,st,deg_in,deg_out    :       array [1..maxn] of longint;
        ke,next :       array [1..maxm] of longint;

{*************************************************************************}
procedure khoitao;
        begin
            fillchar(head,sizeof(head),0);
            fillchar(low,sizeof(low),0);
            fillchar(num,sizeof(num),0);
            fillchar(lab,sizeof(lab),0);
            fillchar(deg_in,sizeof(deg_in),0);
            fillchar(deg_out,sizeof(deg_out),0);
            dem := 0; count := 0;
            count_in := 0; count_out := 0;
        end;
{*************************************************************************}
procedure dfs(u : longint);
var j,v : longint;
        begin
             inc(dem); num[u] := dem; low[u] := dem;
             j := head[u]; inc(top); st[top] := u;
             while j <> 0 do
               begin
                   v := ke[j];
                   if lab[v] = 0 then
                     begin
                         if num[v] = 0 then
                           begin
                              dfs(v);
                              low[u] := min(low[u],low[v]);
                           end
                         else low[u] := min(low[u],num[v]);
                     end;
                   j := next[j];
               end;
             if low[u] = num[u] then
               begin
                   inc(count); lab[u] := count;
                   repeat
                      v := st[top]; dec(top);
                      lab[v] := count;
                   until u = v;
               end;
        end;
{**************************************************************************}
procedure main;
var u,v,i,j : longint;
        begin
             for u := 1 to n do
             if num[u] = 0 then
               begin
                   top := 0;
                   dfs(u);
               end;
             for i := 1 to n do
               begin
                   j := head[i];
                   while j <> 0 do
                     begin
                         u := lab[i]; v := lab[ke[j]];
                         if u <> v then
                           begin
                               inc(deg_out[u]); inc(deg_in[v]);
                           end;
                         j := next[j];
                     end;
               end;
             if count = 1 then writeln(0)
             else begin

             for u := 1 to count do
              begin
                  if deg_in[u] = 0 then inc(count_in);
                  if deg_out[u] = 0 then inc(count_out);
              end;
             writeln(max(count_in,count_out));

             end;
        end;
{**************************************************************************}
procedure nhap;
var i,u,v        :       longint;
        begin
           //  assign(input,'asd.inp'); reset(input);
           //  assign(output,'asd.out'); rewrite(output);
             readln(ntest);
             for test := 1 to ntest do
               begin
                   write('Case ',test,': ');
                   read(n,m);
                   khoitao;
                   for i := 1 to m do
                     begin
                        read(u,v);
                        ke[i] := v; next[i] := head[u]; head[u] := i;
                     end;
                   main;
               end;
        end;
{*************************************************************************}
begin
     nhap;
end.