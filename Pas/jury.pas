Const   maxn = 201;
        maxm = 21;
Var     a       :       array [1..maxn] of longint;
        f       :       array [0..maxm,0..maxn,-500..500] of boolean;
        i,j,n,m,x,y,t,res :       longint;

procedure main;
var i,j : longint;
        begin
              fillchar(f,sizeof(f),false);
              for i := 1 to n do f[1,i,a[i]] := true;
              for i := 2 to n do
                for t := -400 to 400 do
                 if f[1,i-1,t] = true then f[1,i,t] := true;

              for i := 2 to m do
                for j := i to n do
                 for t := -400 to 400 do
                   begin
                       if (f[i-1,j-1,t-a[j]]=true) or (f[i,j-1,t]=true) then
                         f[i,j,t] := true;
                   end;
               res := maxlongint;
               for t := -400 to 400 do
                  if f[m,n,t] = true then
                   if res > abs(t) then res := abs(t);
               writeln(res);
        end;

begin
       assign(input,'JURY.INP'); reset(input);
       assign(output,'JURY.OUT'); rewrite(output);
       readln(n,m);
       for i := 1 to n do
         begin
             readln(x,y);
             a[i] := x-y;
         end;
       main;
end.
