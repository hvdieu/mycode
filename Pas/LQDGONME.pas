Uses math;
Const   inp = '';
        out = '';
        maxn = 1001;

Var     a,pos       :       array [1..10,1..maxn] of longint;
        f       :   array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        res,m,n,i,j,k,dem,id,u,v :       longint;
{***************************************************************************}
function check(i,j : longint) : boolean;
var k : longint;
        begin
            for k := 2 to m do
             if pos[k,i] < pos[k,j] then exit(false);
            exit(true);
        end;
{****************************************************************************}
begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n,m);
     for i:= 1 to m do
       begin
          for j := 1 to n do
          begin
             read(a[i,j]);
             pos[i,a[i,j]] := j;
          end;
       end;
     for i := 1 to n do f[i] := 1;
     for i := 2 to n do
      for j := 1 to i-1 do
       if check(a[1,i],a[1,j]) then
       begin
         f[i] := max(f[j]+1,f[i]);
       end;
     for i := 1 to n do if f[i] > res then res := f[i];
     writeln(res);
end.