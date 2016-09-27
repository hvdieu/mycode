Const   inp = 'COMNET.INP';
        out = 'COMNET.OUT';
        maxn = 100001;
        maxm = 1000001;

Var     m,n,ntest,q,s,t,p,k     :       longint;
        lab        :       array [1..maxn] of longint;
        u,v,w,c           :       array [1..maxm] of longint;

{**************************************************************************}
procedure union(r1,r2 : longint);
var x : longint;
        begin
            x := lab[r1]+lab[r2];
            if lab[r1] > lab[r2] then
              begin
                  lab[r1] := r2;
                  lab[r2] := x;
              end
            else
              begin
                  lab[r2] := r1;
                  lab[r1] := x;
              end;
        end;
{**************************************************************************}
function getroot(u : longint) : longint;
        begin
            while lab[u] > 0 do u := lab[u];
            exit(u);
        end;
{***************************************************************************}
procedure kruskal;
var i,j,r1,r2 : longint;
        begin
            for i := 1 to n do lab[i] := -1;
            for i := 1 to m do
             if i <> k then
               if w[i] < w[k] then
                 begin
                     r1 := getroot(u[i]); r2 := getroot(v[i]);
                     if r1 <> r2 then union(r1,r2);
                 end;
            r1 := getroot(u[k]); r2 := getroot(v[k]);
            if r1 = r2 then writeln('YES')
             else writeln('NO');
        end;
{**************************************************************************}
procedure main;
var i,j : longint;
        begin
            for i := 1 to q do
              begin
                  read(k,s);
                  for j := 1 to m do w[j] := c[j];
                  for j := 1 to s do
                    begin
                        read(t,p);
                        w[t] := p;
                    end;
                  kruskal;
              end;
        end;
{**************************************************************************}
procedure nhap;
var i : longint;
        begin
            // assign(input,inp); reset(input);
            // assign(output,out); rewrite(output);
             readln(ntest);
             while ntest > 0 do
               begin
                   dec(ntest);
                   readln(n,m,q);
                   for i := 1 to m do readln(u[i],v[i],c[i]);
                   main;
               end;
        end;
{***************************************************************************}
begin
     nhap;
end.
