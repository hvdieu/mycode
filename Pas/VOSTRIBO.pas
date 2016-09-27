Uses math;
Const
    inp = 'VOSTRIBO.INP';
    out = 'VOSTRIBO.OUT';
    maxn = 4;
    b : array [1..4] of array [1..4] of int64 =
    ((0,0,1,1),
     (1,0,1,1),
     (0,1,1,1),
     (0,0,0,1));

Type arr = array [1..4] of array [1..4] of int64;

Var
    ntest,n,i : longint;
    a,c : arr;
    oo : int64;

function bigmod(a,b : int64) : int64;
    var temp : int64;
begin
    if b=0 then exit(0);
    if b=1 then exit(a mod oo);
    temp := bigmod(a,b div 2);
    if b mod 2=0 then exit((temp+temp) mod oo)
     else exit((temp+temp+a) mod oo);
end;

function nhan(a,b : arr) : arr;
    var i,j,k : longint;
        c : arr;
begin
    for i := 1 to 4 do
     for j := 1 to 4 do
      begin
          c[i][j] := 0;
          for k := 1 to 4 do
           c[i][j] := (c[i][j]+bigmod(a[i][k],b[k][j])) mod oo;
      end;
     exit(c);
end;

function mu(a : arr;x : longint) : arr;
    var t1,t2 : arr;
begin
    if x=1 then exit(a);
    t1 := mu(a,x div 2);
    t2 := nhan(t1,t1);
    if x mod 2=0 then exit(t2)
     else exit(nhan(t2,a));
end;

begin
     assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
     readln(ntest);
     oo := round(1e15)+7;
     while ntest > 0 do
       begin
           dec(ntest);
           readln(n);
           if n<=3 then
             begin
                 if n=1 then writeln(1)
                  else if n=2 then writeln(3)
                   else writeln(6);
             end
           else begin
               a[1][1] := 1; a[1][2] := 2; a[1][3] := 3; a[1][4] := 6;
               c := mu(b,n-3);
              // for i := 1 to n-3 do a := nhan(a,b);
               a := nhan(a,c);
               writeln(a[1][4]);
           end;
       end;
end.
