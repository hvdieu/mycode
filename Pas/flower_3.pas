Var     m,n,k,t,res,p,x  : int64;
        i       :       longint;
        a       :       array [1..4] of int64;
begin
      assign(input,'flower.inp'); reset(input);
      assign(output,'flower.out'); rewrite(output);
      readln(m,n,k);
      p := 1000000007;
      a[1] := 4;
      x := 1 shl n - 2;
      x := (x*6) mod p;
      a[2] := x;
      t := 3;
      for i := 2 to n do t := (t*3) mod p;
      x := (1 shl n); x := x*3 + 3;
      x := (t-x+p*p) mod p;
      x := (x*4) mod p;
      a[3] := x;
      res := 4;
      for i := 2 to n do res := (res * 4) mod p;
      for i := 1 to k-1 do res := (res - a[i]+p*p) mod p;
      t := res;
      for i := 2 to m do res := (res * t) mod p;
      write(res);
      readln;
end.
