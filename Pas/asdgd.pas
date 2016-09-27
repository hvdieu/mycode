
Const   maxn = 101;

Var     n,k,i,res,j     : longint;
        a       : array [1..maxn] of longint;
        dem     : array [1..maxn,1..2] of longint;

function min(var xx,yy : longint) : longint;
        begin
            if xx <= yy then exit(xx)
             else exit(yy);
        end;

begin
   //  assign(input,'asd.inp'); reset(input);
   //  assign(output,'asd.out'); rewrite(output);
     readln(n,k);
     for i := 1 to n do read(a[i]);
     for i := 1 to k do
       begin
           j := i;
           while j <= n do
             begin
                 inc(dem[i,a[j]]);
                 j := j + k;
             end;
       end;
     for i := 1 to k do
       res := res + min(dem[i,1],dem[i,2]);
     writeln(Res);
end.