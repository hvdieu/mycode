{$INLINE ON}
Const   inp = 'vogcdsum.inp';
        out = 'vogcdsum.out';
        maxn = 100001;
        oo = 1000000007;

Var     n,vmax       :       longint;
        a       :       array [1..maxn] of int64;
        f       :       array [1..maxn,0..20] of int64;
        res     :       int64;

{**************************************************************************}
procedure nhap; inline;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n do read(a[i]);
        end;
{**************************************************************************}
procedure khoitao; inline;
var i,j : longint;
        begin
            for i := 1 to n do f[i,0] := a[i];
            vmax := round(ln(n)/ln(2));
        end;
{**************************************************************************}
function gcd(a,b : int64) : int64;
        begin
            if b = 0 then exit(a)
             else exit(gcd(b,a mod b));
        end;
{**************************************************************************}
procedure main; inline;
var i,j,last,vt,first,i1 : longint;
    x,y,alt : int64;
        begin
            for j := 1 to vmax do
              for i := 1 to n do
               if (i+1 shl (j-1) <= n) and (f[i+1 shl (j-1),j-1]<>0) then
                f[i,j] :=  gcd(f[i+1 shl (j-1),j-1],f[i,j-1]);

            for i := 1 to n do
              begin
                  last := i; x := a[i]; y := a[i];
                  i1 := i;
                  while i1 <= n do
                    begin
                        first := i1;
                        for j := vmax downto 1 do
                         if f[i1,j] <> 0 then
                         begin
                             alt := gcd(f[i1,j],y);
                             if alt=x then
                               begin
                                   y := alt;
                                   i1 := i1 + 1 shl j-1;
                               end;
                         end;
                        res := (res+x*(i1-first+1)) mod oo;
                        inc(i1); x := gcd(a[i1],x);
                    end;
              end;
            writeln(res);
        end;
{**************************************************************************}
begin
    nhap;
    if n = 0 then write(0) else begin
    khoitao;
    main;  end;
end.
