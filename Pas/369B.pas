Const   maxn = 1001;
Var     n,k,l,r,sall,sk,s1,s2,i : longint;
        a       :       array [1..maxn] of longint;

{******************************************************}
begin
 //    assign(input,'asd.inp'); reset(input);
  //   assign(output,'asd.out'); rewrite(output);
     readln(n,k,l,r,sall,sk);
     s1 := (sall-sk) div (n-k);
     a[k+1] := s1 + (sall-sk) mod (n-k);
     for i := k+2 to n do a[i] := s1;
     s2 := sk div k;
     a[1] := s2 + sk mod k;
     for i := 2 to k do a[i] := s2;
     for i := 1 to n do write(a[i],' ');
end.