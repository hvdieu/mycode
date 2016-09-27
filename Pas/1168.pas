Uses math;
Const   maxn = 1000;
        maxm = 10001;

Var     n,m,ntest,test,dem,count,top,count_in,count_out,c,dem2,count_io     :       longint;
        head,low,num,lab,st,deg_in,deg_out    :       array [0..maxn] of longint;
        ke,next :       array [0..maxm] of longint;
        dd      :       array [0..maxn] of boolean;

{*************************************************************************}
procedure khoitao;
        begin
            fillchar(head,sizeof(head),0);
            fillchar(low,sizeof(low),0);
            fillchar(num,sizeof(num),0);
            fillchar(lab,sizeof(lab),0);
            fillchar(deg_in,sizeof(deg_in),0);
            fillchar(deg_out,sizeof(deg_out),0);
            fillchar(dd,sizeof(dd),false);
            dem := 0; count := 0;
            count_in := 0; count_out := 0; c := 0;
            count_io := 0;
            dem2 := 0;
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
             n := 1000;
             for u := 0 to 0 do
             if dd[u] and (num[u] = 0) then
               begin
                   top := 0;
                   dfs(u);
               end;
             for i := 0 to n do
             if dd[i] and (num[i] <> 0) then
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
               end
             else if dd[i] and (num[i] = 0) then inc(dem2);
             if dem2 > 0 then
               begin
                   writeln('NO');
                   exit;
               end;
             if count = 1 then writeln('YES')
             else begin

             for u := 1 to count do
              begin
                  if (deg_in[u] = 0) and (deg_out[u]=1) then inc(count_in);
                  if (deg_out[u] = 0) and (deg_in[u]=1) then inc(count_out);
                  if (deg_in[u]=1) and (deg_out[u]=1) then inc(count_io);
              end;
             if (count_in=1) and (count_out=1) and (count_in+count_out+count_io=count) then writeln('YES')
              else writeln('NO');
             end;
        end;
{**************************************************************************}
procedure nhap;
var i,u,v,j        :       longint;
        begin
        //   assign(input,'asd.inp'); reset(input);
        //   assign(output,'asd.out'); rewrite(output);
             readln(ntest);
             for test := 1 to ntest do
               begin
                   write('Case ',test,': ');
                   read(n);
                   khoitao;
                   for j := 1 to n do
                   begin
                   readln(m);
                   for i := 1 to m do
                     begin
                        read(u,v);
                        dd[u] := true; dd[v] := true;
                        inc(c);
                        ke[c] := v; next[c] := head[u]; head[u] := c;
                     end;
                   end;
                   main;
               end;
        end;
{*************************************************************************}
begin
     nhap;
end.