Uses math;
Const   inp = '';
        out = '';
        maxn = 601;
        oo = 1000000000;

Type    arr  = array [0..40] of longint;


Var     f       :       array [0..1,1..maxn] of arr;
        res     :       arr;
        k,n     :       longint;

{**************************************************************************}
procedure cong(var a,b : arr);
var
    i,j,x,l : longint;
    nho : longint;
        begin
            l := max(a[0],b[0]);
            nho := 0;
            for i := 1 to l do
              begin
                  if a[0] >= i then inc(nho,a[i]);
                  if b[0] >= i then inc(nho,b[i]);
                  a[i] := nho mod oo;
                  nho := nho div oo;
              end;
            a[0] := l;
            if nho <> 0 then
              begin
                  inc(a[0]); a[a[0]] := nho;
              end;
        end;
{**************************************************************************}
procedure ghi(c : arr);
var i : longint;
    s : string;
        begin
            write(c[c[0]]);
            for i := c[0]-1 downto 1 do
              begin
                  str(c[i],s);
                  while length(s) < 9 do s := '0'+s;
                  write(s);
              end;
        end;
{**************************************************************************}
procedure main;
var i,j,t,t1 : longint;
        begin
            f[1,1][1] := 2; f[1,1][0] := 1;
            t := 1;
            for i := 2 to n do
              begin
                  t1 := 1-t;
                  for j := 1 to k do f[t1,j][0] := 0;
                  for j := 1 to k do
                    begin
                        if j < k then cong(f[t1,j+1],f[t,j]);
                        cong(f[t1,1],f[t,j]);
                    end;
                  t := 1-t;
              end;
            res[0] := 1;
            res[1] := 0;
            for i := 1 to k do cong(res,f[t,i]);
            ghi(res);
        end;
{***************************************************************************}
begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n,k);
     main;
end.
