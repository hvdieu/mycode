uses math;
Const   maxn = 2001;
Var     n,top,n1,j,i       :       longint;
        a,b     :       array [1..maxn] of real;
        st      :       array [1..2] of real;
        x,res,temp       :       double;

procedure swap(var xx,yy : real);
var temp  : real;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j : longint;
    key : real;
        begin
            if l >= h then exit;
            i := l; j := h;
            key := a[(l+h) div 2];
            repeat
                while a[i] < key do inc(i);
                while a[j] > key do dec(j);
                if i <= j then
                  begin
                      swap(a[i],a[j]);
                      swap(b[i],b[j]);
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

begin
   //  assign(input,'c.inp'); reset(input);
   //  assign(output,'c.out'); rewrite(output);
     readln(n);
     for i := 1 to 2*n do
      begin
          read(x);
          if trunc(x) = x then
            begin
                inc(top);

            end
          else
            begin
                inc(n1); a[n1] := trunc(x)-x;
                b[n1] := trunc(x)+1 - x;
            end;
      end;
     if top mod 2 = 1 then
       begin
           inc(n1); a[n1] := 0; b[n1] := 0;
       end;
       j := n1+1;
     sort(1,n1);
     if a[n1] = 0 then
       begin
           temp := 0;
           res := maxlongint;
           j := n1-1;
           for i := 1 to (n1-2) div 2 do
             begin
                 dec(j);
                 temp := temp + a[i] + b[j];
             end;
           res := min(abs(temp + a[n1-1]),abs(temp+b[n1-1]));
           temp := 0;
           j := n1;
           for i := 2 to n1 div 2 do
            begin
                dec(j);
                temp := temp + a[i] + b[j];
            end;
           res := min(abs(temp + a[1]), abs(temp+b[1]));
       end
     else
     begin
     for i := 1 to n1 div 2 do
       begin
           dec(j);
           res := res + a[i] + b[j];
       end;
     end;
     res := abs(res) - trunc(abs(res));
     writeln(min(res,1-res):0:3);
end.