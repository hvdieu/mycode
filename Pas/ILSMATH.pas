
Const   inp = '';
        out = '';
Var     fi,fo : text;
        n,res : longint;
        kq      :       array [1..100] of longint;
        i,d,c,mid : longint;
        s,k,x,e,base : extended;

Function log(x : extended) : extended;
        BEGIN
             log := ln(x) / ln(10);
        END;

Function tinh(n : longint) : extended;
Var k,a,b : extended;
        BEGIN
             a := log(sqrt(2*pi*n));
             b := n * log(n/e);
             tinh := a + b;
        END;

BEGIN
      assign(fi,inp); reset(fi);
      assign(fo,out); rewrite(fo);
      readln(fi,n);
      res := 0;
      i := 0; s := 0;
      e := exp(1);
      base := ln(10);
      if n <= 1000000 then
      BEGIN
      Repeat
         inc(i);
         k := ln(i)/ln(10);
         s := s + k;
         if (s >= n-1) and (s <= n) then
           BEGIN
                inc(res);
                kq[res] := i;
           END;
         if s > n + 2 then break;
      until false;

      if res = 0 then write(fo,'NO')
      else
      BEGIN
      writeln(fo,res);
      for i := 1 to res do writeln(fo,kq[i]);
      END;
      END
        else
      BEGIN
           d := 1; c := 1000000000;
           While d <= c do
             BEGIN
                   mid := (d+c) div 2;
                   x := tinh(mid);
                   if (x >= n-1) and (x <= n) then
                      BEGIN
                           res := mid;
                           break;
                      END
                        else if x < n-1 then d := mid + 1
                          else c := mid - 1;
             END;
           if res = 0 then write(fo,'NO')
            else
              BEGIN
                writeln(fo,1);
                write(fo,res);
              END;
      END;
      close(fo);

END.
