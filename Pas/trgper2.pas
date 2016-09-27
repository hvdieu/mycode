Const   inp = 'trgper.inp';
        out = 'trgper.out';
        maxn = 5001;

Var     fi,fo   :       text;
        f       :       array [0..maxn,0..maxn] of longint;
        n,k     :       longint;

procedure main;
var i,j : longint;
        begin
             f[1,0] := 0; f[1,1] := 1;
             f[2,1] := 2; f[2,2] := 0;
             for i := 3 to n do
              for j := 1 to k do
               f[i,j] := 2 + f[i-1,j-1] + f[i-1,j];
             write(fo,f[n,k]);
             close(fi); close(fo);
        end;

begin
      assign(fi,inp); reset(fi);
      assign(fo,out); rewrite(fo);
      readln(fi,n,k);
      main;
end.