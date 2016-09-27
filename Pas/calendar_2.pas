Uses math;
Const   maxn = 100001;
Var     a,b,pos,d     :       array [0..2*maxn] of longint;
        free    :       array [1..maxn] of boolean;
        i,n,dem,res,temp     :       longint;

begin
     assign(input,'CALENDAR.INP'); reset(input);
     assign(output,'CALENDAR.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n do
      begin
          read(a[i]); pos[a[i]] := i;
      end;
     for i := 1 to n do
      begin
          read(b[i]);
          temp := pos[b[i]] - i;
          if temp < 0 then temp := n + temp;
          inc(d[temp]);
      end;
     for i := 0 to n do res := max(res,d[i]);
     writeln(res);
end.
