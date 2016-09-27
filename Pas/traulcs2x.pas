Uses math;
Const   inp = 'lcs2x.inp';
        out = 'lcs2x.ou1';
        maxn = 1510;

Var     m,n,i,j,ntest,res,k     :       longint;
        a,b,st    :       array [0..maxn] of longint;
        f,g    :       array [0..maxn,0..maxn] of longint;

{***************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            fillchar(f,sizeof(f),0);
            fillchar(g,sizeof(g),0);
            fillchar(st,sizeof(st),0);
            k := 0; st[0] := 0;
            for i := 1 to m do
             for j := 1 to n do g[i,j] := maxlongint;
        end;
{***************************************************************************}
procedure sub2;
var i,j,i1,j1 : longint;
        begin
            res := 0;
            for i := 1 to m do
             for j := 1 to n do
             begin
              if a[i]=b[j] then
               for i1 := 0 to i-1 do
                for j1 := 0 to j-1 do
                 if (a[i1]=b[j1]) and (2*a[i1]<=a[i]) then
                  f[i,j] := max(f[i,j],f[i1,j1]+1);
              if f[i,j] > res then res := f[i,j];
             end;
             writeln(res);
        end;
{***************************************************************************}
begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(ntest);
     while ntest > 0 do
       begin
           dec(ntest);
           readln(m,n);
           for i := 1 to m do read(a[i]);
           for i := 1 to n do read(b[i]);
           khoitao;
           sub2;
          //   else
         //  sub3;
       end;
end.


