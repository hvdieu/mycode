Uses math;
Const   inp = '';
        out = '';
        maxn = 31;

Var     n,ntest,i,j,k,res       :       longint;
        a,s       :       array [0..maxn,0..maxn,0..maxn] of longint;

procedure Init;
var i,j,k : longint;
  begin
      res := -maxlongint;
      for i := 1 to n do
       for j := 1 to n do
        for k := 1 to n do
         s[i,j,k] := s[i,j,k-1]+s[i,j-1,k]+s[i-1,j,k]+s[i-1,j-1,k-1]
                    -s[i-1,j-1,k]-s[i-1,j,k-1]-s[i,j-1,k-1]+a[i,j,k];
  end;

function sum(u,v,t,i,j,k : longint) : longint;
  begin
      sum := s[i,j,k]+s[u-1,v-1,k]+s[u-1,j,t-1]+s[i,v-1,t-1]-s[i,j,t-1]-s[i,v-1,k]-s[u-1,j,k]-s[u-1,v-1,t-1];
  end;

procedure Main;
var i,j,k,m : longint;
  begin
      for m := 1 to n do
        begin
            for i := m to n do
             for j := m to n do
              for k := m to n do
               res := max(res,sum(i-m+1,j-m+1,k-m+1,i,j,k));
        end;
      writeln(res);
  end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(ntest);
    while ntest > 0 do
      begin
          dec(ntest);
          fillchar(a,sizeof(a),0);
          fillchar(s,sizeof(s),0);
          readln(n);
          for i := 1 to n do
           for j := 1 to n do
            for k := 1 to n do read(a[i,j,k]);
          Init;
          Main;
      end;
end.
