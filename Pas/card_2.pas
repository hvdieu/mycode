Const   maxn = 401;
Var     n,c,i,temp,res     :       longint;
        x       :       array [1..4] of longint;
        free    :       array [1..4] of boolean;
        a       :       array [0..maxn] of longint;
        mau,gt,f  :       array [1..maxn] of longint;

procedure xuly;
var i,j : longint;
        begin
            temp := 1;
            for i := 1 to n*c do
              begin
                a[i] := x[mau[i]]*1000+gt[i];
                f[i] := 1;
              end;

            for i := 2 to n*c do
            begin
             for j := 1 to i-1 do
              if (f[i] < f[j] + 1) and (a[i] > a[j]) then f[i] := f[j]+1;
             if n*c-f[i] < res then res := n*c-f[i];
            end;

        end;

procedure ql(i : longint);
var j : longint;
        begin
            for j := 1 to c do
             if free[j] then
               begin
                   x[i] := j;
                   free[j] := false;
                   if i = c then xuly
                   else ql(i+1);
                   free[j] := true;
               end;
        end;

begin
      assign(input,'card.in'); reset(input);
      assign(output,'card.out'); rewrite(output);
      readln(c,n);
      for i := 1 to n*c do read(mau[i],gt[i]);
      fillchar(free,sizeof(free),true);
      res := maxlongint;
      ql(1);
      write(res);
end.