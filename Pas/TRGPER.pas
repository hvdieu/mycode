Const   inp = '';
        out = '';
        maxn = 5001;
        oo = 1000000007;

Var     fi,fo   :       text;
        n,k     :       longint;
        f       :       array [1..maxn,0..maxn] of longint;

procedure main;
var i,j : longint;
        begin
             f[1,1] := 1; f[1,0] := 0;
             f[2,1] := 2; f[2,2] := 0;
             f[2,0] := 0;
             for i := 3 to n do
               for j := 1 to k do
                f[i,j] := (int64(f[i-1,j-1]) * (i-2*(j-1)) mod oo + (int64(f[i-1,j])*j*2) mod oo) mod oo;
             writeln(fo,f[n,k]);
             close(fi); close(fo);
        end;

begin
      assign(fi,inp); reset(fi);
      assign(fo,out); rewrite(fo);
      readln(fi,n,k);
      main;
end.