Const   maxn = 100005;
Var     n,l,r,ql,qr,trai,phai,res,t,i         :    longint;
        a,s       :       array [0..maxn] of longint;

begin
     // assign(input,'asd.inp'); reset(input);
     // assign(output,'asd.out'); rewrite(output);
      readln(n,l,r,ql,qr);
      for i := 1 to n do read(a[i]);
      res := maxlongint;
      for i := 1 to n do s[i] := s[i-1] + a[i];
      for i := 0 to n do
        begin
             trai := i; phai := n-i;
             if (trai = phai) then
               begin
                    t := s[i]*l + (s[n] - s[i])*r;
                    if t < res then res := t;
               end
             else if trai < phai then
               begin
                   t := s[i]*l + (s[n] - s[i])*r + (phai-trai-1)*qr;
                   if t < res then res := t;
               end
             else if trai > phai then
               begin
                   t := s[i]*l +(s[n]-s[i])*r + (trai-phai-1)*ql;
                   if t < res then res := t;
               end;
        end;
      write(res);
end.