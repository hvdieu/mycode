uses math;
Const
    inp = 'a.inp';
    out = 'a.out';
    maxn = 1000000;
    oo = 5000000;

var
    n,k,d,c,mid : longint;
    dd : array [1..oo] of boolean;

function gcd(a,b : longint) : longint;
begin
    if b=0 then exit(a)
    else exit(gcd(b,a mod b));
end;

function check(x : longint) : boolean;
    var i,bound,res,prev,last,dem : longint;
begin
    fillchar(dd,sizeof(dd),true);
    res := 0; prev := 0;
    bound := (x div k)*k;
    repeat
        prev := res; last := -1;
        dem := 0;
        while bound > 0 do
          begin
              if free[
          end;
    until false;
end;

begin
    assign(input,inp) ;reseT(input);
    assign(output,out); rewrite(output);
    readln(n,k);
    d := 1; c := oo;
    while d <= c do
      begin
          mid := (d+c) shr 1;
          if check(mid) then
            begin
                ans := mid;
                c := mid-1;
            end
          else d := mid+1;
      end;
end.
