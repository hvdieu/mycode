Uses math;
Const   maxn = 201;
Var     f       :       array [1..maxn,-1..maxn,-1..maxn] of longint;
        i,k,j,n,t,res     :       longint;
        s       :       string;

function tinh(i,nho,bac : longint) : longint;
var sum : longint;
        begin

            if (nho > k) or (nho < 0) then
              begin
                  f[i,nho,bac] := 0;
                  exit(0);
              end;
            sum := 0;
            if f[i,nho,bac] > -1 then exit(f[i,nho,bac]);
            if (i > n) then
             if (nho=0) and (bac=k) then exit(1)
             else exit(0);
            if s[i] <> '(' then
              sum := sum + tinh(i+1,nho-1,max(bac,nho-1));
            if s[i] <> ')' then
              sum := sum + tinh(i+1,nho+1,max(bac,nho+1));
            f[i,nho,bac] := sum;
            exit(sum);
        end;

begin
     assign(input,'RESTORE2.INP'); reset(input);
     assign(output,'RESTORE2.OUT'); rewrite(output);
     readln(k);
     readln(s);
     for i := 1 to 200 do
       for j := -1 to 200 do
       for t := -1 to 200 do f[i,j,t] := -1;
     n := length(s);
     res := tinh(1,0,0);
     writeln(res);
end.