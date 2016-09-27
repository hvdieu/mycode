Uses math;
Const   maxn = 2000010;
	oo = 1000000007;
Var     n,i,top,dem,m,lmax,x     :       longint;
        next,l,p,g :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        res     :       qword;

{***************************************************************************}
procedure sangngto;
var i,j : longint;
        begin
            fillchar(p,sizeof(p),0);
            for i := 2 to trunc(sqrt(lmax)) do
              if p[i]=0 then
                begin
                    j := i*i;
                    while j <= lmax do
                      begin
                          p[j] := i;
                          j := j + i;
                      end;
                end;
        end;
{***************************************************************************}
function mu(x,i : longint) : int64;
var temp : int64;
        begin
            if i = 1 then exit(x);
            temp := mu(x,i div 2) mod oo;
            if i mod 2 = 0 then exit((temp*temp) mod oo)
             else exit((temp*temp*x) mod oo);
        end;
{***************************************************************************}
procedure main;
var i,j,x,u,v : longint;
        begin
             fillchar(free,sizeof(free),true);
             for u := 1 to n do
               if free[u] then
                 begin
                     dem := 1;
                     v := next[u];
                     while u <> v do
                       begin
                           inc(dem);
                           v := next[v];
                       end;
                     inc(m); l[m] := dem; lmax := max(l[m],lmax);
                 end;
             sangngto;
             for i := 1 to m do
               begin
                  x := l[i];
                  while p[x] > 0 do
                    begin
                        j := p[x]; dem := 0;
                        while x mod j = 0 do
                          begin
                              x := x div j;
                              inc(dem);
                          end;
                        g[j] := max(g[j],dem);
                    end;
                  if x > 1 then g[x] := max(g[x],1);
               end;
             res := 1;
             for i := 2 to lmax do
               if (p[i] = 0) and (g[i] > 0) then
                 res := (res*mu(i,g[i])) mod oo;
             writeln(res);
        end;
{***************************************************************************}
begin
    assign(input,'asd.inp'); reset(input);
     assign(output,'asd.out'); rewrite(output);
     readln(n);
     for i := 1 to n do
       begin
         read(x);
         next[i] := x;
       end;
     main;
end.


