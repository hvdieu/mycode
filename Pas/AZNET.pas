Const   inp = '';
        out = '';
        maxn = 10001;
        maxm = 100001;

Var     n,m,ntest,min,max,k,res     :       longint;
        x,y,id :       array [1..2,1..maxm] of longint;
        lab :       array [1..2,1..maxn] of longint;
        sl      :   array [1..2] of longint;
        a,b :       array [0..maxn] of longint;
{***************************************************************************}
function getroot(t,u : longint) : longint;
  begin
      while lab[t,u] > 0 do u := lab[t,u];
      exit(u);
  end;
{***************************************************************************}
procedure union(t,r1,r2 : longint);
var x : longint;
  begin
      x := lab[t,r1]+lab[t,r2];
      if lab[t,r1] > lab[t,r2] then
       begin
           lab[t,r1] := r2;
           lab[t,r2] := x;
       end
      else begin
               lab[t,r2] := r1;
               lab[t,r1] := x;
           end;
  end;
{****************************************************************************}
procedure main;
var i,j,dem,u,v,r1,r2,r3,r4 : longint;
  begin
      for i := 1 to n do
        begin
            lab[1,i] := -1;
            lab[2,i] := -1;
        end;
      max := 0;
      for i := 1 to sl[1] do
        begin
           u := x[1,i]; v := y[1,i];
           r1 := getroot(1,u); r2 := getroot(1,v);
           if r1 <> r2 then
             begin
                 inc(max);
                 union(1,r1,r2);
             end;
        end;
      min := 0;
      for i := 1 to sl[2] do
        begin
            u := x[2,i]; v := y[2,i];
            r1 := getroot(1,u); r2 := getroot(1,v);
            if r1 <> r2 then
              begin
                inc(min);
                union(1,r1,r2);
                r3 := getroot(2,u); r4 := getroot(2,v);
                union(2,r3,r4);
              end;
        end;
      for i := 1 to sl[2] do
        begin
            u := x[2,i]; v := y[2,i];
            r1 := getroot(2,u); r2 := getroot(2,v);
            if r1 <> r2 then
              begin
                  inc(min);
                  union(2,r1,r2);
              end;
        end;
      min := n-1-min;
      res := maxlongint;
      for i := min to max do
        if a[i]+b[n-1-i] < res then
          begin
              res := a[i]+b[n-1-i];
              k := i;
          end;
      for i := 1 to n do
        begin
            lab[1,i] := -1; lab[2,i] := -1;
        end;
      for i := 1 to sl[1] do
        begin
           u := x[1,i]; v := y[1,i];
           r1 := getroot(1,u); r2 := getroot(1,v);
           if r1 <> r2 then union(1,r1,r2);
        end;
      dem := 0;
      for i := 1 to sl[2] do
        begin
            u := x[2,i]; v := y[2,i];
            r1 := getroot(1,u); r2 := getroot(1,v);
            if r1 <> r2 then
              begin
                write(id[2,i],' ');
                inc(dem);
                union(1,r1,r2);
                r3 := getroot(2,u); r4 := getroot(2,v);
                union(2,r3,r4);
              end;
        end;
      if dem < n-1-k then
        begin
           for i := 1 to sl[2] do
            begin
                u := x[2,i]; v := y[2,i];
                r1 := getroot(2,u); r2 := getroot(2,v);
                if r1 <> r2 then
                 begin
                     inc(dem);
                     write(id[2,i],' ');
                     union(2,r1,r2);
                     if dem=n-1-k then break;
                 end;
            end;
        end;
      for i := 1 to sl[1] do
        begin
          u := x[1,i]; v := y[1,i];
          r1 := getroot(2,u); r2 := getroot(2,v);
          if r1 <> r2 then
            begin
                write(id[1,i],' ');
                union(2,r1,r2);
            end;
        end;
      writeln;
  end;
{***************************************************************************}
procedure nhap;
var i,j,u,v,k : longint;
  begin
      assign(input,inp); reset(input);
      assign(output,out); rewrite(output);
      readln(ntest);
      while ntest > 0 do
       begin
           dec(ntest);
           readln(n,m);
           for i := 1 to n-1 do read(a[i]);
           for i := 1 to n-1 do read(b[i]);
           sl[1] := 0; sl[2] := 0;
           for i := 1 to m do
             begin
                 readln(u,v,k);
                 inc(sl[k]);
                 x[k,sl[k]] := u; y[k,sl[k]] := v;
                 id[k,sl[k]] := i;
             end;
           main;
       end;
  end;
{****************************************************************************}
begin
     nhap;
end.