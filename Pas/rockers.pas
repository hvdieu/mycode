uses math;
Const   maxn = 20;
Var     n,t,m   :       longint;
        a       :       array [1..maxn] of longint;
        f       :       array [0..maxn,0..maxn,0..maxn] of longint;

procedure nhap;
var i : longint;
        begin
            assign(input,'rockers.in'); reset(input);
            assign(output,'rockers.out'); rewrite(output);
            readln(n,t,m);
            for i := 1 to m do read(a[i]);
        end;

procedure main;
var i,j,k,i1,res : longint;
        begin
             for i := 1 to n do
               for j := 1 to m do
                for k := 0 to t do
                 if k >= a[i] then
                 begin
                    for i1 := 1 to i-1 do
                     f[i,j,k] := max(f[i,j,k],f[i1,j,k-a[i]]+1);
                 end;
             write(f[4,1,0],' ',f[3,2,1]);
             res := 0;
             for j := 1 to m do
              begin
                  temp := 0;

              end;
        end;

begin
     nhap;
     main;
end.