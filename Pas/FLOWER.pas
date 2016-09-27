Const   inp = 'FLOWER.IN8';
        out = 'FLOWER.OUT';
        maxn = 50;
        oo = 1000000007;
Var     fi,fo   :       text;
        m,n,k,i   :       integer;
        c       :       array [0..4] of int64;
        res,temp     :       int64;

Function pow(a,b : longint) : int64;
var i : longint;
    s : int64;
        begin
             s := 1;
             for i := 1 to b do
               s := (s * a) mod oo;
             exit(s);
        end;

begin
      assign(fi,inp); reset(fi);
      readln(fi,m,n,k);
      close(fi);
      c[1] := 1;
      c[2] := (pow(2,n) - 2 +oo*oo) mod oo;
      c[3] := (pow(3,n) - 3*c[2] - 3*c[1] + oo*oo) mod oo;
      c[4] := (pow(4,n) - 4*c[3] - 6*c[2]- 4*c[1] + oo*oo) mod oo;
      c[1] := (c[1] * 4) mod oo;
      c[2] := (c[2] * 6) mod oo;
      c[3] := (c[3] * 4) mod oo;
      res := 0;
      for i := k to 4 do res := (res + c[i]) mod oo;
      res := pow(res,m);
      assign(fo,out); rewrite(fo);
      write(fo,res);
      close(fo);

end.

