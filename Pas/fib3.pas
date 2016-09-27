Uses math;

Type    arr = array [1..3,1..3] of longint;

Var     a,b,c,k : int64;
        m,n,p,t,tt : longint;
        a1,b1,c1,x,res,x1        :       arr;
        f       :       array [0..6] of longint;

operator *(a,b : arr) c : arr;
var i,j,kt : longint;
        begin
              for i := 1 to m do
                for j := 1 to p do
                  begin
                      c[i,j] := 0;
                      for kt := 1 to n do
                       c[i,j] := (c[i,j] + int64(a[i,kt])*b[kt,j]) mod k;
                  end;
        end;

procedure khoitao;
var i,j : longint;
        begin
             fillchar(a1,sizeof(a1),0);
             a1[2,1] := 1; a1[3,2] := 1;
             b1 := a1; c1 := a1;
             a1[1,3] := c; a1[2,3] := b; a1[3,3] := a;
             b1[1,3] := a; b1[2,3] := c; b1[3,3] := b;
             c1[1,3] := b; c1[2,3] := a; c1[3,3] := c;
             x := a1*b1;
             x := x*c1;
             f[1] := 1; f[2] := 2 mod k; f[3] := 3 mod k;
             f[4] := (a*f[3] mod k + b*f[2] mod k + c*f[1] mod k) mod k;
             f[5] := (b*f[4] mod k + c*f[3] mod k + a*f[2] mod k) mod k;
             f[6] := (c*f[5] mod k + a*f[4] mod k + b*f[3] mod k) mod k;
        end;

function mu(a : arr; nn : longint) : arr;
var temp : arr;
        begin
             if nn = 1 then exit(a)
             else
             begin
             temp := mu(a,nn div 2);
             if nn mod 2 = 0 then exit(temp*temp)
              else exit(temp*temp*a);
             end;
        end;

begin
       assign(input,'fib3.inp'); reset(input);
       assign(output,'fib3.ou1'); rewrite(output);
       while not eof(input) do
       begin
       readln(a,b,c,k,tt);
       a := a mod k; b := b mod k; c := c mod k;
       m := 3; n := 3; p := 3;
       khoitao;
       if tt <= 6 then writeln(f[tt])
        else
         begin
             t := tt div 3-1;
             if tt mod 3 <> 0 then inc(t);
             x1[1,1] := 1; x1[1,2] := 2; x1[1,3] := 3;
             res := mu(x,t);
             m := 1;
             res := x1 * res;
             if tt mod 3 = 0 then writeln(res[1,3])
              else writeln(res[1,tt mod 3]);
         end;
       end;
end.
