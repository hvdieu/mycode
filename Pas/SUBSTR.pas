{$H+}
Const   inp = '';
        out = '';
        maxn = 1000001;

Var     n,m     :       longint;
        a,x     :       string;
        next    :       array [1..maxn] of longint;

procedure Init;
var i,j : longint;
  begin
      next[1] := 0;
      for i := 2 to m do
        begin
            j := next[i-1];
            while (j>0) and (x[i]<>x[j+1]) do
              j := next[j];
            if x[i]=x[j+1] then next[i] := j+1 else next[i] := 0;
        end;
  end;

procedure main;
var i,j : longint;
  begin
     j := 0;
     for i := 1 to n do
       begin
         while (j>0) and (a[i]<>x[j+1]) do j := next[j];
         if a[i]=x[j+1] then inc(j);
         if j=m then
           begin
               write(i-j+1,' ');
               j := next[j];
           end;
       end;
  end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(a); readln(x);
     m := length(x); n := length(a);
     init;
     main;
end.

